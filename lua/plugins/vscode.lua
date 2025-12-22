-- don't do anything in non-vscode instances
if not vim.g.vscode then return {} end

vim.api.nvim_create_user_command("VSextensions", function() vim.fn.VSCodeNotify "workbench.view.extensions" end, {})

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

          ["<Leader>W"] = "<CMD>call VSCodeNotify('workbench.action.files.saveWithoutFormatting')<CR>",

          ["zg"] = "<CMD>call VSCodeNotify('cSpell.addWordToUserDictionary')<CR>",
          ["z="] = "<CMD>call VSCodeNotify('editor.action.quickFix')<CR>",
          ["]s"] = "<CMD>call VSCodeNotify('cSpell.goToNextSpellingIssue')<CR>",
          ["[s"] = "<CMD>call VSCodeNotify('cSpell.goToPreviousSpellingIssue')<CR>",

          ["<Leader>fT"] = "<CMD>call VSCodeNotify('workbench.view.extension.todo-tree-container')<CR>",
          ["<Leader>fd"] = "<CMD>call VSCodeNotify('workbench.view.extension.containersView')<CR>",

          ["<Leader>gG"] = "<CMD>call VSCodeNotify('workbench.view.extension.gitlens')<CR>",
          ["<Leader>gI"] = "<CMD>call VSCodeNotify('workbench.view.extension.gitlensInspect')<CR>",
          ["<Leader>gC"] = "<CMD>call VSCodeNotify('gitlens.views.fileHistory.focus')<CR>",
          ["<Leader>gC"] = "<CMD>call VSCodeNotify('gitlens.views.fileHistory.focus')<CR>",

          ["<Leader>th"] = "<CMD>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>",
          ["<Leader>tv"] = "<CMD>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>",
          ["<Leader>tf"] = "<CMD>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>",

          ["<Leader>bC"] = "<CMD>call VSCodeNotify('workbench.action.closeAllEditors')<CR>",

          ["<leader>ld"] = "<Cmd>call VSCodeNotify('editor.action.showHover')<CR>",

          ["<leader>W"] = "<CMD>call VSCodeNotify('workbench.action.files.saveWithoutFormatting')<CR>",

          ["<leader>du"] = "<CMD>call VSCodeNotify('workbench.view.debug)<CR>",

          ["<leader>Db"] = "<CMD>call VSCodeNotify('workbench.view.extension.github-cweijan-mysql')<CR>",

          ["<leader>Sf"] = "<CMD>call VSCodeNotify('workbench.action.openRecent')<CR>",
          ["<leader>SF"] = "<CMD>call VSCodeNotify('workbench.action.openRecent')<CR>",

          ["<leader>ag"] = "<CMD>call VSCodeNotify('antigravity.openAgent')<CR>", -- Open Agent
          ["<leader>ae"] = "<CMD>call VSCodeNotify('antigravity.prioritized.command.open')<CR>", -- Open AI quick edit
        },
        v = {
          ["<leader>ae"] = "<CMD>call VSCodeNotify('antigravity.prioritized.command.open')<CR>", -- Open AI quick edit
          ["<leader>ac"] = "<CMD>call VSCodeNotify('antigravity.prioritized.chat.open')<CR>", -- Give selected lines to Agent
        },
      },
    },
  },
}
