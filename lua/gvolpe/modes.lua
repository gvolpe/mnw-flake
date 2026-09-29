require('modes').setup({
  colors = {
    bg = "", -- Optional bg param, defaults to Normal hl group
    copy = "#fcd85c", -- don't care about this, interferes with which-key
    delete = "#f05454", -- also interferes with which-key and workaroound is too slow
    insert = "#27ff00",
    visual = "#8927ff",
  },
  -- Set opacity for cursorline and number background
  line_opacity = 0.150000,
})
