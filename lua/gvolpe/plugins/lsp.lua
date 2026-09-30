local lsp_group = vim.api.nvim_create_augroup("gvolpe_lsp", { clear = true })
local format_group = vim.api.nvim_create_augroup("gvolpe_lsp_format", { clear = true })

vim.g.formatsave = false

local function map(bufnr, lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, {
    buffer = bufnr,
    desc = desc,
    noremap = true,
    silent = true,
  })
end

local function attach_keymaps(client, bufnr)
  if not vim.b[bufnr].gvolpe_lsp_keymaps then
    map(bufnr, "<leader>lgD", vim.lsp.buf.declaration, "LSP declaration")
    map(bufnr, "<leader>lgd", vim.lsp.buf.definition, "LSP definition")
    map(bufnr, "<leader>lgi", vim.lsp.buf.implementation, "LSP implementation")
    map(bufnr, "<leader>lgr", vim.lsp.buf.references, "LSP references")
    map(bufnr, "<leader>lgt", vim.lsp.buf.type_definition, "LSP type definition")
    map(bufnr, "<leader>lgn", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Next diagnostic")
    map(bufnr, "<leader>lgp", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Previous diagnostic")

    -- Alternative keybinding for code actions for when code-action-menu does not work as expected.
    map(bufnr, "<leader>lca", vim.lsp.buf.code_action, "LSP code action")

    map(bufnr, "<leader>lwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map(bufnr, "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map(bufnr, "<leader>lwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")

    map(bufnr, "<leader>lh", vim.lsp.buf.hover, "LSP hover")
    map(bufnr, "<leader>lsh", vim.lsp.buf.signature_help, "LSP signature help")
    map(bufnr, "<leader>ln", vim.lsp.buf.rename, "LSP rename")
    map(bufnr, "F", function()
      vim.lsp.buf.format({ async = true, bufnr = bufnr })
    end, "LSP format")

    vim.b[bufnr].gvolpe_lsp_keymaps = true
  end

  if client.name == "metals" and not vim.b[bufnr].gvolpe_metals_keymaps then
    map(bufnr, "<leader>lmc", function()
      require("metals").commands()
    end, "Metals commands")
    map(bufnr, "<leader>lmi", function()
      require("metals").toggle_setting("showImplicitArguments")
    end, "Toggle Metals implicit arguments")

    vim.b[bufnr].gvolpe_metals_keymaps = true
  end
end

local function enable_format_on_save(client, bufnr)
  if vim.b[bufnr].gvolpe_lsp_format_on_save or not client:supports_method("textDocument/formatting") then
    return
  end

  vim.b[bufnr].gvolpe_lsp_format_on_save = true

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_group,
    buffer = bufnr,
    callback = function(event)
      if vim.g.formatsave then
        vim.lsp.buf.format({ async = false, bufnr = event.buf, timeout_ms = 1000 })
      end
    end,
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    attach_keymaps(client, event.buf)
    enable_format_on_save(client, event.buf)
  end,
})

local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- for the ufo (folding) plugin
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local function configure(server, config)
  config = config or {}
  config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

-- Restore the old LspInfo command functionality
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Native LSP info replacement" })

-- Nix config
configure("nil_ls", {
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
      diagnostics = {
        ignored = { "uri_literal" },
        excludedFiles = {},
      },
      nix = {
        flake = {
          autoArchive = false,
          autoEvalInputs = false,
          nixpkgsInputName = "nixpkgs",
        },
      },
    },
  },
  cmd = { "nil" },
})

-- Dhall config
configure("dhall_lsp_server", {
  cmd = { "dhall-lsp-server" },
})

-- Elm config
configure("elmls", {
  init_options = {
    elmPath = "elm",
    elmFormatPath = "elm-format",
    elmTestPath = "elm-test",
    elmAnalyseTrigger = "change",
  },
  cmd = { "elm-language-server" },
  root_markers = { "elm.json" },
})

-- Unison config
configure("unison", {
  cmd = { "nc", "localhost", "5757" },
  filetypes = { "unison" },
  root_markers = { "*.u" },
})

-- Scala nvim-metals config
local metals_config = require("metals").bare_config()
metals_config.capabilities = capabilities

metals_config.settings = {
  metalsBinaryPath = "metals",
  autoImportBuild = "off",
  defaultBspToBuildTool = true,
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
  superMethodLensesEnabled = true,
  excludedPackages = {
    "akka.actor.typed.javadsl",
    "com.github.swagger.akka.javadsl",
  },
  serverProperties = {
    "-Dmetals.enable-best-effort=true",
    "-Xmx2G",
    "-XX:+UseZGC",
    "-XX:ZUncommitDelay=30",
    "-XX:ZCollectionInterval=5",
    "-XX:+IgnoreUnrecognizedVMOptions",
  },
}

-- without doing this, autocommands that deal with filetypes prohibit messages from being shown
vim.opt_global.shortmess:remove("F")

vim.api.nvim_create_autocmd("FileType", {
  group = lsp_group,
  pattern = { "java", "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
})

-- TS config
configure("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
})

-- Lua config
configure("lua_ls", {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    local library = { vim.env.VIMRUNTIME }
    local lspconfig_library = vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1]
    if lspconfig_library then
      table.insert(library, lspconfig_library)
    end

    client.config.settings = client.config.settings or {}
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
      runtime = {
        version = "LuaJIT",
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = library,
      },
    })
  end,
  cmd = { "lua-lsp" },
  settings = {
    Lua = {
      codeLens = {
        enable = true,
      },
      hint = {
        enable = true,
        semicolon = "Disable",
      },
    },
  },
})
