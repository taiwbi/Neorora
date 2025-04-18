-- You can also add or configure plugins by creating files in this `plugins/` folder

---@type LazySpec
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    opts = {},
  },
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "ricardoramirezr/blade-nav.nvim",
    ft = { "blade", "php" },
    specs = {
      {
        "Saghen/blink.cmp",
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
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  { "lurst/austere.vim" },
  { "nocksock/bloop.nvim", dependencies = { "rktjmp/lush.nvim" } },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "zenbones-theme/zenbones.nvim" },
  -- { "nyoom-engineering/nyoom.nvim" },
}
