return {
  "folke/snacks.nvim",
  opts = {
    image = { doc = { enabled = true } },
    dashboard = {
      preset = {
        keys = {
          { key = "n", action = "<Leader>n", icon = "", desc = "New File  " },
          { key = "o", action = "<Leader>fo", icon = "󰈙", desc = "Recents  " },
          { key = "s", action = "<Leader>Sl", icon = "", desc = "Last Session  " },
        },
      },
      sections = {
        -- Waiting for https://github.com/folke/snacks.nvim/pull/2544
        -- {
        --   pane = 1,
        --   section = "image",
        --   path = "~/.config/nvim/assets/bunnyatta.png",
        --   height = 10,
        --   padding = 2,
        -- },
        {
          pane = 1,
          section = "terminal",
          cmd = "chafa ~/.config/nvim/assets/bunnyatta.png --format symbols --symbols vhalf --size 60x12 --stretch; sleep .1",
          height = 13,
          padding = 1,
        },
        { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { pane = 1, section = "startup" },
      },
    },
  },
}
