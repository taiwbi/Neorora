-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "oldworld",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
      adwaita = {
        SnacksDashboardHeader = { fg = "#33B2A4" },
      },
      kanagawa = {
        -- Wave: #1F1F28
        -- Dragon: #181616
        NoicePopupBorder = { bg = "#1F1F28", fg = "#54546D" },

        NoiceCmdlinePopupBorder = { bg = "#1F1F28", fg = "#54546D" },
        NoiceCmdlinePopupBorderCmdline = { bg = "#1F1F28", fg = "#54546D" },
        NoiceCmdLineIcon = { bg = "#1F1F28", fg = "#54546D" },

        NoiceCmdlineIconSearch = { bg = "#1F1F28", fg = "#54546D" },
        NoiceCmdlinePopupBorderSearch = { bg = "#1F1F28", fg = "#54546D" },

        NoiceConfirmBorder = { bg = "#1F1F28", fg = "#54546D" },

        NoicePopupmenuBorder = { bg = "#1F1F28", fg = "#54546D" },
        NoiceSplitBorder = { bg = "#1F1F28", fg = "#54546D" },

        FloatBorder = { bg = "#1F1F28", fg = "#54546D" },

        VertSplit = { bg = "#1F1F28", fg = "#54546D" },
        WinSeparator = { bg = "#1F1F28", fg = "#54546D" },
        NeoTreeWinSeparator = { bg = "#1F1F28", fg = "#54546D" },

        LineNr = { bg = "#1F1F28" },
        FoldColumn = { bg = "#1F1F28" },
        SignColumn = { bg = "#1F1F28" },

        GitSigns = { bg = "#1F1F28" },
        GitSignsAdd = { bg = "#1F1F28", fg = "#76946a" },
        GitSignsDelete = { bg = "#1F1F28", fg = "#dca561" },
        GitSignsChange = { bg = "#1F1F28", fg = "#c34043" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
      VimIcon = "",
    },
    status = {
      separators = {
        none = { "", "" },
        rounded_right = { "", " " },
        rounded_left = { " ", "" },
        rounded_tight = { "", "" },
        left = { "", "" },
        right = { "  ", "" },
        center = { "  ", "  " },
        tab = { "", " " },
        breadcrumbs = "  ",
        path = "  ",
      },
    },
  },
}
