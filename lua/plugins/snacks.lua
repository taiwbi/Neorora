local buffer = require "util.buffer"

return {
  "folke/snacks.nvim",
  url = "https://github.com/taiwbi/snacks.nvim.git",
  lazy = false,
  priority = 1000,
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    image = { doc = { enabled = true } },
    picker = { ui_select = true },
    explorer = { enabled = true },
    indent = {
      indent = { char = "▏" },
      scope = { char = "▏" },
      filter = function(bufnr)
        return buffer.is_valid(bufnr) and vim.g.snacks_indent ~= false and vim.b[bufnr].snacks_indent ~= false
      end,
      animate = { enabled = false },
    },
    scope = { filter = function(bufnr) return buffer.is_valid(bufnr) end },
    zen = {
      toggles = { dim = false, diagnostics = false, inlay_hints = false },
      win = {
        width = function() return math.min(120, math.floor(vim.o.columns * 0.75)) end,
        height = 0.9,
        backdrop = { transparent = false, win = { wo = { winhighlight = "Normal:Normal" } } },
        wo = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          foldcolumn = "0",
          winbar = "",
          list = false,
          showbreak = "NONE",
        },
      },
    },
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Recent Projects", action = "<leader>Sf" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = "", key = "s", desc = "Last Session", action = "<Leader>Sl" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "M", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
 ▄▄    ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄
█  █  █ █       █       █  █ █  █   █  █▄█  █
█   █▄█ █    ▄▄▄█   ▄   █  █▄█  █   █       █
█       █   █▄▄▄█  █ █  █       █   █       █
█  ▄    █    ▄▄▄█  █▄█  █       █   █       █
█ █ █   █   █▄▄▄█       ██     ██   █ ██▄██ █
█▄█  █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄█▄█   █▄█

One day, you will :q for the last time. Make
today's commits count.
        ]],
      },
      sections = {
        {
          pane = 1,
          section = "terminal",
          cmd = "chafa ~/.config/nvim/assets/virtuous.png --format symbols --symbols vhalf --size 45x15 --stretch; sleep .1",
          height = 15,
          padding = 2,
        },
        { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { pane = 1, section = "startup" },
        { pane = 2, padding = 2 },
        { pane = 2, section = "header", padding = 2 },
        { pane = 2, section = "keys" },
      },
    },
  },
}
