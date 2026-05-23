return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup {
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        background = {
          dark = "dragon",
          light = "lotus",
        },
      }
      vim.cmd.colorscheme "kanagawa"
    end,
  },
  {
    "taiwbi/bearded-theme.nvim",
    lazy = true,
    config = function() vim.g.bearded_variant = "monokai_stone" end,
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = true, priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      options = {
        theme = "auto",
        italic_comments = true,
      },
    },
  },
  { "dgox16/oldworld.nvim", lazy = true, priority = 1000 },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      theme = "dark",
      styles = {
        type = { bold = true },
        lsp = { underline = false },
        match_paren = { underline = true },
      },
    },
  },
  { "shaunsingh/nord.nvim", lazy = true },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    opts = { contrast = "hard" },
  },
}
