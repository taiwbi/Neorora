-- Helper: Check if cursor is in a PHP injection using native Treesitter
local function is_php_context()
  local ok, node = pcall(vim.treesitter.get_node)
  if not ok or not node then
    -- Fallback: Check if line starts with typical PHP chars like $ or includes <?php / @php
    local line = vim.api.nvim_get_current_line()
    return line:match "^%s*%$" or line:match "^%s*@php" or line:match "<?php"
  end

  -- Check the language of the node (injection)
  local lang = node:type() -- specific node type
  -- Traverse up to find if we are in a php_only or php block
  while node do
    local type = node:type()
    if type == "php_only" or type == "php" or type == "program" then
      -- Verify the parser language if possible, but usually node type is enough
      return true
    end
    node = node:parent()
  end
  return false
end

local function toggle_comment()
  local mode = vim.api.nvim_get_mode().mode
  local is_visual = mode:match "[vV\22]" -- v, V, or Ctrl-v

  -- 1. Determine Comment Syntax based on context
  local is_php = is_php_context()
  local left_marker = is_php and "/* " or "{{-- "
  local right_marker = is_php and " */" or " --}}"
  local single_marker = is_php and "// " or nil -- Only used for single line PHP

  -- 2. Handle VISUAL MODE (Block Commenting)
  if is_visual then
    -- Exit visual mode to update marks
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)

    -- Wait a tiny bit for marks to update (process immediately in next loop tick)
    vim.schedule(function()
      local start_line = vim.fn.line "'<" - 1
      local end_line = vim.fn.line "'>" - 1
      local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)

      if #lines == 0 then return end

      -- Calculate minimum indentation
      local min_indent = 1000
      for _, line in ipairs(lines) do
        if line:match "%S" then
          local indent = line:match "^(%s*)"
          min_indent = math.min(min_indent, #indent)
        end
      end
      if min_indent == 1000 then min_indent = 0 end
      local indent_str = string.rep(" ", min_indent)

      -- Check if already commented (Look at first and last line content)
      -- We check the stripped content of the first and last line
      local first_stripped = lines[1]:sub(min_indent + 1)
      local last_stripped = lines[#lines]:sub(min_indent + 1)

      -- Escape markers for lua patterns
      local esc_left = left_marker:gsub("([%W])", "%%%1")
      local esc_right = right_marker:gsub("([%W])", "%%%1")

      local is_commented = first_stripped:match("^" .. esc_left) and last_stripped:match(esc_right .. "$")

      if is_commented then
        -- UNCOMMENT BLOCK
        -- Remove marker from first line
        lines[1] = lines[1]:gsub(esc_left, "", 1)
        -- Remove marker from last line (reverse search workaround)
        lines[#lines] = lines[#lines]:gsub(esc_right .. "$", "")
      else
        -- COMMENT BLOCK
        -- Add marker to first line after indentation
        lines[1] = indent_str .. left_marker .. lines[1]:sub(min_indent + 1)
        -- Add marker to end of last line
        lines[#lines] = lines[#lines] .. right_marker
      end

      vim.api.nvim_buf_set_lines(0, start_line, end_line + 1, false, lines)
    end)

  -- 3. Handle NORMAL MODE (Single Line)
  else
    local curr_line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
    local line = vim.api.nvim_get_current_line()
    local indent, content = line:match "^(%s*)(.*)"

    if content == "" then return end -- Ignore empty lines

    -- PHP Single line logic (//)
    if is_php and single_marker then
      if content:match "^//" then
        -- Uncomment
        local new_content = content:gsub("^//%s?", "")
        vim.api.nvim_set_current_line(indent .. new_content)
      else
        -- Comment
        vim.api.nvim_set_current_line(indent .. single_marker .. content)
      end
      return
    end

    -- Blade / PHP Block-style Single line logic
    local esc_left = left_marker:gsub("([%W])", "%%%1")
    local esc_right = right_marker:gsub("([%W])", "%%%1")

    if content:match("^" .. esc_left) and content:match(esc_right .. "$") then
      -- Uncomment
      local inner = content:match("^" .. esc_left .. "(.-)" .. esc_right .. "$")
      -- Remove padding spaces if they exist
      inner = inner:gsub("^%s+", ""):gsub("%s+$", "")
      vim.api.nvim_set_current_line(indent .. inner)
    else
      -- Comment
      vim.api.nvim_set_current_line(indent .. left_marker .. content .. right_marker)
    end
  end
end

-- Map keys
vim.keymap.set({ "n", "x" }, "<leader>/", toggle_comment, { buffer = true, desc = "Smart Blade Comment" })
