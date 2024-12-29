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
        auto_trigger_ft = { "python", "lua", "php", "javascript", "rust", "rs", "c", "cpp", "markdown" },
        keymap = {
          accept = "<A-A>",
          accept_line = "<A-a>",
          prev = "<A-[>",
          next = "<A-]>",
          dismiss = "<A-e>",
        },
      },
      provider = "openai_compatible",
      context_window = 3500,
      throttle = 3000,
      debounce = 3000,
      request_timeout = 7,
      n_completions = 1,
      provider_options = {
        openai_compatible = {
          model = "meta-llama/Meta-Llama-3.1-8B-Instruct-Turbo",
          end_point = "https://api.deepinfra.com/v1/openai/chat/completions",
          system = {
            template = "{{{prompt}}}\n{{{guidelines}}}\n{{{n_completion_template}}}",
            prompt = "You are the backend of an AI-powered code completion engine. Your task is to provide code suggestions based on the user's input. The user's code will be enclosed in markers:\n\n - <contextAfterCursor>: Code context after the cursor\n - <cursorPosition>: Current cursor location\n - <contextBeforeCursor>: Code context before the cursor.\n\nNote that the user's code will be prompted in reverse order: first the code after the cursor, then the code before the cursor.",
            guidelines = "1. Offer completions after the `<cursorPosition>` marker.\n2. Make sure you have maintained the user's existing whitespace and indentation. This is REALLY IMPORTANT!\n3. Provide multiple completion options when possible.\n4. Return completions separated by the marker `<endCompletion>`.\n5. The returned message will be further parsed and processed. DO NOT include additional comments or markdown code block fences. Return the result directly.\n6. Keep each completion option concise, limiting it to a single line or a few lines.\n7. Create entirely new code completion that DO NOT REPEAT OR COPY any user's existing code around `<cursorPosition>`.\n",
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
            max_tokens = 4500,
          },
        },
      },
    }
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
