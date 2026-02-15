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

-- Transparency in neovide --

vim.api.nvim_create_user_command("TransparentizeNeovide", function()
  if vim.g.neovide then
    vim.g.neovide_opacity = 0.8

    -- Define the background and foreground colors
    local bg_color = "#191a22"

    -- Update each highlight group
    vim.api.nvim_set_hl(0, "Normal", { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = bg_color })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = bg_color })
    vim.api.nvim_set_hl(0, "VertSplit", { bg = bg_color, fg = bg_color })
    vim.api.nvim_set_hl(0, "WinSeparator", { bg = bg_color, fg = bg_color })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = bg_color, fg = bg_color })
  end
end, {})

vim.api.nvim_create_user_command("ClearNeovideTransparency", function()
  if vim.g.neovide then
    vim.g.neovide_opacity = 1

    -- Define the background and foreground colors
    local bg_color = "#1f212b"

    -- Update each highlight group
    vim.api.nvim_set_hl(0, "Normal", { bg = bg_color })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = bg_color })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = bg_color })
    vim.api.nvim_set_hl(0, "VertSplit", { bg = bg_color, fg = bg_color })
    vim.api.nvim_set_hl(0, "WinSeparator", { bg = bg_color, fg = bg_color })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = bg_color, fg = bg_color })
  end
end, {})

-- Function to add italic
local function add_italic(group)
  local hl = vim.api.nvim_get_hl(0, { name = group })
  if hl and not vim.tbl_isempty(hl) then
    hl.italic = true
    vim.api.nvim_set_hl(0, group, hl)
  end
end

-- Apply italics after a delay to ensure colorscheme is loaded
vim.defer_fn(function()
  add_italic "@comment"
  add_italic "@keyword"
  add_italic "@keyword.function"
  add_italic "@keyword.operator"
  add_italic "@keyword.return"
  add_italic "@keyword.conditional"
  add_italic "@keyword.repeat"
  add_italic "@storageclass"
  add_italic "@type.builtin"
  add_italic "@constant.builtin"
  add_italic "@variable.builtin"
  add_italic "Keyword"
  add_italic "StorageClass"
  add_italic "Constant"
  add_italic "Comment"
end, 200)

-- Sync Neovim background with GNOME theme
local function sync_gnome_theme()
  local result = vim.fn.system "gsettings get org.gnome.desktop.interface color-scheme"
  if vim.v.shell_error == 0 then
    result = result:gsub("['\n\r]", "") -- Remove quotes and newlines
    local new_bg = result == "prefer-dark" and "dark" or "light"
    local new_theme = result == "prefer-dark" and "andromeda" or "catppuccin-latte"
    if vim.o.background ~= new_bg then
      vim.cmd("colorscheme " .. new_theme)
      vim.schedule(function() vim.o.background = new_bg end)
    end
  end
end

-- Run on startup
sync_gnome_theme()

-- Monitor for changes in real-time
local stdout = vim.loop.new_pipe(false)
local handle = vim.loop.spawn("gsettings", {
  args = { "monitor", "org.gnome.desktop.interface", "color-scheme" },
  stdio = { nil, stdout, nil },
}, function() stdout:close() end)

if handle then
  stdout:read_start(function(err, data)
    if not err and data then
      -- Schedule the check on the main loop
      vim.schedule(sync_gnome_theme)
    end
  end)
end

-- Fallback: Check when focusing back on Neovim
vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Sync background with GNOME theme",
  callback = sync_gnome_theme,
})
