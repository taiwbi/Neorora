return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  config = function()
    require("codecompanion").setup {
      strategies = {
        chat = {
          adapter = "qwen_coder",
        },
        inline = {
          adapter = "qwen_coder ",
        },
      },
      adapters = {
        qwen_coder = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://api.deepinfra.com/v1/openai",
              api_key = "DEEPINFRA_API_KEY",
              chat_url = "/chat/completions",
            },
            schema = {
              model = {
                default = "Qwen/Qwen2.5-Coder-32B-Instruct",
              },
              temperature = {
                default = 0.4,
              },
              max_tokens = {
                default = 8192,
              },
            },
          })
        end,
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "GOOGLE_AI_API_KEY",
            },
            schema = {
              model = {
                default = "gemini-exp-1206",
              },
              temperature = {
                default = 0.4,
              },
              max_tokens = {
                default = 8192,
              },
            },
          })
        end,
      },

      display = {
        diff = {
          provider = "mini_diff",
        },
        chat = {
          window = {
            height = 0.8,
            width = 0.3,
          },
        },
      },
    }
  end,
}
