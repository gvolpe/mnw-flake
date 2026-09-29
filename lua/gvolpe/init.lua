-- core
require "gvolpe.core"
require "gvolpe.keybindings"
require "gvolpe.which-key"

-- simple plugin configurations
require("hurl").setup({})
require("lspkind").init()
require("lsp_signature").setup()
require("mini.ai").setup()
require("mini.surround").setup()
require("neogit").setup {}
require("nvim-autopairs").setup{}
require("nvim-lightbulb").setup()
require("nvim-surround").setup()
require("render-markdown").setup({})
require("trouble").setup {}
require("zen-mode").setup()

require("glow").setup({
  glow_path = "glow",
  border = "shadow",
  pager = false,
  width = 120,
})

require("jujutsu-nvim").setup({
  diff_preset = "diffview",
})

require("notify").setup({
  background_colour = "#000000",
})
vim.notify = require("notify")

-- plugins
require "gvolpe.plugins.bufferline"
require "gvolpe.plugins.cmp"
require "gvolpe.plugins.dial"
require "gvolpe.plugins.gitsigns"
require "gvolpe.plugins.indent-blankline"
require "gvolpe.plugins.lsp"
require "gvolpe.plugins.lualine"
require "gvolpe.plugins.modes"
require "gvolpe.plugins.neoclip"
require "gvolpe.plugins.noice"
require "gvolpe.plugins.nvim-tree"
require "gvolpe.plugins.telescope"
require "gvolpe.plugins.telescope-tabs"
require "gvolpe.plugins.tide"
require "gvolpe.plugins.todo-comments"
require "gvolpe.plugins.treesitter"
require "gvolpe.plugins.ufo"

-- themes
require "gvolpe.themes.onedark"
