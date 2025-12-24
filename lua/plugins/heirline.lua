return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.winbar = nil
    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = { padding = { left = 1, right = 1 } },
      },
      status.component.git_branch(),
      status.component.builder {
        {
          provider = function() return "󱑒 " .. os.date "%H:%M" .. " " end,
        },
      },
      status.component.file_info {
        filename = {},
        filetype = false,
      },
      status.component.git_diff(),
      status.component.builder {
        padding = { left = 0 },
      },
      status.component.breadcrumbs { icon = { enabled = false } },
      status.component.fill(),
      status.component.diagnostics(),
      status.component.virtual_env(),
      status.component.cmd_info(),
      status.component.nav {
        scrollbar = false,
        padding = { right = 1 },
      },
      status.component.mode { surround = { separator = "right" } },
    }
  end,
}
