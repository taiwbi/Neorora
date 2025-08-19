-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "eidolon",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
      kanagawa = {
        -- Wave: #1F1F28
        -- Dragon: #181616
        VertSplit = { bg = "#1F1F28", fg = "#181616" },
        WinSeparator = { bg = "#1F1F28", fg = "#181616" },
        NeoTreeWinSeparator = { bg = "#1F1F28", fg = "#181616" },
        GitSigns = { bg = "#1F1F28" },
        LineNr = { bg = "#1F1F28" },
        FoldColumn = { bg = "#1F1F28" },
        SignColumn = { bg = "#1F1F28" },
        GitSignsAdd = { bg = "#1F1F28", fg = "#76946a" },
        GitSignsDelete = { bg = "#1F1F28", fg = "#dca561" },
        GitSignsChange = { bg = "#1F1F28", fg = "#c34043" },
      },
      eidolon = {
        VertSplit = { bg = "#12121F", fg = "#12121F" },
        WinSeparator = { bg = "#12121F", fg = "#12121F" },
        NeoTreeWinSeparator = { bg = "#12121F", fg = "#12121F" },
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
    },
    status = {
      separators = {
        path = "  ",
        breadcrumbs = "  ",
      },
    },
  },
}
