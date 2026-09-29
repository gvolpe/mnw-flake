local attach_keymaps = function(client, bufnr)
  local opts = { noremap=true, silent=true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

  -- Alternative keybinding for code actions for when code-action-menu does not work as expected.
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lsh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'F', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)

  -- Metals specific
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lmc', '<cmd>lua require("metals").commands()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lmi', '<cmd>lua require("metals").toggle_setting("showImplicitArguments")<CR>', opts)

end

vim.g.formatsave = false;

-- Enable formatting
format_callback = function(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      if vim.g.formatsave then
          local params = require'vim.lsp.util'.make_formatting_params({})
          client.request('textDocument/formatting', params, nil, bufnr)
      end
    end
  })
end

default_on_attach = function(client, bufnr)
  attach_keymaps(client, bufnr)
  format_callback(client, bufnr)
end

-- Enable lspconfig
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Restore the old LspInfo command functionality
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Native LSP info replacement" })

-- Nix config
vim.lsp.config['nil_ls'] = {
  capabilities = capabilities;
  on_attach = function(client, bufnr)
    attach_keymaps(client, bufnr)
  end,
  settings = {
    ['nil'] = {
      formatting = {
        command = {"nixpkgs-fmt"}
      },
      diagnostics = {
        ignored = { "uri_literal" },
        excludedFiles = { }
      },
      nix = {
        flake = {
          autoArchive = false,
          autoEvalInputs = false,
          nixpkgsInputName = "nixpkgs"
        }
      }
    }
  };
  cmd = {"nil"}
}
vim.lsp.enable('nil_ls')

-- Dhall config
vim.lsp.config['dhall_lsp_server'] = {
  capabilities = capabilities;
  on_attach = default_on_attach;
  cmd = { "dhall-lsp-server" };
}
vim.lsp.enable('dhall_lsp_server')

-- Elm config
vim.lsp.config['elmls'] = {
  capabilities = capabilities;
  on_attach = default_on_attach;
  init_options = {
     elmPath = "elm",
     elmFormatPath = "elm-format",
     elmTestPath = "elm-test",
     elmAnalyseTrigger = "change"
  };
  cmd = { "elm-language-server" };
  root_markers = { "elm.json" };
}
vim.lsp.enable('elmls')

-- Unison config
vim.lsp.config['unison'] = {
  capabilities = capabilities;
  on_attach = default_on_attach;
  cmd = { "nc", "localhost", "5757" };
  filetypes = { "unison" };
  root_markers = { "*.u" };
}
vim.lsp.enable('unison')

-- Scala nvim-metals config
metals_config = require('metals').bare_config()
metals_config.capabilities = capabilities
metals_config.on_attach = default_on_attach

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
     "com.github.swagger.akka.javadsl"
   },
   serverProperties = {
     "-Dmetals.enable-best-effort=true","-Xmx2G","-XX:+UseZGC","-XX:ZUncommitDelay=30","-XX:ZCollectionInterval=5","-XX:+IgnoreUnrecognizedVMOptions"
   }
}

-- without doing this, autocommands that deal with filetypes prohibit messages from being shown
vim.opt_global.shortmess:remove("F")

vim.cmd([[augroup lsp]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd FileType java,scala,sbt lua require('metals').initialize_or_attach(metals_config)]])
vim.cmd([[augroup end]])

-- TS config
vim.lsp.config['ts_ls'] = {
  capabilities = capabilities;
  on_attach = function(client, bufnr)
    attach_keymaps(client, bufnr)
  end,
  cmd = { "typescript-language-server", "--stdio" }
}
vim.lsp.enable('ts_ls')

-- Lua config
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
        },
      },
    })
  end,
  cmd = { "lua-lsp" },
  settings = {
    Lua = {
      codeLens = {
        enable = true
      },
      hint = {
        enable = true,
        semicolon = "Disable"
      }
    },
  },
})
vim.lsp.enable('lua_ls')
