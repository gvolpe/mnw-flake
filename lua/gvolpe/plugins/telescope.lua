require("telescope").load_extension("media_files")

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    },
    pickers = {
      find_command = {
        "fd",
      },
    },
  },
  extensions = {
    media = {
      backend = "chafa",
      backend_options = {
        chafa = {
          move = true,
        },
      },
    },
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "fd",
    }
  }
}
