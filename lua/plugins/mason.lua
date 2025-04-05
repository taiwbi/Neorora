-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- Language servers
        "lua-language-server",
        "html-lsp",
        "intelephense",
        "css-lsp",
        "tailwindcss-language-server",
        "typescript-language-server",
        "json-lsp",
        "basedpyright",
        "rust-analyzer",

        -- Formatters
        "stylua",
        "prettier",
        "blade-formatter",
        "php-cs-fixer", -- For Blade Files only
        "beautysh",
        "xmlformatter",
        "pyink",
        "sql-formatter",

        -- Debuggers
        "debugpy",
        "php-debug-adapter",
        "codelldb",

        -- Other package
        "tree-sitter-cli",
      },
    },
  },
}
