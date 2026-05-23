return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "HighlightColors" },
  opts = { render = "background" },
}
