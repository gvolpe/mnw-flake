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
    require("which-key").register({
      ["<leader>g"] = {
        name = "Gitsigns",
        b = { function() gs.blame_line{full=true} end, "Blame (full)" },
        tb = { gs.toggle_current_line_blame, "Toggle blame" },
        td = { gs.toggle_deleted, "Toggle deleted" },
        d = { gs.diffthis, "Diff current file" },
        D = { function() gs.diffthis('~') end, "Diff file" },
        h = {
          name = "Hunks",
          n = { nextHunk, "Next hunk" },
          p = { prevHunk, "Previous hunk" },
          r = { gs.reset_hunk, "Reset hunk" },
          s = { gs.stage_hunk, "Stage hunk" },
          u = { gs.undo_stage_hunk, "Undo stage hunk" },
        },
        w = {
          name = "Write",
        },
        S = { gs.stage_buffer, "Stage buffer" },
        R = { gs.reset_buffer, "Reset buffer" },
      },
    })

    -- Text object
    map({'o', 'x'}, 'ih', '<cmd><C-U>Gitsigns select_hunk<CR>')
  end
}
