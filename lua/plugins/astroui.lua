-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

-- Theme sync config — read by polish.lua's GNOME sync; invisible to AstroNvim
vim.g.theme_sync = {
  -- Active colorscheme per mode.
  -- Same name → only vim.o.background is toggled (e.g. gruvbox, kanagawa).
  -- Different names → full colorscheme reload (e.g. rose-pine-main / rose-pine-dawn).
  dark = { colorscheme = "gruvbox" },
  light = { colorscheme = "gruvbox" },

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
      light = {},
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
