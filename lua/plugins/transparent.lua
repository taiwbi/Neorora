-- Customize Transparent plugins

return {
  -- Configuration in /lua/plugins/astrocore.lua file
  "xiyaowong/transparent.nvim",
  name = "transparent",
  event = "User AstroFile",
  config = function()
    vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, {
      "CmdLine",
      "CmdLineBorder",
      "CmdLineHistory",
      "CmdLineMessage",
      "CmdLinePrompt",
      "CmpBorder",
      "CmpDoc",
      "CmpDocumentation",
      "CmpDocumentationBorder",
      "CmpPmenu",
      "ColorColumn",
      "DapUINormalNC",
      "DapUIPlayPauseNC",
      "DapUIRestartNC",
      "DapUIStepBackNC",
      "DapUIStepIntoNC",
      "DapUIStepOutNC",
      "DapUIStepOverNC",
      "DapUIStopNC",
      "DapUIUnavailableNC",
      "FloatBorder",
      "FloatTitle",
      "FoldColumn",
      "FzfLuaBorder",
      "FzfLuaFzfSeparator",
      "FzfLuaNormal",
      "FzfLuaPreviewTitle",
      "FzfLuaTitle",
      "HeirlineCommand",
      "HeirlineInactive",
      "HeirlineInsert",
      "HeirlineNormal",
      "HeirlineReplace",
      "HeirlineTerminal",
      "HeirlineVisual",
      "LspInfoBorder",
      "NeoTree",
      "NeoTreeFloatNormal",
      "NeoTreeFloatTitle",
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "NeoTreeTabActive",
      "NeoTreeTabInactive",
      "NeoTreeTabSeparatorActive",
      "NeoTreeTabSeparatorInactive",
      "NeoTreeVertSplit",
      "NeoTreeWinSeparator",
      "NoiceAttr1132",
      "NoiceAttr1133",
      "NoiceAttr227",
      "NoiceAttr237",
      "NoiceAttr306",
      "NoiceAttr311",
      "NoiceAttr418",
      "NoiceAttr565",
      "NoiceAttr572",
      "NoiceAttr573",
      "NoiceAttr574",
      "NoiceAttr575",
      "NoiceAttr603",
      "NoiceAttr605",
      "NoiceAttr865",
      "NoiceCmdline",
      "NoicePopup",
      "NormalFloat",
      "NormalSB",
      "NotifyBackground",
      "NotifyDEBUGBody",
      "NotifyDEBUGBorder",
      "NotifyERRORBody",
      "NotifyERRORBorder",
      "NotifyINFOBody",
      "NotifyINFOBorder",
      "NotifyTRACEBody",
      "NotifyTRACEBorder",
      "NotifyWARNBody",
      "NotifyWARNBorder",
      "Pmenu",
      "SignColumnSB",
      "StatusLine",
      "StatusLineNC",
      "Stl00aaae_16161e__",
      "Stl05C3FF_0a0b12__",
      "Stl0a0b12_0a0b12__",
      "Stl15161e_15161e__",
      "Stl16161e_16161e__",
      "Stl188092_d0d5e3__",
      "Stl1a1b26_15161e__",
      "Stl2ac3de_16161e__",
      "Stl2c323c_2c323c__",
      "Stl2cccff_0a0b12__",
      "Stl2e7de9_d0d5e3__",
      "Stl345e00_e1e2e4__",
      "Stl3b4261_15161e__",
      "Stl3b4261_16161e__",
      "Stl3b4261_1a1b26__",
      "Stl3b4261_1a1b26_bolditalic_",
      "Stl3b4261_2c323c__",
      "Stl3f8cea_e1e2e4__",
      "Stl4197a4_d0d5e3_bold_",
      "Stl42ad17_e1e2e4_bold_",
      "Stl449dab_16161e_bold_",
      "Stl4a4a4a_d0d5e3__",
      "Stl506d9c_d0d5e3_bold_",
      "Stl50FA7B_0a0b12__",
      "Stl51a0cf_0a0b12__",
      "Stl51a0cf_16161e__",
      "Stl51a0cf_1a1b26__",
      "Stl51a0cf_1a1b26_bolditalic_",
      "Stl565f89_15161e__",
      "Stl565f89_2c323c__",
      "Stl587539_d0d5e3__",
      "Stl6172b0_d0d5e3__",
      "Stl6183bb_16161e_bold_",
      "Stl6d8086_16161e__",
      "Stl7300b8_e1e2e4__",
      "Stl737474_e1e2e4__",
      "Stl7aa2f7_16161e__",
      "Stl848cb5_b4b5b9__",
      "Stl8b9297_2c323c__",
      "Stl8b9297_e1e2e4__",
      "Stl8be9fd_0a0b12__",
      "Stl8c6c3e_d0d5e3__",
      "Stl914c54_16161e_bold_",
      "Stl9854f1_d0d5e3__",
      "Stl9854f1_d0d5e3_bold_",
      "Stl98c379_0a0b12_bold_",
      "Stl9A86FD_0a0b12__",
      "Stl9b9ea4_07080d__",
      "Stl9e007c_e1e2e4_bold_",
      "Stl9ece6a_16161e__",
      "StlNONE_2c323c__",
      "Stl_15161e__",
      "Stl_2c323c__",
      "Stl_b4b5b9__",
      "Stl_e1e2e4__",
      "Stla074c4_0a0b12__",
      "Stla074c4_1a1b26__",
      "Stla074c4_1a1b26_bolditalic_",
      "Stla074c4_e1e2e4__",
      "Stla8aecb_b4b5b9__",
      "Stla8aecb_d0d5e3__",
      "Stla9b1d6_16161e__",
      "Stlaeb3b6_2c323c__",
      "Stlaeb3b6_e1e2e4__",
      "Stlb4b5b9_b4b5b9__",
      "Stlbb9af7_16161e__",
      "Stlbb9af7_16161e_bold_",
      "Stlc0caf5_1a1b26__",
      "Stlc0caf5_1a1b26_bolditalic_",
      "Stlc47981_d0d5e3_bold_",
      "Stlcbcb41_1a1b26_bolditalic_",
      "Stld0d5e3_d0d5e3__",
      "Stldb4b4b_1a1b26__",
      "Stldb4b4b_1a1b26_bolditalic_",
      "Stldddddd_16161e__",
      "Stldddddd_1a1b26_bolditalic_",
      "Stle0af68_16161e__",
      "Stle1e2e4_e1e2e4__",
      "Stle1e2e7_b4b5b9__",
      "Stle69400_e1e2e4__",
      "Stle72f1f_e1e2e4_bold_",
      "Stle9e9f4_0a0b12__",
      "Stlec5f67_0a0b12_bold_",
      "Stlf05340_1a1b26__",
      "Stlf05340_1a1b26_bolditalic_",
      "Stlf0740a_e1e2e4_bold_",
      "Stlf2fa95_0a0b12__",
      "Stlf54d27_0a0b12__",
      "Stlf54d27_16161e__",
      "Stlf54d27_1a1b26__",
      "Stlf54d27_1a1b26_bolditalic_",
      "Stlf7f8f8_e1e2e4__",
      "Stlff5555_0a0b12__",
      "Stlff6bcb_0a0b12_bold_",
      "Stlff9640_0a0b12_bold_",
      "TabLine",
      "TabLineFill",
      "TabLineSel",
      "TelescopeBorder",
      "TelescopeNormal",
      "TelescopePromptBorder",
      "TelescopePromptNormal",
      "TelescopePromptPrefix",
      "TelescopePromptTitle",
      "TodoSignFIx",
      "TodoSignHACK",
      "TodoSignNOTE",
      "TodoSignPERF",
      "TodoSignTEST",
      "TodoSignTODO",
      "TodoSignWARN",
      "WhichKeyNormal",
      "WinBar",
      "WinBarNC",
      "colorizer_mb_16161e",
      "colorizer_mb_1a1b26",
      "colorizer_mb_b4b5b9",
      "debugPC",
    })
  end,
}