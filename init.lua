-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
require "colorscheme"
require "tricks"

--FIX: This is not a standard way to define custom LSP in AstroNVIM. But I couldn't make it work any other way
-- If you wish to fix this check AstroNvim documentation and send a pull request if you managed to fix it :)
-- https://docs.astronvim.com/recipes/advanced_lsp/#custom-lsp-definition

local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"

-- Configure it
configs.blade = {
  default_config = {
    -- Path to the executable: laravel-dev-generators
    cmd = { "laravel-dev-tools", "lsp" },
    filetypes = { "blade" },
    root_dir = function(fname) return lspconfig.util.find_git_ancestor(fname) end,
    settings = {},
  },
}
-- Set it up
lspconfig.blade.setup {
  -- Capabilities is specific to my setup.
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}
