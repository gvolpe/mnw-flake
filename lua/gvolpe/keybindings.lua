local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or {})
end

local function silent_map(mode, lhs, rhs)
  map(mode, lhs, rhs, { silent = true })
end

for _, key in ipairs({ "<Down>", "<Left>", "<Right>", "<Up>" }) do
  map({ "n", "i" }, key, "<Nop>")
end

map("n", "<C-F>", "<cmd>NvimTreeToggle<CR>")
map("n", "<C-p>", "<cmd>lua require('search').open()<CR>")
map("n", "<C-s>", "<cmd>NvimTreeFindFile<CR>")
map("n", "<C-z>", "<cmd>nohlsearch<CR>")

map("n", "<M-+>", "<C-w>+")
map("n", "<M-->", "<C-w>-")
map("n", "<M-<>", "<C-w><")
map("n", "<M-=>", "<C-w>=")
map("n", "<M->>", "<C-w>>")
map("n", "<M-H>", "<C-w>H")
map("n", "<M-J>", "<C-w>J")
map("n", "<M-K>", "<C-w>K")
map("n", "<M-L>", "<C-w>L")
map("n", "<M-h>", "<C-w>h")
map("n", "<M-j>", "<C-w>j")
map("n", "<M-k>", "<C-w>k")
map("n", "<M-l>", "<C-w>l")
map("n", "<M-x>", "<C-w>x")

map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
map("n", "<leader>fi", "<cmd>Telescope media_files<CR>")
map("n", "<leader>fk", "<cmd>Telescope marks<CR>")
map("n", "<leader>flD", "<cmd>Telescope lsp_definitions<CR>")
map("n", "<leader>fld", "<cmd>Telescope diagnostics<CR>")
map("n", "<leader>fli", "<cmd>Telescope lsp_implementations<CR>")
map("n", "<leader>flr", "<cmd>Telescope lsp_references<CR>")
map("n", "<leader>flsb", "<cmd>Telescope lsp_document_symbols<CR>")
map("n", "<leader>flsw", "<cmd>Telescope lsp_workspace_symbols<CR>")
map("n", "<leader>flt", "<cmd>Telescope lsp_type_definitions<CR>")
map("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
map("n", "<leader>fnc", "<cmd>Telescope neoclip unnamed extra=star,plus<CR>")
map("n", "<leader>fts", "<cmd>Telescope treesitter<CR>")
map("n", "<leader>fvb", "<cmd>Telescope git_branches<CR>")
map("n", "<leader>fvc", "<cmd>Telescope git_commits<CR>")
map("n", "<leader>fvs", "<cmd>Telescope git_status<CR>")
map("n", "<leader>fvx", "<cmd>Telescope git_stash<CR>")

map("n", "<leader>gs", "<cmd>Gvdiffsplit origin/HEAD<CR>")
map("n", "<leader>gwc", ":Git commit -m '")
map("n", "<leader>gwp", "<cmd>Git push<CR>")

map("n", "<leader>ltd", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0 win.type=split win.position=bottom<CR>")
map("n", "<leader>lts", "<cmd>Trouble symbols toggle focus=true filter.buf=0 win.type=split win.position=bottom<CR>")

map("n", "<leader>tdq", "<cmd>TodoQuickFix<CR>")
map("n", "<leader>tds", "<cmd>TodoTelescope<CR>")
map("n", "<leader>tdt", "<cmd>TodoTrouble<CR>")
map("n", "<leader>te", "<cmd>lua require('nvim-tree.api').tree.expand_all()<CR>")
map("n", "<leader>tp", "<cmd>NvimTreeResize +40<CR>")
map("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>")
map("n", "<leader>ts", "<cmd>NvimTreeResize +10<CR>")
map("n", "<leader>tx", "<cmd>NvimTreeResize -10<CR>")
map("n", "<leader>z", "<cmd>ZenMode<CR>")

silent_map("n", "<leader>ac", "<cmd>CodeActionMenu<CR>")
silent_map("n", "<leader>b1", "<cmd>BufferLineGoToBuffer 1<CR>")
silent_map("n", "<leader>b2", "<cmd>BufferLineGoToBuffer 2<CR>")
silent_map("n", "<leader>b3", "<cmd>BufferLineGoToBuffer 3<CR>")
silent_map("n", "<leader>b4", "<cmd>BufferLineGoToBuffer 4<CR>")
silent_map("n", "<leader>b5", "<cmd>BufferLineGoToBuffer 5<CR>")
silent_map("n", "<leader>b6", "<cmd>BufferLineGoToBuffer 6<CR>")
silent_map("n", "<leader>b7", "<cmd>BufferLineGoToBuffer 7<CR>")
silent_map("n", "<leader>b8", "<cmd>BufferLineGoToBuffer 8<CR>")
silent_map("n", "<leader>b9", "<cmd>BufferLineGoToBuffer 9<CR>")
silent_map("n", "<leader>bc", "<cmd>BufferLinePick<CR>")
silent_map("n", "<leader>bmn", "<cmd>BufferLineMoveNext<CR>")
silent_map("n", "<leader>bmp", "<cmd>BufferLineMovePrev<CR>")
silent_map("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>")
silent_map("n", "<leader>bp", "<cmd>BufferLineCyclePrev<CR>")
silent_map("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<CR>")
silent_map("n", "<leader>bse", "<cmd>BufferLineSortByExtension<CR>")
silent_map("n", "<leader>bsi", function()
  require("bufferline").sort_buffers_by(function(buf_a, buf_b)
    return buf_a.id < buf_b.id
  end)
end)

map("n", "<Space>", "<Nop>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gQ", "<Nop>")

local keybindings_group = vim.api.nvim_create_augroup("gvolpe_keybindings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = keybindings_group,
  pattern = "markdown",
  callback = function(event)
    local opts = { buffer = event.buf }
    map("n", "<leader>p", "<cmd>Glow<CR>", opts)
    map("n", "<leader>rt", "<cmd>RenderMarkdown toggle<CR>", opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = keybindings_group,
  pattern = "scala",
  callback = function(event)
    local opts = { buffer = event.buf }
    map("n", "<C-a>", require("dial.map").inc_normal("scala"), opts)
    map("n", "<C-x>", require("dial.map").dec_normal("scala"), opts)
  end,
})
