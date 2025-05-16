-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade",
    }

    if not opts.ensure_installed then opts.ensure_installed = {} end
    vim.list_extend(opts.ensure_installed, {
      "lua",
      "vim",
      "sql",
      "bash",
      "html",
      "css",
      "javascript",
      "php",
      "blade",
      "scss",
      "python",
      "rust",
      "hyprlang",
      "diff",
      "xml",
    })
    return opts
  end,
}
