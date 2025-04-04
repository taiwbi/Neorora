return {
  "taiwbi/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local minuet_options = {
      cmp = {
        enable_auto_complete = false,
      },
      blink = {
        enable_auto_complete = false,
      },
      virtualtext = {
        auto_trigger_ft = {
          "python",
          "lua",
          "php",
          "javascript",
          "typescript",
          "rust",
          "c",
          "cpp",
          "sh",
          "bash",
          "zsh",
          "fish",
          "dockerfile",
          "sql",
          "mysql",
        },
        keymap = {
          accept = "<A-a>",
          accept_line = "<A-A>",
          prev = "<A-[>",
          next = "<A-]>",
          dismiss = "<A-e>",
        },
      },
      provider = "openai_fim_compatible",
      context_window = 4500,
      throttle = 2000,
      debounce = 1000,
      request_timeout = 3,
      n_completions = 1,
      notify = "debug",
      provider_options = {
        openai_fim_compatible = {
          model = "Qwen/Qwen2.5-Coder-32B-Instruct",
          end_point = "https://api.deepinfra.com/v1/inference/",
          api_key = "DEEPINFRA_API_KEY",
          name = "DeepInfra",
          stream = true,
          template = {
            prompt = function(context_before_cursor, context_after_cursor)
              return "<|fim_prefix|>"
                .. context_before_cursor
                .. "<|fim_suffix|>"
                .. context_after_cursor
                .. "<|fim_middle|>"
            end,
            suffix = false,
          },
          header_transform = function(endpoint, headers)
            -- Append model name to endpoint as required by DeepInfra
            return endpoint .. "Qwen/Qwen2.5-Coder-32B-Instruct", headers
          end,
          body_transform = function(data)
            -- DeepInfra expects 'input' instead of 'prompt'
            return {
              input = data.prompt,
              stream = data.stream,
            }
          end,
          get_text_fn = {
            no_stream = function(json)
              -- DeepInfra non-streaming response format
              return json.results[1].generated_text
            end,
            stream = function(json)
              -- DeepInfra streaming response format
              return json.token.text
            end,
          },
          n_completions = 2, -- Request 2 completions
        },
      },
    }

    require("minuet").setup(minuet_options)
  end,
}
