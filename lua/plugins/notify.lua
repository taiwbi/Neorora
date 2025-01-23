return {
  "rcarriga/nvim-notify",
  config = function(_, opts)
    local notify = require "notify"
    -- If you remove these two lines and turn on transparency, You'll get annoying warnings
    local hl_color = vim.api.nvim_get_hl_by_name("Normal", true).background
    opts.background_colour = string.format("#%06x", hl_color or 0)
    notify.setup(opts)
    vim.notify = notify
  end,
  enabled = false,
}
