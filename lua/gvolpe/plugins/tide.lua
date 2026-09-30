require('tide').setup({
  keys = {
    leader = "\\",
    panel = "\\",
    add_item = "a",
    delete = "d",
    clear_all = "x",
    horizontal = "h",
    vertical = "v",
  },
  animation_duration = 300,  -- Animation duration in milliseconds
  animation_fps = 30,        -- Frames per second for animations
})
