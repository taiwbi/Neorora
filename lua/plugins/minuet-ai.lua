local M = {}

local function read_file_content(filepath)
  local file = io.open(filepath, "r")
  if not file then
    return nil -- Return nil if the file doesn't exist or can't be opened.
  end
  local content = file:read "*all"
  file:close()
  return content
end

M.minuet_config = {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local home_dir = os.getenv "HOME"
    local config_base_path = home_dir .. "/.config/nvim/lua/plugins/ai"
    local prompt_path = config_base_path .. "/minuet-prompt.md"
    local guidelines_path = config_base_path .. "/minuet-guidelines.md"
    local few_shot_user_path = config_base_path .. "/minuet-examples/1-user.txt"
    local few_shot_assistant_path = config_base_path .. "/minuet-examples/1-assistant.txt"

    -- Read file contents, handling potential errors gracefully.
    local prompt = read_file_content(prompt_path)
    local guidelines = read_file_content(guidelines_path)
    local few_shot_user = read_file_content(few_shot_user_path)
    local few_shot_assistant = read_file_content(few_shot_assistant_path)

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
      context_window = 4500,
      throttle = 2000,
      debounce = 1000,
      request_timeout = 3,
      n_completions = 1,
      proxy = nil, -- Consider using a function similar to the codecompanion one if needed
      notify = "debug",
      provider_options = {
        openai_compatible = {
          model = "Qwen/Qwen2.5-Coder-32B-Instruct",
          end_point = "https://api.deepinfra.com/v1/openai/chat/completions",
          system = {
            template = "{{{prompt}}}\n{{{guidelines}}}\n{{{n_completion_template}}}",
            prompt = prompt or "Default prompt", -- Use a default if file reading fails
            guidelines = guidelines or "Default guidelines", -- Use a default if file reading fails
            n_completion_template = "",
          },
          few_shots = {}, -- Initialize as empty, then add conditionally
          api_key = "DEEPINFRA_API_KEY",
          name = "Qwen",
          stream = true,
          optional = {
            stop = nil,
            max_tokens = 2048,
          },
        },
      },
    }

    -- Conditionally add few-shot examples if files were read successfully
    if few_shot_user and few_shot_assistant then
      table.insert(minuet_options.provider_options.openai_compatible.few_shots, {
        role = "user",
        content = few_shot_user,
      })
      table.insert(minuet_options.provider_options.openai_compatible.few_shots, {
        role = "assistant",
        content = few_shot_assistant,
      })
    end

    require("minuet").setup(minuet_options)
  end,
}

return M.minuet_config
