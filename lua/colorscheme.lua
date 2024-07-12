-- File: gnome_colorscheme.lua

local uv = vim.loop

-- Function to get current GNOME color scheme
local function get_gnome_color_scheme()
  local handle = io.popen "gsettings get org.gnome.desktop.interface color-scheme"
  local result = handle:read "*a"
  handle:close()
  if result:match "prefer%-dark" then
    return "dark"
  elseif result:match "prefer%-light" then
    return "light"
  else
    return nil
  end
end

-- Function to set Neovim colorscheme based on GNOME color scheme
local function set_colorscheme()
  local scheme = get_gnome_color_scheme()
  if scheme == "dark" then
    vim.schedule_wrap(function()
      vim.cmd "colorscheme adwaita" -- Set your preferred dark theme
    end)()
  elseif scheme == "light" then
    vim.schedule_wrap(function()
      vim.cmd "colorscheme adwaita" -- Set your preferred light theme
    end)()
  end
end

-- Set colorscheme when Neovim starts
set_colorscheme()

-- Monitor GNOME color scheme changes
local function start_monitor()
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)

  local handle
  handle = uv.spawn("gsettings", {
    args = { "monitor", "org.gnome.desktop.interface", "color-scheme" },
    stdio = { nil, stdout, stderr },
  }, function()
    stdout:close()
    stderr:close()
    handle:close()
  end)

  uv.read_start(stdout, function(err, data)
    if err then
      print("Error: ", err)
      return
    end
    if data then vim.schedule(set_colorscheme) end
  end)

  uv.read_start(stderr, function(err, data)
    if err then print("Error: ", err) end
    if data then print("stderr: ", data) end
  end)
end

-- Start monitoring GNOME color scheme changes
start_monitor()
