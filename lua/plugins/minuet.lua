return {
  "milanglacier/minuet-ai.nvim",
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
          "blade",
          "javascript",
          "css",
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
          "yaml",
          "spec",
          "make",
        },
        keymap = {
          accept = "<A-a>",
          prev = "<A-[>",
          next = "<A-]>",
        },
      },
      provider = "openai_fim_compatible",
      context_window = 3500,
      -- notify = "debug",
      throttle = 300,
      debounce = 500,
      request_timeout = 3,
      n_completions = 1,
      provider_options = {
        openai_fim_compatible = {
          model = "Qwen/Qwen2.5-Coder-32B-Instruct",
          end_point = "https://api.deepinfra.com/v1/inference/",
          api_key = "DEEPINFRA_KEY",
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
          transform = {
            function(args)
              args.end_point = args.end_point .. args.body.model
              args.body.model = nil
              args.body.input = args.body.prompt
              args.body.prompt = nil
              args.body.suffix = nil
              return args
            end,
          },
          get_text_fn = {
            no_stream = function(json) return json.results[1].generated_text end,
            stream = function(json) return json.token.text end,
          },
          optional = {
            max_tokens = 1024,
            top_p = 0.9,
            temperature = 0.45,
          },
          n_completions = 2,
        },
      },
    }

    require("minuet").setup(minuet_options)
  end,
}
