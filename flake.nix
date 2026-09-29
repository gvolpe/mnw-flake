{
  description = "Neovim Flake by @gvolpe";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    flake-utils.url = "github:numtide/flake-utils";
    mnw.url = "github:Gerg-L/mnw";

    neovim-nightly-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/neovim-nightly-overlay";
    };

    tree-sitter-scala = {
      flake = false;
      url = "github:tree-sitter/tree-sitter-scala";
    };

    # custom plugins
    modes-nvim = {
      flake = false;
      url = "github:mvllow/modes.nvim";
    };

    telescope-tabs = {
      flake = false;
      url = "github:FabianWirth/search.nvim";
    };

    tide = {
      flake = false;
      url = "github:jackMort/tide.nvim";
    };
  };

  outputs = inputs @ { flake-utils, mnw, nixpkgs, self, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ] (system:
      let
        lib = import ./lib { inherit pkgs inputs; };

        overlays = import ./lib/overlays.nix { inherit lib inputs system; };

        pkgs = import nixpkgs {
          inherit overlays system;
          config = { allowUnfree = true; };
        };
      in
      {
        packages = {
          default = mnw.lib.wrap pkgs (import ./nvim.nix {
            inherit pkgs;
            neovim = pkgs.neovim-unwrapped;
          });

          dev = self.packages.x86_64-linux.default.devMode;

          nightly = mnw.lib.wrap pkgs (import ./nvim.nix {
            inherit pkgs;
            neovim = pkgs.neovim-nightly;
          });

          nightly-dev = self.packages.x86_64-linux.nightly.devMode;
        };
      }
    );
}
