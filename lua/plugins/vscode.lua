-- don't do anything in non-vscode instances
if not vim.g.vscode then return {} end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Tab>"] = "<CMD>call VSCodeNotify('workbench.action.nextEditor')<CR>",
          ["<S-Tab>"] = "<CMD>call VSCodeNotify('workbench.action.previousEditor')<CR>",

          ["<Leader>uw"] = "<CMD>call VSCodeNotify('editor.action.toggleWordWrap')<CR>",

          ["zg"] = "<CMD>call VSCodeNotify('cSpell.addWordToUserDictionary')<CR>",
          ["z="] = "<CMD>call VSCodeNotify('editor.action.quickFix')<CR>",
          ["]s"] = "<CMD>call VSCodeNotify('cSpell.goToNextSpellingIssue')<CR>",
          ["[s"] = "<CMD>call VSCodeNotify('cSpell.goToPreviousSpellingIssue')<CR>",
        },
      },
    },
  },
}
