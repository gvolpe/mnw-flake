if mnw == nil or mnw.configDir == nil then
  error("mnw wrapper required for strict nix-managed plugin loading")
end

local lazy_opt_path = mnw.configDir .. "/pack/mnw/opt"

local function nix_plugin(name, spec)
  spec = spec or {}
  spec.name = spec.name or name
  spec.dir = spec.dir or (lazy_opt_path .. "/" .. name)
  return spec
end

require("lazy").setup({
  defaults = {
    lazy = true,
  },

  dev = {
    path = lazy_opt_path,
    patterns = { "" },
    fallback = false,
  },

  install = {
    missing = false,
  },

  checker = {
    enabled = false,
  },

  change_detection = {
    enabled = false,
  },

  performance = {
    reset_packpath = false,
    rtp = {
      reset = false,
    },
  },

  spec = {
    nix_plugin("cellular-automaton.nvim", {
      cmd = "CellularAutomaton",
    }),

    nix_plugin("diffview.nvim", {
      cmd = {
        "DiffviewClose",
        "DiffviewFileHistory",
        "DiffviewFocusFiles",
        "DiffviewLog",
        "DiffviewOpen",
        "DiffviewRefresh",
        "DiffviewToggleFiles",
      },
    }),

    nix_plugin("glow.nvim", {
      cmd = "Glow",
      ft = "markdown",
      config = function()
        require("glow").setup({
          glow_path = "glow",
          border = "shadow",
          pager = false,
          width = 120,
        })
      end,
    }),

    nix_plugin("hurl.nvim", {
      cmd = {
        "HurlDebugInfo",
        "HurlJson",
        "HurlManageVariable",
        "HurlRerun",
        "HurlRunner",
        "HurlRunnerAt",
        "HurlRunnerToEntry",
        "HurlRunnerToEnd",
        "HurlSelectEnvFile",
        "HurlSetEnvFile",
        "HurlSetVariable",
        "HurlShowLastResponse",
        "HurlToggleMode",
        "HurlVeryVerbose",
        "HurlVerbose",
      },
      ft = "hurl",
      config = function()
        require("hurl").setup({})
      end,
    }),

    nix_plugin("jujutsu.nvim", {
      cmd = "JJ",
      config = function()
        require("jujutsu-nvim").setup({
          diff_preset = "diffview",
        })
      end,
    }),

    nix_plugin("neogit", {
      cmd = "Neogit",
      config = function()
        require("neogit").setup({})
      end,
    }),

    nix_plugin("nvim-code-action-menu", {
      cmd = "CodeActionMenu",
    }),

    nix_plugin("render-markdown.nvim", {
      cmd = "RenderMarkdown",
      ft = "markdown",
      config = function()
        require("render-markdown").setup({})
      end,
    }),

    nix_plugin("todo-comments.nvim", {
      cmd = {
        "TodoFzfLua",
        "TodoLocList",
        "TodoQuickFix",
        "TodoTelescope",
        "TodoTrouble",
      },
      event = {
        "BufReadPost",
        "BufNewFile",
      },
      config = function()
        require("gvolpe.plugins.todo-comments")
      end,
    }),

    nix_plugin("trouble.nvim", {
      cmd = "Trouble",
      config = function()
        require("trouble").setup({})
      end,
    }),

    nix_plugin("zen-mode.nvim", {
      cmd = "ZenMode",
      config = function()
        require("zen-mode").setup()
      end,
    }),
  },
})

-- lazy disables this during setup; restore it so mnw start plugins source plugin/*.lua.
vim.go.loadplugins = true
