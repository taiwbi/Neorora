-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Wrap HTML CSS Classes on long lines (more than 120 characters)
vim.api.nvim_create_user_command("WrapCssClasses", function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local new_lines = {}

  for _, line in ipairs(lines) do
    if line:match 'class=".-"' then
      local indent = line:match "^%s*"
      local indent_len = #indent

      local class_start = line:find 'class="'
      if class_start then
        local class_prefix = line:sub(1, class_start + 6)
        local class_content_start = class_start + 7

        local class_content_end = line:find('"', class_content_start)
        if class_content_end then
          local class_content = line:sub(class_content_start, class_content_end - 1)
          local suffix = line:sub(class_content_end)

          local classes = {}
          for c in class_content:gmatch "%S+" do
            table.insert(classes, c)
          end

          local current_line = class_prefix
          local continuation_indent = indent .. "    "
          local max_length = 120

          for i, class in ipairs(classes) do
            local is_first_in_line = current_line == class_prefix or current_line == continuation_indent
            local space_needed = is_first_in_line and 0 or 1
            local projected_length = #current_line + space_needed + #class

            -- Check if adding this class would exceed the max length
            if projected_length > max_length then
              table.insert(new_lines, current_line)
              current_line = continuation_indent .. class
            else
              if not is_first_in_line then current_line = current_line .. " " end
              current_line = current_line .. class
            end
          end
          table.insert(new_lines, current_line .. suffix)
        else
          table.insert(new_lines, line)
        end
      else
        table.insert(new_lines, line)
      end
    else
      table.insert(new_lines, line)
    end
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end, {})

-- Auto run WrapCssClasses after formatting certain files
vim.api.nvim_create_autocmd("User", {
  pattern = "BufWritePre",
  callback = function()
    local filetypes = { "html", "jsx", "tsx", "vue", "svelte", "php", "blade" }
    local current_ft = vim.bo.filetype

    for _, ft in ipairs(filetypes) do
      if current_ft == ft then
        vim.cmd "WrapCssClasses"
        break
      end
    end
  end,
})
vim.api.nvim_clear_autocmds {
  group = vim.api.nvim_create_augroup("WrapCssClassesAutoCommand", { clear = true }),
}

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("WrapCssClassesAutoCommand", { clear = false }),
  pattern = { "*.html", "*.php", "*.blade.php" },
  callback = function()
    vim.defer_fn(function()
      vim.cmd "WrapCssClasses"
      vim.cmd "silent! noa write"
    end, 10)
  end,
  desc = "Run WrapCssClasses after formatting",
})
