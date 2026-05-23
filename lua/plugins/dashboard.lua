return {
  "folke/snacks.nvim",
  opts = {
    image = { doc = { enabled = true } },
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Recent Projects", action = "<leader>Sf" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = "", key = "s", desc = "Last Session", action = "<Leader>Sl" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "M", desc = "Mason", action = ":Mason" },
          { icon = "󰆸 ", key = "U", desc = "Update Nvim", action = ":AstroUpdate" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
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
        -- using https://github.com/taiwbi/snacks.nvim
        {
          pane = 1,
          section = "terminal",
          cmd = "chafa ~/.config/nvim/assets/virtuous.png --format symbols --symbols vhalf --size 45x15 --stretch; sleep .1",
          height = 15,
          padding = 2,
        },
        { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { pane = 1, section = "startup" },
        { pane = 2, padding = 2 },
        { pane = 2, section = "header", padding = 2 },
        { pane = 2, section = "keys" },
      },
    },
  },
}
