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
          model = "qwen/qwen-2.5-coder-32b-instruct",
          end_point = "https://openrouter.ai/api/v1/completions",
          api_key = "OPENROUTER_KEY",
          name = "OpenRouter",
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
              args.body.provider = {
                order = { "deepinfra/fp8" },
                allow_fallbacks = false,
              }
              return args
            end,
          },
          optional = {
            max_tokens = 512,
            top_p = 0.9,
            temperature = 0.45,
            -- provider = "deepinfra/fp8",
          },
          n_completions = 2,
        },
      },
    }

    require("minuet").setup(minuet_options)
  end,
}
