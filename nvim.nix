{ pkgs, neovim }:

{
  inherit neovim;

  aliases = [ "vim" ];
  desktopEntry = false;

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
      lazy-nvim

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
      vim-fugitive
      vim-multiple-cursors
      vim-repeat
      noice-nvim
      nui-nvim
      nvim-web-devicons
      nvim-cursorline
      indent-blankline-nvim
      nvim-ts-autotag
      onedark-nvim
      bufferline-nvim
      bufdelete-nvim
      lualine-nvim
      nvim-lightbulb
      promise-async
      nvim-ufo
      which-key-nvim
      gitsigns-nvim
      nvim-tree-lua
      nvim-autopairs
      twilight-nvim
      nui-nvim
      telescope-nvim
      telescope-media-files-nvim
      nvim-surround
      vim-vsnip
      nvim-notify
      nvim-neoclip-lua
      mini-nvim
      dial-nvim
      nerdcommenter
      plenary-nvim
    ] ++ (with pkgs.neovimPlugins; [
      modes-nvim
      telescope-tabs
      tide
    ]);

    opt = with (pkgs.vimPlugins); [
      cellular-automaton-nvim
      diffview-nvim
      glow-nvim
      hurl-nvim
      jujutsu-nvim
      neogit
      nvim-code-action-menu
      render-markdown-nvim
      todo-comments-nvim
      trouble-nvim
      zen-mode-nvim
    ];
  };
}
