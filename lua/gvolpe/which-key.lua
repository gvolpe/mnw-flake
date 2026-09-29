local wk = require("which-key")

wk.register({
  ["<leader>n"] = {
    name = "Noice",
    d = { "<cmd> NoiceDismiss <CR>", "Dismiss notifications" },
  },
})

wk.register({
  ["<leader>b"] = {
    name = "Buffers",
  },
})

wk.register({
  ["<leader>lt"] = {
    name = "Trouble",
  },
})

wk.register({
  ["<leader>a"] = {
    name = "Code actions",
  },
})

wk.register({
  ["<leader>l"] = {
    name = "LSP",
  },
})

wk.register({
  ["<leader>m"] = {
    name = "Metals",
    w = { "<cmd>lua require'metals'.worksheet_hover()<CR>", "Worksheet hover" },
    d = { "<cmd>lua require'metals'.open_all_diagnostics()<CR>", "Open all diagnostics" },
  },
})

wk.register({
  ["<leader>gn"] = { "<cmd> Neogit kind=auto<CR>", "Open neogit" },
})

wk.register({
  ["<leader>t"] = {
    name = "Tree & Todo",
  },
})

wk.register({
  ["<leader>f"] = {
    name = "Telescope",
  },
})

wk.register({
  ["<leader>j"] = {
    name = "Jujutsu",
    d = { "<cmd>:JJ diff<CR>", "diff" },
    j = { "<cmd>:JJ<CR>", "log" },
    s = { "<cmd>:JJ status<CR>", "status" },
  },
})

wk.register({
  ["<leader>h"] = {
    name = "Harpoon",
    a = { "<cmd>lua require('harpoon'):list():add()<CR>", "Add" },
    d = { "<cmd>lua require('harpoon'):list():remove()<CR>", "Del" },
  },
})

wk.register({
  ["<leader>c"] = {
    name = "Commenter",
  },
})

wk.setup {}
