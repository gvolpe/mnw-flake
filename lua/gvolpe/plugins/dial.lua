local augend = require("dial.augend")

require("dial.config").augends:register_group {
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
  },
  scala = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.constant.new{ elements = {"val", "def"} },
    augend.constant.new{ elements = {"object", "class", "trait", "enum"} },
  },
}

vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true})
vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true})
vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true})
vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true})
vim.keymap.set("v", "g<C-a>",require("dial.map").inc_gvisual(), {noremap = true})
vim.keymap.set("v", "g<C-x>",require("dial.map").dec_gvisual(), {noremap = true})
