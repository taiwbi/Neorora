local handle
local proxy_host
local proxy_port

handle = io.popen "gsettings get org.gnome.system.proxy.socks host"
if handle then
  proxy_host = handle:read "*a"
  handle:close()
  proxy_host = proxy_host:gsub("^%s*'([^']*)'.*", "%1")
  print(proxy_host)
end

handle = io.popen "gsettings get org.gnome.system.proxy.socks port"
if handle then
  proxy_port = handle:read "*a"
  handle:close()
  proxy_port = proxy_port:gsub("^%s*(.-)%s*$", "%1")
end

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "codecompanion" },
      },
      ft = { "markdown", "codecompanion" },
    },
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
            opts = {
              allow_insecure = false,
              proxy = "",
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
            opts = {
              allow_insecure = true,
              proxy = "socks5://" .. proxy_host .. ":" .. proxy_port,
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
