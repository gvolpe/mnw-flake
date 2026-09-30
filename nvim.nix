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
      # plugin manager
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
      nvim-ts-autotag # autoclose and autorename html tags

      # completion
      cmp-nvim-lsp
      cmp-buffer
      cmp-vsnip
      cmp-path
      cmp-treesitter
      nvim-cmp

      # core functionality
      nvim-surround
      vim-multiple-cursors
      vim-repeat

      # mini.ai (text objects)
      mini-nvim

      # better messages, cmdline, popupmenu
      noice-nvim

      # git support
      vim-fugitive
      gitsigns-nvim

      # dependencies
      nui-nvim
      nvim-web-devicons
      plenary-nvim
      promise-async

      # dimming mode (treesitter and zen mode)
      twilight-nvim

      # fuzzy search
      telescope-nvim
      telescope-media-files-nvim

      # notifications
      nvim-notify

      # code comments
      nerdcommenter

      # themes
      onedark-nvim

      # visual
      bufferline-nvim
      bufdelete-nvim
      indent-blankline-nvim
      lualine-nvim
      nvim-cursorline
      nvim-lightbulb
      nvim-ufo

      # enhanced increment/decrement plugin
      dial-nvim

      # keybindings helper
      which-key-nvim

      # tree view
      nvim-tree-lua

      # autopair plugin with multiple characters support
      nvim-autopairs

      # clipboard manager with telescope support
      nvim-neoclip-lua

      # code snippets
      vim-vsnip
    ] ++ (with pkgs.neovimPlugins; [
      modes-nvim # prismatic line decorations
      telescope-tabs # search.nvim (tabs for telescope)
      tide # harpoon alternative
    ]);

    opt = with (pkgs.vimPlugins); [
      cellular-automaton-nvim # treesitter animation
      diffview-nvim # jujutsu dependency for diffs
      glow-nvim # markdown
      hurl-nvim # hurl regression tests
      jujutsu-nvim # jujutsu vcs
      neogit # git plugin
      nvim-code-action-menu # lsp code actions
      render-markdown-nvim # markdown
      todo-comments-nvim # todo list
      trouble-nvim # lsp diagnostics
      zen-mode-nvim # zen mode with twilight-nvim
    ];
  };
}
