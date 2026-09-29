local builtin = require('telescope.builtin')
require("search").setup({
  append_tabs = {
    {
      name = "Scala files",
      tele_func = function()
        builtin.fd({ find_command = { "fd", "-e", "scala" } })
      end,
      available = function()
        local scalaFiles = vim.fn.glob("*.scala", ".") .. vim.fn.glob("*.sbt", ".")
        return not (scalaFiles == "")
      end
    }
  },
})
