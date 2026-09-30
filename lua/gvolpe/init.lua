-- core
require "gvolpe.core"
require "gvolpe.lazy"
require "gvolpe.keybindings"
require "gvolpe.which-key"

-- simple plugin configurations
require("lspkind").init()
require("lsp_signature").setup()
require("mini.ai").setup()
require("nvim-autopairs").setup{}
require("nvim-lightbulb").setup()
require("nvim-surround").setup()

-- notifications
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
require "gvolpe.plugins.jujutsu"
require "gvolpe.plugins.lsp"
require "gvolpe.plugins.lualine"
require "gvolpe.plugins.modes"
require "gvolpe.plugins.neoclip"
require "gvolpe.plugins.noice"
require "gvolpe.plugins.nvim-tree"
require "gvolpe.plugins.telescope"
require "gvolpe.plugins.telescope-tabs"
require "gvolpe.plugins.tide"
require "gvolpe.plugins.treesitter"
require "gvolpe.plugins.ufo"

-- themes
require "gvolpe.themes.onedark"
