return {
  "adalessa/laravel.nvim",
  dependencies = {
    "tpope/vim-dotenv",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "kevinhwang91/promise-async",
  },
  cmd = { "Laravel" },
  keys = {
    { "<leader>ma", ":Laravel artisan<cr>" },
    { "<leader>mr", ":Laravel routes<cr>" },
    { "<leader>mm", ":Laravel related<cr>" },
  },
  event = { "VeryLazy" },
  opts = {},
  config = true,
}
