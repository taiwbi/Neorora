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
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<A-a>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
      }
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown" },
    },
    ft = { "markdown" },
  },
  -- Themes
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
      }
    end,
  },
  {
    "taiwbi/bearded-theme.nvim",
    lazy = false,
    config = function() vim.g.bearded_variant = "monokai_stone" end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require("cyberdream").setup {
        options = {
          theme = "auto",
          italic_comments = true,
        },
      }
    end,
  },
  {
    "oskarnurm/koda.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- require("koda").setup({ transparent = true })
      -- vim.cmd "colorscheme koda"
    end,
  },
}
