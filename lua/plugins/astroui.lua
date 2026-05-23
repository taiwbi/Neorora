-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

-- Theme sync config — read by polish.lua's GNOME sync; invisible to AstroNvim
vim.g.theme_sync = {
  -- Active colorscheme per mode.
  -- Same name → only vim.o.background is toggled (e.g. gruvbox, kanagawa).
  -- Different names → full colorscheme reload (e.g. rose-pine-main / rose-pine-dawn).
  dark = { colorscheme = "kanagawa" },
  light = { colorscheme = "kanagawa" },

  -- Per-theme, per-mode highlight overrides applied on top of AstroUI's own highlights.
  highlights = {
    gruvbox = {
      dark = {
        SignColumn = { bg = "#1D2021" },
        FoldColumn = { bg = "#1D2021" },
      },
      light = {
        SignColumn = { bg = "#F9F5D7" },
        FoldColumn = { bg = "#F9F5D7" },
      },
    },
    kanagawa = {
      dark = {
        -- Wave: #1F1F28
        -- Dragon: #181616
        NoicePopupBorder = { bg = "#181616", fg = "#54546D" },

        NoiceCmdlinePopupBorder = { bg = "#181616", fg = "#54546D" },
        NoiceCmdlinePopupBorderCmdline = { bg = "#181616", fg = "#54546D" },
        NoiceCmdLineIcon = { bg = "#181616", fg = "#54546D" },

        NoiceCmdlineIconSearch = { bg = "#181616", fg = "#54546D" },
        NoiceCmdlinePopupBorderSearch = { bg = "#181616", fg = "#54546D" },

        NoiceConfirmBorder = { bg = "#181616", fg = "#54546D" },

        NoicePopupmenuBorder = { bg = "#181616", fg = "#54546D" },
        NoiceSplitBorder = { bg = "#181616", fg = "#54546D" },

        FloatBorder = { bg = "#181616", fg = "#54546D" },

        VertSplit = { bg = "#181616", fg = "#54546D" },
        WinSeparator = { bg = "#181616", fg = "#54546D" },
        NeoTreeWinSeparator = { bg = "#181616", fg = "#54546D" },

        LineNr = { bg = "#181616" },
        FoldColumn = { bg = "#181616" },
        SignColumn = { bg = "#181616" },

        GitSigns = { bg = "#181616" },
        GitSignsAdd = { bg = "#181616", fg = "#76946a" },
        GitSignsDelete = { bg = "#181616", fg = "#c34043" },
        GitSignsChange = { bg = "#181616", fg = "#dca561" },
      },
      light = {
        NoicePopupBorder = { bg = "#F2ECBC", fg = "#D5CEAC" },

        NoiceCmdlinePopupBorder = { bg = "#F2ECBC", fg = "#D5CEAC" },
        NoiceCmdlinePopupBorderCmdline = { bg = "#F2ECBC", fg = "#D5CEAC" },
        NoiceCmdLineIcon = { bg = "#F2ECBC", fg = "#D5CEAC" },

        NoiceCmdlineIconSearch = { bg = "#F2ECBC", fg = "#D5CEAC" },
        NoiceCmdlinePopupBorderSearch = { bg = "#F2ECBC", fg = "#D5CEAC" },

        NoiceConfirmBorder = { bg = "#F2ECBC", fg = "#D5CEAC" },

        NoicePopupmenuBorder = { bg = "#F2ECBC", fg = "#D5CEAC" },
        NoiceSplitBorder = { bg = "#F2ECBC", fg = "#D5CEAC" },

        FloatBorder = { bg = "#F2ECBC", fg = "#D5CEAC" },

        VertSplit = { bg = "#F2ECBC", fg = "#D5CEAC" },
        WinSeparator = { bg = "#F2ECBC", fg = "#D5CEAC" },
        NeoTreeWinSeparator = { bg = "#F2ECBC", fg = "#D5CEAC" },

        LineNr = { bg = "#F2ECBC" },
        FoldColumn = { bg = "#F2ECBC" },
        SignColumn = { bg = "#F2ECBC" },

        GitSigns = { bg = "#F2ECBC" },
        GitSignsAdd = { bg = "#F2ECBC", fg = "#76946A" },
        GitSignsDelete = { bg = "#F2ECBC", fg = "#C34043" },
        GitSignsChange = { bg = "#F2ECBC", fg = "#DCA561" },
      },
    },
    -- Rose-pine uses different colorscheme names per mode, so key by each name:
    -- ["rose-pine-main"] = { dark = { ... } },
    -- ["rose-pine-dawn"] = { light = { ... } },
  },
}

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = vim.g.theme_sync.dark.colorscheme, -- default to dark theme even though will be overriden by polish.lua sync
    -- I'm not using astronvim's built-in highlights overrides. My method supports changing overrides per theme and per mode,
    -- while auto-reconfiguring highlights on colorscheme change and syncing with GNOME.
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
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
      colors = {
        file_info_bg = "#DA627D",
      },
      separators = {
        none = { "", "" },
        right_continue = { "", "" },
        left_start = { " ", "" },
        mode_left_only = { "", "" },
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
