{ pkgs, inputs, plugins, lib ? pkgs.lib, ... }:

final: prev:

with lib;
with builtins;

let
  inherit (prev.vimUtils) buildVimPlugin;

  telescopeFixupHook = ''
    substituteInPlace $out/scripts/vimg \
      --replace "chafa" "${pkgs.chafa}/bin/chafa"
    substituteInPlace $out/lua/telescope/_extensions/media_files.lua \
      --replace "M.base_directory .. '/scripts/vimg'" "'$out/scripts/vimg'"
  '';

  # following https://github.com/NixOS/nixpkgs/blob/d86ae899d2909c0899e4d3b29d90d5309771e77c/pkgs/applications/editors/vim/plugins/overrides.nix#L139
  buildPlug = name:
    let overrides = (final.callPackage ./plugins/overrides.nix { }) { p = name; };
    in buildVimPlugin {
      inherit name;
      inherit (overrides) checkInputs dependencies nvimRequireCheck nvimSkipModule;

      version = "main";
      src = lib.getAttr name inputs;

      doInstallCheck = false;

      preFixup = ''
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

  neovimPlugins = listToAttrs (map (n: nameValuePair n (buildPlug n)) plugins);
}
