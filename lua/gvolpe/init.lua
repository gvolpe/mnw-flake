require "gvolpe.core"

require'lspkind'.init()

-- highlight error: https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"
vim.opt.list = true
vim.g.cursorline_timeout = 0

require("ibl").setup {
  scope = {
    enabled = true;
    char = "│",
    injected_languages = true,
    show_end = true,
  }
}

require'nvim-lightbulb'.setup()
require("lsp_signature").setup()
require("trouble").setup {}

capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities);

require('neogit').setup {}
require("nvim-autopairs").setup{}
require('zen-mode').setup()
require('nvim-surround').setup()

require("notify").setup({
  background_colour = "#000000",
})
vim.notify = require("notify")

require('mini.ai').setup()
require('mini.surround').setup()

require('glow').setup({
  glow_path = "glow",
  border = "shadow", 
  pager = false,
  width = 120,
})

require('jujutsu-nvim').setup({
  diff_preset = "diffview",
})

require('render-markdown').setup({})
require('hurl').setup({})

-- local imports
require "gvolpe.bufferline"
require "gvolpe.cmp"
require "gvolpe.dial"
require "gvolpe.gitsigns"
require "gvolpe.lsp"
require "gvolpe.lualine"
require "gvolpe.modes"
require "gvolpe.neoclip"
require "gvolpe.noice"
require "gvolpe.nvim-tree"
require "gvolpe.onedark"
require "gvolpe.telescope"
require "gvolpe.telescope-tabs"
require "gvolpe.tide"
require "gvolpe.todo-comments"
require "gvolpe.treesitter"
require "gvolpe.ufo"
require "gvolpe.which-key"
require "gvolpe.keybindings"
