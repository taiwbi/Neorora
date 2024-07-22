local uv = vim.loop
local api = vim.api
local cmd = vim.cmd

-- Configuration
local config = {
  dark_theme = "adwaita",
  light_theme = "adwaita",
  debug = false, -- Set to true for debug output
}

-- Utility function for debug logging
local function debug_log(message)
  if config.debug then print("[gnome_colorscheme] " .. message) end
end

-- Function to get current GNOME color scheme
local function get_gnome_color_scheme()
  local handle = io.popen "gsettings get org.gnome.desktop.interface color-scheme"
  if not handle then
    debug_log "Failed to execute gsettings command"
    return nil
  end
  local result = handle:read "*a"
  handle:close()

  if result:match "prefer%-dark" then
    return "dark"
  elseif result:match "prefer%-light" or result:match "default" then
    return "light"
  else
    debug_log("Unexpected color scheme value: " .. result)
    return nil
  end
end

-- Function to set Neovim colorscheme based on GNOME color scheme
local function set_colorscheme()
  local scheme = get_gnome_color_scheme()
  if not scheme then
    debug_log "Failed to get GNOME color scheme"
    return
  end

  vim.schedule(function()
    if scheme == "dark" then
      vim.opt.background = "dark"
      cmd("colorscheme " .. config.dark_theme)
    else
      vim.opt.background = "light"
      cmd("colorscheme " .. config.light_theme)
    end
    debug_log("Set colorscheme to " .. scheme)
  end)
end

-- Monitor GNOME color scheme changes
local function start_monitor()
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local handle, pid

  local function on_exit(code, signal)
    stdout:close()
    stderr:close()
    debug_log("Monitor process exited with code " .. code .. " and signal " .. signal)
    -- Restart the monitor after a short delay
    vim.defer_fn(start_monitor, 5000)
  end

  handle, pid = uv.spawn("gsettings", {
    args = { "monitor", "org.gnome.desktop.interface", "color-scheme" },
    stdio = { nil, stdout, stderr },
  }, on_exit)

  if not handle then
    debug_log "Failed to start gsettings monitor"
    return
  end

  debug_log("Started gsettings monitor with PID " .. pid)

  uv.read_start(stdout, function(err, data)
    if err then
      debug_log("stdout read error: " .. err)
    elseif data then
      debug_log "Color scheme change detected"
      vim.schedule(set_colorscheme)
    end
  end)

  uv.read_start(stderr, function(err, data)
    if err then
      debug_log("stderr read error: " .. err)
    elseif data then
      debug_log("stderr: " .. data)
    end
  end)
end

-- Function to initialize the plugin
local function init()
  -- Create an autocommand group for this plugin
  api.nvim_create_augroup("GnomeColorScheme", { clear = true })

  -- Set colorscheme when Neovim starts
  api.nvim_create_autocmd("VimEnter", {
    group = "GnomeColorScheme",
    callback = set_colorscheme,
  })

  -- Start monitoring GNOME color scheme changes
  start_monitor()
end

-- Initialize the plugin
init()

-- Return the module
return {
  set_colorscheme = set_colorscheme,
  get_gnome_color_scheme = get_gnome_color_scheme,
}
