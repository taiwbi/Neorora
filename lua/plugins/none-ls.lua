-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Set a formatter
      null_ls.builtins.formatting.blade_formatter.with {
        command = "blade-formatter",
        args = {
          "-i",
          vim.opt.tabstop:get(),
          "--sort-tailwindcss-classes",
          "--write",
          "$FILENAME",
        },
      },

			null_ls.builtins.formatting.phpcsfixer.with({
				command = "php-cs-fixer",
				filetypes = { "blade" },
				args = {
					"--no-interaction",
					"--quiet",
					"--config=" .. vim.fn.stdpath("config") .. "/extra/php-cs-fixer.php",
					"fix",
					"$FILENAME",
				},
			}),
    })
  end,
}
