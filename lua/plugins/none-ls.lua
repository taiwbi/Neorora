-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
      null_ls.builtins.diagnostics.phpstan.with {
        command = "phpstan",
        args = {
          "analyze",
          "--error-format=json",
          "--no-progress",
          "--memory-limit=2G",
          "$FILENAME",
        },
      },
      null_ls.builtins.formatting.blade_formatter.with {
        command = "blade-formatter",
        args = { "-i", "2", "--write", "$FILENAME" },
      },
    }
    return config -- return final config table
  end,
}
