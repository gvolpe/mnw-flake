require'nvim-tree'.setup({
  disable_netrw = false,
  hijack_netrw = true,
  open_on_tab = false,
  diagnostics = {
    enable = true,
  },
  view  = {
    width = 25,
    side = 'left',
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    indent_markers = {
      enable = true,
    },
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = false
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
  filters = {
    dotfiles = false,
    custom = {
      "node_modules",
      ".cache",
    },
  },
})
