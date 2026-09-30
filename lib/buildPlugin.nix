{ pkgs, inputs, plugins, lib ? pkgs.lib, ... }:

final: prev:

with lib;
with builtins;

let
  inherit (prev.vimUtils) buildVimPlugin;

  ts = prev.tree-sitter.overrideAttrs (old: {
    grammars = old.grammars.override {
      tree-sitter-scala = final.tree-sitter-scala-master;
    };
  });

  telescopeFixupHook = ''
    substituteInPlace $out/scripts/vimg \
      --replace "chafa" "${pkgs.chafa}/bin/chafa"
    substituteInPlace $out/lua/telescope/_extensions/media_files.lua \
      --replace "M.base_directory .. '/scripts/vimg'" "'$out/scripts/vimg'"
  '';

  # sync nvim-treesitter queries and parsers
  tsPreFixupHook = ''
    mkdir -p $out/queries
    mkdir -p $out/queries/scala
    mkdir -p $out/queries/smithy
    cp ${inputs.tree-sitter-scala}/queries/* $out/queries/scala/
    cp ${ts.builtGrammars.tree-sitter-smithy}/queries/highlights.scm $out/queries/smithy/highlights.scm

    mkdir -p $out/parser
    cp ${ts.builtGrammars.tree-sitter-nix}/parser $out/parser/nix.so
    cp ${ts.builtGrammars.tree-sitter-scala}/parser $out/parser/scala.so
    cp ${ts.builtGrammars.tree-sitter-smithy}/parser $out/parser/smithy.so
  '';

  # following https://github.com/NixOS/nixpkgs/blob/d86ae899d2909c0899e4d3b29d90d5309771e77c/pkgs/applications/editors/vim/plugins/overrides.nix#L139
  buildPlug = name: grammars:
    let overrides = (final.callPackage ./plugins/overrides.nix { }) { p = name; };
    in buildVimPlugin {
      inherit name;
      inherit (overrides) checkInputs dependencies nvimRequireCheck nvimSkipModule;

      version = "main";
      src = lib.getAttr name inputs;

      doInstallCheck = false;

      preFixup = ''
        ${writeIf (name == "nvim-treesitter") tsPreFixupHook}
        ${writeIf (name == "telescope-media-files") telescopeFixupHook}
      '';
    };

  # override at use site with your own preferences
  treesitterGrammars = t: t.withPlugins (p: [
    p.tree-sitter-scala
    p.tree-sitter-nix
    p.tree-sitter-lua
    p.tree-sitter-elm
    p.tree-sitter-haskell
    p.tree-sitter-markdown
    p.tree-sitter-markdown-inline
    p.tree-sitter-smithy
  ]);
in
{
  inherit treesitterGrammars;

  neovimPlugins =
    let
      tg = treesitterGrammars ts;
    in
      listToAttrs (map (n: nameValuePair n (buildPlug n tg)) plugins);
}
