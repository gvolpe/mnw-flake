vim.opt.encoding = "utf-8"
vim.opt.mouse = "v"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.cmdheight = 1
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")
vim.opt.timeoutlen = 500
pcall(function()
  vim.opt.hidden = true
end)
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "yes"
vim.opt.autoindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard:append("unnamedplus")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.cursorline_timeout = 0
vim.g.vsnip_snippet_dir = vim.api.nvim_get_runtime_file("snippets", false)[1]
  or "~/workspace/mnw-flake/snippets"
vim.g.plantuml_set_makeprg = 0

vim.cmd("syntax on")
vim.opt.termguicolors = true
vim.cmd("set t_Co=256")

local core_group = vim.api.nvim_create_augroup("gvolpe_core", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = core_group,
  pattern = "*.md",
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = core_group,
  callback = function()
    local ok, lightbulb = pcall(require, "nvim-lightbulb")
    if ok then
      lightbulb.update_lightbulb()
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = core_group,
  pattern = "nix",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})
