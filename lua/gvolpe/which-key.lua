local wk = require("which-key")

wk.add({
  { "<leader>a", group = "Code actions" },
  { "<leader>b", group = "Buffers" },
  { "<leader>c", group = "Commenter" },
  { "<leader>f", group = "Telescope" },
  { "<leader>gn", "<cmd> Neogit kind=auto<CR>", desc = "Open neogit" },
  { "<leader>l", group = "LSP" },
  { "<leader>lt", group = "Trouble" },
  { "<leader>m", group = "Metals" },
  { "<leader>md", "<cmd>lua require'metals'.open_all_diagnostics()<CR>", desc = "Open all diagnostics" },
  { "<leader>mw", "<cmd>lua require'metals'.worksheet_hover()<CR>", desc = "Worksheet hover" },
  { "<leader>n", group = "Noice" },
  { "<leader>nd", "<cmd> NoiceDismiss <CR>", desc = "Dismiss notifications" },
  { "<leader>t", group = "Tree & Todo" },
})

wk.setup {}
