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
          adapter = "qwen",
        },
        inline = {
          adapter = "qwen_coder ",
        },
      },
      adapters = {
        qwen = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://api.deepinfra.com/v1/openai",
              api_key = "cmd:cat ~/.ssh/keys/deepinfa-key",
              chat_url = "/chat/completions",
            },
            schema = {
              model = {
                default = "Qwen/Qwen2.5-72B-Instruct",
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
        qwen_coder = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://api.deepinfra.com/v1/openai",
              api_key = "cmd:cat ~/.ssh/keys/deepinfa-key",
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
              api_key = "cmd:cat ~/.ssh/keys/googleai-api-key",
            },
            schema = {
              model = {
                default = "gemini-2.0-flash-exp",
                -- default = "gemini-exp-1206",
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
          provider = "default",
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
