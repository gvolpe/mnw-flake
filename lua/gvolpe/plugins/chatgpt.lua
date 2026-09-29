do
  local function expand_env(path)
    local function replace(name)
      return vim.env[name] or os.getenv(name) or ("$" .. "{" .. name .. "}")
    end

    return path
      :gsub("[$]{([%w_]+)}", replace)
      :gsub("[$]([%w_]+)", replace)
  end

  -- TODO: expose an option to pass in the secret path
  local file = io.open(expand_env("config.age.secrets.openai-api-key.path"), "r")
  local api_key = ""

  if file then
    api_key = file:read("*a") or ""
    file:close()
  end

  vim.env.OPENAI_API_KEY = vim.trim(api_key)
end

require("chatgpt").setup({})
