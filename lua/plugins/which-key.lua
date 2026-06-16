return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<Leader>a", group = "AI", mode = { "n", "v" } },
      { "<Leader>b", group = "Buffers" },
      { "<Leader>bs", group = "Sort buffers by..." },
      { "<Leader>d", group = "Debugger" },
      { "<Leader>D", group = "Database" },
      { "<Leader>f", group = "Find" },
      { "<Leader>g", group = "Git" },
      { "<Leader>l", group = "LSP" },
      { "<Leader>p", group = "Packages" },
      { "<Leader>r", group = "Helpers" },
      { "<Leader>S", group = "Session" },
      { "<Leader>t", group = "Terminal" },
      { "<Leader>u", group = "UI/UX" },
      { "<Leader>x", group = "Lists" },
    },
  },
}
