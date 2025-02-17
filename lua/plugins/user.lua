-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod" },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>Db", function() vim.cmd "DBUIToggle" end, desc = "Toggle Databse UI" },
      { "<leader>Da", function() vim.cmd "DBUIAddConnection" end, desc = "Add Database Connection" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "sql", "mysql", "plsql" },
        callback = function() require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } } end,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "User AstroFile",
  },
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.typescript" },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        winblend = 0,
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      float_opts = {
        winblend = 0,
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    enabled = vim.fn.executable "fd" == 1 or vim.fn.executable "fdfind" == 1 or vim.fn.executable "fd-find" == 1,
    dependencies = {
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>lv"] = { "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv" },
            },
          },
        },
      },
    },
    opts = {},
    cmd = "VenvSelect",
  },
  -- Install packages to make image.nvim work: dnf install ImageMagick ImageMagick-devel luarocks
  -- luarocks --local --lua-version=5.1 install magick
  {
    "3rd/image.nvim",
    opts = {},
    enabled = function()
      if vim.env.TERM == "xterm-kitty" or vim.env.TERM == "xterm-ghostty" then return true end
      return false
    end,
  },
  { "echasnovski/mini.nvim", version = "*", config = function() require("mini.diff").setup() end },
  -- INFO: Themes
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("kanagawa").setup {
        theme = "dragon", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "dragon", -- try "dragon" !
          light = "lotus",
        },
      }
    end,
  },
  { "akinsho/horizon.nvim", version = "*" },
  { "olivercederborg/poimandres.nvim", lazy = true, opts = {} },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
