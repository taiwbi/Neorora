-- You can also add or configure plugins by creating files in this `plugins/` folder

---@type LazySpec
return {
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
    "EthanJWright/vs-tasks.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      picker = "snacks", -- Use snacks.nvim picker instead of telescope
    },
    config = function(_, opts)
      require("vstask").setup {
        picker = "snacks", -- Use snacks.nvim picker
        cache_json_conf = true,
        cache_strategy = "last",
        config_dir = ".vscode",
        support_code_workspace = true,
      }
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },
  {
    "xStormyy/bearded-theme.nvim",
    lazy = false,
    config = function() vim.g.bearded_variant = "monokai_stone" end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
