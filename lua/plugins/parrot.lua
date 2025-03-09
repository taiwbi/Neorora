-- Customize Parrot AI plugins

return {
  "frankroeder/parrot.nvim",
  dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim", "rcarriga/nvim-notify" },
  cmd = {
    "PrtChatNew",
    "PrtChatToggle",
    "PrtChatPaste",
    "PrtInfo",
    "PrtContext",
    "PrtChatFinder",
    "PrtChatDelete",
    "PrtChatRespond",
    "PrtStop",
    "PrtProvider",
    "PrtModel",
    "Interactive",
    "PrtRewrite",
    "PrtAppend",
    "PrtPrepend",
    "PrtNew",
    "PrtEnew",
    "PrtVnew",
    "PrtTabnew",
    "Example",
    "PrtImplement",
    "PrtAsk",
    "PrtAddto",
    "PrtAddBefore",
  },
  config = function()
    require("parrot").setup {
      -- Providers must be explicitly added to make them available.
      providers = {
        custom = {
          style = "openai",
          api_key = os.getenv "DEEPINFRA_API_KEY",
          endpoint = "https://api.deepinfra.com/v1/openai/chat/completions",
          models = {
            "Qwen/Qwen2.5-72B-Instruct",
            "Qwen/Qwen2.5-Coder-32B-Instruct",
            "Qwen/Qwen2.5-7B-Instruct",
            "Qwen/QwQ-32B",
          },
          topic = {
            model = "Qwen/Qwen2.5-7B-Instruct",
            params = { max_completion_tokens = 64 },
          },
          params = {
            chat = {
              model = "Qwen/QwQ-32B",
              temperature = 0.7,
              top_p = 1,
            },
            command = {
              model = "Qwen/Qwen2.5-Coder-32B-Instruct",
              temperature = 0.7,
              top_p = 1,
            },
          },
        },
        gemini = {
          api_key = os.getenv "GOOGLE_AI_API_KEY",
          topic = {
            model = "gemini-1.5-flash",
          },
          params = {
            chat = {
              model = "gemini-2.0-flash-lite",
              max_tokens = 4096,
            },
            command = {
              model = "gemini-2.0-pro-exp-02-05",
              max_tokens = 4096,
            },
          },
        },
      },
      toggle_target = "popup",
      chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>g" },
      chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
      chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
      chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },

      curl_params = {
        "-x",
        "socks5://192.168.43.1:1080",
        "--noproxy",
        "''",
      },
    }
  end,
}
