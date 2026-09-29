{ inputs, lib, system }:

let
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
  neovimOverlay
]
