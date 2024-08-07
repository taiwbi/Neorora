-- Customize ChatGPT plugins

return {
  "jackMort/ChatGPT.nvim",
  config = function()
    require("chatgpt").setup {
      openai_params = {
        model = "gpt-4o",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.4,
        top_p = 0.1,
        n = 1,
      },
    }
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = {
    "ChatGPT",
    "ChatGPTActAs",
    "ChatGPTEditWithInstructions",
    "ChatGPTRun",
    "ChatGPTCompleteCode",
  },
  keys = {
    { "<Leader>ac", function() vim.cmd "ChatGPTCompleteCode" end, desc = "Get code suggestion from GPT" },
  },
}
