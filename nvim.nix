{ pkgs, neovim }:

{
  inherit neovim;

  extraBinPath = with pkgs; [
    chafa
    dhall-lsp-server
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-language-server
    fd
    glow
    luaPackages.lua-lsp
    metals
    nil
    nixpkgs-fmt
    ripgrep
    typescript-language-server
  ];

  initLua = ''
    require('gvolpe')
  '';

  plugins = {
    dev.gvolpe = {
      impure = "~/workspace/mnw-flake";
      pure = ./.;
    };

    start = with (pkgs.vimPlugins); [
      vim-fugitive
      vim-multiple-cursors
      vim-repeat

      # lsp
      lspkind-nvim
      lsp_signature-nvim
      nvim-lspconfig
      nvim-metals
      unison

      # treesitter
      nvim-treesitter
      nvim-treesitter-context

      # completion
      cmp-nvim-lsp
      cmp-buffer
      cmp-vsnip
      cmp-path
      cmp-treesitter
      nvim-cmp

      # others
      noice-nvim
      nui-nvim
      nvim-web-devicons
      nvim-cursorline
      indent-blankline-nvim
      nvim-ts-autotag
      todo-comments-nvim
      onedark-nvim
      bufferline-nvim
      bufdelete-nvim
      lualine-nvim
      nvim-lightbulb
      trouble-nvim
      nvim-code-action-menu
      promise-async
      nvim-ufo
      which-key-nvim
      diffview-nvim
      gitsigns-nvim
      neogit
      nvim-tree-lua
      nvim-autopairs
      twilight-nvim
      zen-mode-nvim
      nui-nvim
      telescope-nvim
      telescope-media-files-nvim
      nvim-surround
      vim-vsnip
      nvim-notify
      nvim-neoclip-lua
      mini-nvim
      glow-nvim
      render-markdown-nvim
      jujutsu-nvim
      hurl-nvim
      cellular-automaton-nvim
      dial-nvim
      nerdcommenter
      plenary-nvim
    ] ++ (with pkgs.neovimPlugins; [
      modes-nvim
      telescope-tabs
      tide
    ]);
  };
}
