return {
  "rcarriga/nvim-notify",
  config = function(_, opts)
    local notify = require "notify"
    -- These two lines basically does nothing but preventing annoying notification from notify.
    local transparency = os.getenv "TRANSPARENT_VIM"
    if transparency == "true" then opts.background_colour = "#00000000" end
    notify.setup(opts)
    vim.notify = notify
  end,
}
