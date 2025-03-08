return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    local mode_text = status.utils.surround({ "", " " }, function()
      local mode_colors = {
        n = "#717C7C",
        i = "#2D4F67",
        v = "#54546D",
        V = "#54546D",
        [""] = "#54546D",
        c = "#e2c08d",
        R = "#FF5D62",
        t = "#76946A",
        ["!"] = "#658594",
      }

      local mode = vim.fn.mode()
      return mode_colors[mode] or "#C8C093"
    end, {
      provider = status.provider.mode_text {
        icon = { kind = "VimIcon", padding = { right = 1 } },
        padding = { left = 0, right = 0 },
      },
      hl = status.hl.mode,
    })

    local git_branch = status.utils.surround({ "", " " }, function() return "#FF9E3B" end, {
      provider = status.provider.git_branch {
        icon = { kind = "GitBranch", padding = { right = 1 } },
        padding = { left = 0, right = 0 },
      },
      -- Change text color
      hl = function()
        local branch_name = vim.b.gitsigns_head
        if branch_name == "main" or branch_name == "master" then
          return { fg = "#252535" }
        elseif branch_name == "develop" then
          return { fg = "#43242B" }
        else
          return { fg = "#2D4F67" }
        end
      end, -- default
    })

    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      mode_text,
      git_branch,
      status.component.file_info { surround = { separator = "none" } },
      status.component.git_diff { surround = { separator = "none" } },
      status.component.diagnostics { surround = { separator = "none" } },
      status.component.fill(),
      status.component.cmd_info { surround = { separator = "none" } },
      status.component.fill(),
      status.component.lsp {
        lsp_progress = false,
        hl = {
          bg = "#363646",
          fg = "#C8C093",
        },
        surround = { separator = "left", color = "#363646" },
      },
      status.component.virtual_env(),
      status.component.nav {
        scrollbar = false,
        percentage = false,
        surround = { separator = "none", padding = { left = 1 } },
      },
    }
    opts.winbar = { -- winbar
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false,
      { -- inactive winbar
        condition = function() return not status.condition.is_active() end,
        status.component.separated_path(),
        status.component.file_info {
          filename = {},
          filetype = false,
          file_read_only = false,
          hl = {
            bg = "#363646",
            fg = "#C8C093",
          },
          surround = { separator = "left", color = "#363646" },
          update = "BufEnter",
        },
      },
      { -- active winbar
        status.component.file_info {
          filename = {},
          filetype = false,
          file_read_only = false,
          hl = {
            bg = "#363646",
            fg = "#C8C093",
          },
          surround = { separator = "left", color = "#363646" },
        },
        status.component.breadcrumbs {
          hl = status.hl.get_attributes("winbar", true),
        },
      },
    }

    opts.tabline = { -- tabline
      { -- file tree padding
        condition = function(self)
          self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
          self.winwidth = vim.api.nvim_win_get_width(self.winid)
          return self.winwidth ~= vim.o.columns -- only apply to sidebars
            and not require("astrocore.buffer").is_valid(vim.api.nvim_win_get_buf(self.winid)) -- if buffer is not in tabline
        end,
        provider = function(self) return (" "):rep(self.winwidth + 1) end,
        hl = { bg = "tabline_bg" },
      },
      status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
      status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
      { -- tab list
        condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
        status.heirline.make_tablist { -- component for each tab
          provider = status.provider.tabnr(),
          hl = function(self) return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true) end,
        },
        { -- close button for current tab
          provider = status.provider.close_button {
            kind = "TabClose",
            padding = { left = 1, right = 1 },
          },
          hl = status.hl.get_attributes("tab_close", true),
          on_click = {
            callback = function() require("astrocore.buffer").close_tab() end,
            name = "heirline_tabline_close_tab_callback",
          },
        },
      },
    }

    opts.statuscolumn = { -- statuscolumn
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      status.component.foldcolumn(),
      status.component.numbercolumn(),
      status.component.signcolumn(),
    }
  end,
}
