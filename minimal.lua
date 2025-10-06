-- init.lua - Minimalist Neovim Configuration
-- ============================================

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic settings
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of indent
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.wrap = false -- Disable line wrap
vim.opt.termguicolors = true -- True color support
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Override ignorecase if search contains uppercase
vim.opt.cmdheight = 0 -- Hide command line when not in use (merges with statusline)
vim.opt.undofile = true -- Save undo history to file
vim.opt.undodir = vim.fn.stdpath "data" .. "/undo" -- Undo files directory

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        -- Install parsers for common languages
        ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "json", "python" },

        -- Install parsers synchronously
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- Enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Enable indentation
        indent = {
          enable = true,
        },
      }
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable only the explorer (file tree)
      explorer = { enabled = true },
      quickfile = { enabled = true },
    },
    keys = {
      { "<leader>e", function() require("snacks").explorer() end, desc = "Toggle File Explorer" },
    },
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}

vim.cmd.colorscheme "catppuccin-macchiato"

-- Basic keymaps
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Split
vim.keymap.set("n", "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
