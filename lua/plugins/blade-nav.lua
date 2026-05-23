return {
  "ricardoramirezr/blade-nav.nvim",
  ft = { "blade", "php" },
  dependencies = { "saghen/blink.compat" },
  specs = {
    {
      "saghen/blink.cmp",
      optional = true,
      opts = {
        sources = {
          default = { "blade_nav" },
          providers = {
            blade_nav = {
              name = "blade-nav",
              module = "blink.compat.source",
              min_keyword_length = 1,
              score_offset = -1,
            },
          },
        },
      },
    },
  },
}
