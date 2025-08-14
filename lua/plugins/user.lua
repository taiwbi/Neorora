-- You can also add or configure plugins by creating files in this `plugins/` folder

---@type LazySpec
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    opts = {},
    ft = { "markdown", "codecompanion", "Avante" },
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
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup {
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave", -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = "wave",
          light = "lotus",
        },
      }
    end,
  },
}
