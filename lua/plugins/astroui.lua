-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "kanagawa",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
        NoiceCmdlinePopupBorder = { bg = "NONE" },
        NoiceCmdlinePopup = { bg = "NONE" },
        -- NoiceCmdlineIcon
      },
      astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
      horizon = {
        WinBar = { bg = "#1D1F27" },
        WinBarNC = { bg = "#1D1F27" },
        NeoTreeTabInactive = { bg = "#1D1F27" },
        NeoTreeTabSeparatorInactive = { bg = "#1D1F27", fg = "#1D1F27" },
        NeoTreeTabActive = { bg = "#21252E" },
        NeoTreeTabSeparatorActive = { bg = "#21252E", fg = "#21252E" },
      },
      kanagawa = {
        WinBar = { bg = "#181616" },
        WinBarNC = { bg = "#181616" },
        StatusLine = { bg = "#181616" },
        LineNr = { bg = "#181616" },
        FoldColumn = { bg = "#181616" },
        SignColumn = { bg = "#181616" },
        NormalFloat = { bg = "#181616" },
        FloatBorder = { bg = "#181616" },
        FloatShadow = { bg = "#181616" },
        NoiceCmdlineIcon = { bg = "NONE", fg = "#658594" },
        GitSignsAdd = { bg = "NONE", fg = "#76946A" },
        GitSignsChange = { bg = "NONE", fg = "#DCA561" },
        GitSignsDelete = { bg = "NONE", fg = "#C34043" },
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
  },
}
