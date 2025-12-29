return {
  "saghen/blink.cmp",
  optional = true,
  opts = {
    sources = {
      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
        mysql = { "snippets", "dadbod", "buffer" },
        plsql = { "snippets", "dadbod", "buffer" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
  },
}
