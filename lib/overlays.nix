{ inputs, lib, system }:

let
  nvimTreesitterOverlay = final: prev:
    let
      ts = prev.tree-sitter.overrideAttrs (old: {
        grammars = old.grammars.override {
          tree-sitter-scala = final.tree-sitter-scala-master;
        };
      });
    in
    {
      nvim-treesitter-patched = prev.vimPlugins.nvim-treesitter.overrideAttrs (ntsOld: {
        # sync nvim-treesitter queries and parsers
        preFixup = (ntsOld.preFixup or "") + ''
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
      });
    };

  pluginOverlay = lib.buildPluginOverlay;

  libOverlay = f: p: {
    lib = p.lib.extend (_: _: {
      inherit (lib) mkVimBool withAttrSet withPlugins writeIf;
    });
  };

  tsOverlay = f: p: {
    tree-sitter-scala-master = p.tree-sitter.buildGrammar {
      language = "scala";
      src = inputs.tree-sitter-scala;
      version = inputs.tree-sitter-scala.rev;
    };
  };

  neovimOverlay = f: p: {
    neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.neovim;
    neovim-version = nvim:
      if nvim.version == "nightly"
      then "nightly-${inputs.neovim-nightly-overlay.inputs.neovim-src.shortRev}"
      else nvim.version;
  };
in
[
  libOverlay
  pluginOverlay
  tsOverlay
  nvimTreesitterOverlay
  neovimOverlay
]
