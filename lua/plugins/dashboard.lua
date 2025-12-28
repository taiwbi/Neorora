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
        -- using https://github.com/taiwbi/snacks.nvim
        {
          pane = 1,
          section = "image",
          path = "~/.config/nvim/assets/hersmile.png",
          height = 15,
          width = 45,
          padding = 1,
        },
        { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { pane = 1, section = "startup" },
      },
    },
  },
}
