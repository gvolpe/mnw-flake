{ neovimPlugins, vimPlugins, ... }:

# https://github.com/NixOS/nixpkgs/blob/d86ae899d2909c0899e4d3b29d90d5309771e77c/pkgs/applications/editors/vim/plugins/overrides.nix#L139
let
  withDeps = cond: deps: if cond then deps else [ ];
in
{ p }: {
  checkInputs =
    (withDeps (p == "modes-nvim") [ vimPlugins.nvim-cmp ]);

  dependencies =
    (withDeps (p == "nvim-chatgpt") (with neovimPlugins; [ nui-nvim plenary-nvim telescope ]));

  nvimRequireCheck =
    (withDeps (p == "nvim-chatgpt") [ "chatgpt" ]);

  nvimSkipModule =
    (withDeps (p == "telescope-tabs") [ "search" "search.settings" "search.util" ]) ++
    (withDeps (p == "tide") [ "tide.render" "tide.api" "tide.panel" "tide" ]);
}
