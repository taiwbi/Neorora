-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
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
