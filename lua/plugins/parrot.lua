-- Customize Parrot AI plugins

return {
  "frankroeder/parrot.nvim",
  tag = "v0.4.2",
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
    local anthropic_api_file = io.open(os.getenv "HOME" .. "/.ssh/keys/anthropic-api-key")
    local google_api_file = io.open(os.getenv "HOME" .. "/.ssh/keys/googleai-api-key")
    if not anthropic_api_file then
      print "No API Key File for Anthropic"
      return
    end
    local anthropic_key = anthropic_api_file:read("*a"):gsub("%s+", "")
    local google_key = google_api_file:read("*a"):gsub("%s+", "")
    require("parrot").setup {
      -- Providers must be explicitly added to make them available.
      providers = {
        anthropic = {
          api_key = anthropic_key,
          topic = {
            model = "claude-3-haiku-20240307",
            params = { max_tokens = 64 },
          },
          params = {
            chat = {
              model = "claude-3-5-sonnet-20240620",
              max_tokens = 4096,
            },
            command = {
              model = "claude-3-5-sonnet-20240620",
              max_tokens = 4096,
            },
          },
        },
        gemini = {
          api_key = google_key,
          topic = {
            model = "gemini-1.5-flash-8b",
          },
          params = {
            chat = {
              model = "gemini-1.5-pro",
              max_tokens = 4096,
            },
            command = {
              model = "gemini-1.5-pro",
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

      hooks = {
        Addto = function(parrot, params)
          local template = [[
          I have the following code from {{filename}}:

          ```{{filetype}}
          {{selection}}
          ```
          
          new logic: {{command}}
          Add the new logic at the end of the code according to the new logic,
          Respond just with the snippet of code that should be inserted. Do not rewrite the existing code at all.
          If explaining is needed do it in comments. Do not write anything else but the actual code.
          Do not wrap code inside code blocks or ```. Just write a pure code that should be added to the end of provided code
          ]]
          local model_obj = parrot.get_model "command"
          parrot.Prompt(params, parrot.ui.Target.append, model_obj, "🦜 Ask ~ ", template)
        end,
        AddBefore = function(parrot, params)
          local template = [[
          You are tasked with adding new code to an existing piece of code. Here is the existing code:

          ```{{filetype}}
          {{EXISTING_CODE}}
          ```

          Your task is to add new code at the top of this existing code. The new code should do this: {{command}}

          Follow these instructions carefully: 

          1. Do not modify or rewrite any part of the existing code.
          2. The new code will be placed at the very top of the existing code, before any other lines.
          4. Do not add any additional descriptions or other modifications.
          5. Do not wrap the result in code blocks or any markdown formatting.

          Provide your response by simply outputting the new code, with descriptions. Do not include any explanations, or additional formatting in your response.
          ]]
          local model_obj = parrot.get_model "command"
          parrot.Prompt(params, parrot.ui.Target.prepend, model_obj, "🦜 Ask ~ ", template)
        end,
      },
    }
  end,
}
