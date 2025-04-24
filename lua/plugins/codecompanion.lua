return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
    },
    display = {
      chat = {
        window = {
          width = 0.25,
        },
      },
    },
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "GEMINI_KEY",
          },
          schema = {
            model = {
              default = "gemini-2.5-pro-exp-03-25",
            },
          },
        })
      end,
      opts = {
        allow_insecure = true,
        proxy = "socks5://192.168.1.50:1080",
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
