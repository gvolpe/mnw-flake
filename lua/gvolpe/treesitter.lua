require'nvim-treesitter'.setup {
  highlight = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = {
    enable = true,
  },

  autotag = {
    enable = true,
  },
}

require'treesitter-context'.setup {
  enable = true,
  throttle = true,
  max_lines = 0
}

-- Smithy treesitter config
vim.api.nvim_create_autocmd("FileType", {
  pattern = "smithy",
  callback = function()
    vim.treesitter.language.register('smithy', 'smithy')
    vim.treesitter.start()
  end,
})
