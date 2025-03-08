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
    colorscheme = "kanagawa-wave",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
        NoiceCmdlinePopupBorder = { bg = "NONE" },
        NoiceCmdlinePopup = { bg = "NONE" },
        WinBar = { bg = "NONE" },
        WinBarNC = { bg = "NONE" },
        StatusLine = { bg = "NONE" },
        LineNr = { bg = "NONE" },
        FoldColumn = { bg = "NONE" },
        SignColumn = { bg = "NONE" },
        NormalFloat = { bg = "NONE" },
        FloatBorder = { bg = "NONE" },
        FloatShadow = { bg = "NONE" },
        LspReferenceRead = { bg = "NONE" },
        LspReferenceText = { bg = "NONE" },
        LspReferenceWrite = { bg = "NONE" },
        -- NoiceCmdlineIcon
      },
      astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
      horizon = {
        NeoTreeTabInactive = { bg = "#1D1F27" },
        NeoTreeTabSeparatorInactive = { bg = "#1D1F27", fg = "#1D1F27" },
        NeoTreeTabActive = { bg = "#21252E" },
        NeoTreeTabSeparatorActive = { bg = "#21252E", fg = "#21252E" },
        IblScope = { bg = "NONE", fg = "#5B6670" },
        RenderMarkdownCode = { bg = "#2A2A33" },
        RenderMarkdownCodeInline = { bg = "#2F2F39" },
        RenderMarkdownH1Bg = { bg = "#E95379", fg = "#1D1F27" },
        RenderMarkdownH2Bg = { bg = "#21BFC2", fg = "#1D1F27" },
        RenderMarkdownH3Bg = { bg = "#27D796", fg = "#1D1F27" },
        RenderMarkdownH4Bg = { bg = "#A8C236", fg = "#1D1F27" },
        RenderMarkdownH5Bg = { bg = "#658594" },
        RenderMarkdownH6Bg = { bg = "#44535A" },
      },
      kanagawa = {
        NoiceCmdlineIcon = { bg = "NONE", fg = "#658594" },
        GitSignsAdd = { bg = "NONE", fg = "#76946A" },
        GitSignsChange = { bg = "NONE", fg = "#DCA561" },
        GitSignsDelete = { bg = "NONE", fg = "#C34043" },
      },
      poimandres = {
        WinBar = { bg = "#1B1E28" },
        WinBarNC = { bg = "#1B1E28" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      VimIcon = "",
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
        left = { "", "" }, -- separator for the left side of the statusline
        right = { "", "" }, -- separator for the right side of the statusline
      },
    },
  },
}
