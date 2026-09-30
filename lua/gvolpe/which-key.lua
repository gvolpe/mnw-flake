local wk = require("which-key")

local ignored_overlap_prefixes = {
  n = {
    gc = true,
    ys = true,
    yS = true,
  },
  o = {
    a = true,
    i = true,
  },
  x = {
    a = true,
    i = true,
  },
}

local function ignored_overlap(mapping)
  local ignored = ignored_overlap_prefixes[mapping.mode]
  return ignored ~= nil and ignored[mapping.lhs] == true
end

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

wk.setup {
  disable = {
    ft = { "NvimTree" },
  },
  filter = function(mapping)
    return not ignored_overlap(mapping)
  end,
}
