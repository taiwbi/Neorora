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
          -- Web Development
          "html",
          "css",
          "scss",
          "sass",
          "javascript",
          "typescript",
          "jsx",
          "tsx",
          "vue",
          "svelte",
          "php",
          "blade",
          "ruby",
          "elixir",
          "graphql",
          -- Systems & Application Development
          "c",
          "cpp",
          "rust",
          "go",
          "java",
          "kotlin",
          "csharp",
          "swift",
          "dart",
          "zig",
          -- Scripting & Shell
          "python",
          "lua",
          "sh",
          "bash",
          "zsh",
          "fish",
          "powershell",
          -- DevOps & Configuration
          "dockerfile",
          "terraform",
          "hcl",
          "nginx",
          "make",
          "groovy",
          "yaml",
          "toml",
          "json",
          -- Databases & Data Science
          "sql",
          "mysql",
          "xml",
          "r",
          -- Markup & Testing
          "cmake",
          "make",
          "markdown",
          "spec",
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
      throttle = 500,
      debounce = 700,
      request_timeout = 3,
      n_completions = 1,
      provider_options = {
        openai_fim_compatible = {
          model = "Qwen/Qwen3-Coder-30B-A3B-Instruct",
          end_point = "https://api.deepinfra.com/v1/inference/",
          api_key = "DEEPINFRA_KEY",
          name = "DeepInfra",
          stream = true,
          template = {
            prompt = function(context_before_cursor, context_after_cursor)
              return "<|im_start|>system\n\nComplete the text as minimal as possible, write code/text as much as it is obvious that it should be there even if it's just one character."
                .. "Do not try to predict too much and keep it just minimal. Just predict what's obvious, No more.<|im_end|>"
                .. "<|fim_prefix|>"
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
            max_tokens = 256,
            top_p = 0.9,
            temperature = 0.25,
          },
          n_completions = 2,
        },
      },
    }

    require("minuet").setup(minuet_options)
  end,
}
