return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.winbar = nil

    local function has_filename() return vim.fn.expand "%:t" ~= "" end

    -- custom separator that blends into file_info_bg
    local mode_to_file_sep = {
      provider = "",
      hl = function()
        local mode_hl = status.hl.mode()
        return {
          fg = mode_hl.bg,
          bg = has_filename() and "#DA627D" or "bg",
        }
      end,
    }

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = {
          icon = { kind = "VimIcon", padding = { right = 1, left = 1 } },
        },
        padding = { right = 0 },
        surround = { separator = "mode_left_only" },
      },
      mode_to_file_sep,
      status.component.file_info {
        filename = {},
        padding = { left = 0 },
        surround = { separator = "right_continue" },
        filetype = false,
      },
      status.component.cmd_info(),
      status.component.fill(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.nav {
        scrollbar = false,
        padding = { right = 1 },
      },
      status.component.mode {
        surround = { separator = "left_start" },
      },
    }
  end,
}
