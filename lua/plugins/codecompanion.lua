local M = {}

local function get_gnome_proxy_setting(setting_type)
  local handle = io.popen("gsettings get org.gnome.system.proxy.socks " .. setting_type)
  if not handle then return nil end

  local value = handle:read "*a"
  handle:close()

  if setting_type == "host" then
    -- Extract the host from single quotes, trimming whitespace
    value = value:gsub("^%s*'([^']*)'.*", "%1")
  elseif setting_type == "port" then
    -- Trim any leading or trailing whitespace from the port
    value = value:gsub("^%s*(.-)%s*$", "%1")
  end
  -- Check empty string
  return value ~= "" and value or nil
end

local proxy_host = get_gnome_proxy_setting "host"
local proxy_port = get_gnome_proxy_setting "port"

M.codecompanion_config = {
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
    local codecompanion_opts = {
      strategies = {
        chat = {
          adapter = "qwen",
        },
        inline = {
          adapter = "qwen",
        },
      },
      adapters = {
        qwen = require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://api.deepinfra.com/v1/openai",
            api_key = "cmd: echo $DEEPINFRA_API_KEY",
            chat_url = "/chat/completions",
          },
          schema = {
            model = {
              default = "Qwen/Qwen2.5-72B-Instruct",
            },
            temperature = {
              default = 0.85,
            },
            max_tokens = {
              default = 8192,
            },
          },
        }),
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
    -- Conditionally add the proxy setting if both host and port are available
    if proxy_host and proxy_port then
      codecompanion_opts.adapters.opts = {}
      codecompanion_opts.adapters.opts.proxy = "socks5://" .. proxy_host .. ":" .. proxy_port
      codecompanion_opts.adapters.opts.allow_insecure = true
    end
    require("codecompanion").setup(codecompanion_opts)
  end,
}

return M.codecompanion_config
