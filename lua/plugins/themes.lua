return {
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
    config = function()
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
    lazy = false,
    priority = 1000,
    -- config = function() require("koda").setup { transparent = true } end,
  },
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    priority = 1000,
    opts = {
      theme = "dark",
      styles = {
        type = { bold = true },
        lsp = { underline = false },
        match_paren = { underline = true },
      },
    },
    lazy = false,
  },
  {
    "shaunsingh/nord.nvim",
  },
  {
    "nobbmaestro/nvim-andromeda",
    dependencies = { "tjdevries/colorbuddy.nvim" },

    config = function()
      require("andromeda").setup {
        preset = "andromeda",
      }
    end,
  },
}
