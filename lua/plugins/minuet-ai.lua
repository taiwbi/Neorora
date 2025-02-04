return {
  "milanglacier/minuet-ai.nvim",
  config = function()
    require("minuet").setup {
      cmp = {
        enable_auto_complete = false,
      },
      blink = {
        enable_auto_complete = false,
      },
      virtualtext = {
        auto_trigger_ft = {
          "py",
          "python",
          "lua",
          "php",
          "javascript",
          "typescript",
          "rust",
          "rs",
          "c",
          "cpp",
          "sh",
          "bash",
          "zsh",
          "fish",
          "dockerfile",
          "sql",
          "mysql",
          "markdown",
        },
        keymap = {
          accept = "<A-a>",
          accept_line = "<A-A>",
          prev = "<A-[>",
          next = "<A-]>",
          dismiss = "<A-e>",
        },
      },
      provider = "openai_compatible",
      context_window = 3500,
      throttle = 1000,
      debounce = 900,
      request_timeout = 3,
      n_completions = 1,
      proxy = nil,
      provider_options = {
        openai_compatible = {
          model = "Qwen/Qwen2.5-7B-Instruct",
          end_point = "https://api.deepinfra.com/v1/openai/chat/completions",
          system = {
            template = "{{{prompt}}}\n{{{guidelines}}}\n{{{n_completion_template}}}",
            prompt = io.open(os.getenv "HOME" .. "/.config/nvim/lua/plugins/ai/minuet-prompt.md", "r"):read "*all",
            guidelines = io.open(os.getenv "HOME" .. "/.config/nvim/lua/plugins/ai/minuet-guidelines.md", "r")
              :read "*all",
            n_completion_template = "",
          },
          few_shots = {
            {
              role = "user",
              content = [[
# language: python
<contextAfterCursor>

fib(5)
<contextBeforeCursor>
def fibonacci(n):
    <cursorPosition>]],
            },
            {
              role = "assistant",
              content = [[
    '''
    Recursive Fibonacci implementation
    '''
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)
<endCompletion>
    '''
    Iterative Fibonacci implementation
    '''
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a
<endCompletion>
]],
            },
          },
          api_key = "DEEPINFRA_API_KEY",
          name = "Qwen",
          stream = true,
          optional = {
            stop = nil,
            max_tokens = 1024,
          },
        },
      },
    }
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
