require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    local function nextHunk()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end

    local function prevHunk()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end

    -- Actions
    map("n", "<leader>gb", function() gs.blame_line{full=true} end, { desc = "Blame (full)" })
    map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
    map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })
    map("n", "<leader>gd", gs.diffthis, { desc = "Diff current file" })
    map("n", "<leader>gD", function() gs.diffthis('~') end, { desc = "Diff file" })
    map("n", "<leader>ghn", nextHunk, { desc = "Next hunk" })
    map("n", "<leader>ghp", prevHunk, { desc = "Previous hunk" })
    map("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset hunk" })
    map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
    map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })

    -- Text object
    map({'o', 'x'}, 'ih', '<cmd><C-U>Gitsigns select_hunk<CR>')
  end
}
