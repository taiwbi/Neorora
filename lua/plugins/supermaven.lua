return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  opts = {
    keymaps = {
      accept_suggestion = "<A-a>",
      clear_suggestion = "<C-]>",
      accept_word = "<C-j>",
    },
  },
}
