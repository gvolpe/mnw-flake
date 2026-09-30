local group = vim.api.nvim_create_augroup("gvolpe_jujutsu", { clear = true })

local function path_dir(path)
  local stat = vim.uv.fs_stat(path)
  if stat and stat.type == "directory" then
    return path
  end

  return vim.fs.dirname(path)
end

local function in_jujutsu_workspace(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then
    path = vim.uv.cwd()
  end

  local dir = path_dir(path)
  if not dir then
    return false
  end

  return vim.fs.find(".jj", { path = dir, upward = true, type = "directory" })[1] ~= nil
end

local function add_mappings(bufnr)
  if vim.b[bufnr].gvolpe_jujutsu_mappings or not in_jujutsu_workspace(bufnr) then
    return
  end

  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set("n", "<leader>jd", "<cmd>JJ diff<CR>", vim.tbl_extend("force", opts, { desc = "Jujutsu diff" }))
  vim.keymap.set("n", "<leader>jj", "<cmd>JJ<CR>", vim.tbl_extend("force", opts, { desc = "Jujutsu log" }))
  vim.keymap.set("n", "<leader>js", "<cmd>JJ status<CR>", vim.tbl_extend("force", opts, { desc = "Jujutsu status" }))

  vim.b[bufnr].gvolpe_jujutsu_mappings = true
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = group,
  callback = function(event)
    add_mappings(event.buf)
  end,
})

add_mappings(vim.api.nvim_get_current_buf())
