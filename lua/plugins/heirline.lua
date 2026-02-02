return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.winbar = nil
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = {
          icon = { kind = "VimIcon", padding = { right = 1, left = 1 } },
        },
        surround = { separator = "rounded_right" },
      },
      status.component.file_info {
        filename = {},
        filetype = false,
      },
      status.component.fill(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.nav {
        scrollbar = false,
        padding = { right = 1 },
      },
      status.component.mode {
        surround = { separator = "rounded_left" },
      },
    }
  end,
}
