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
        {
          pane = 1,
          section = "image",
          path = "~/.config/nvim/assets/vigil.png",
          height = 9,
          padding = 1,
        },
        { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { pane = 2, title = "\n\n\n\n\n" },
        { pane = 2, section = "keys", gap = 0, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, section = "startup" },
      },
    },
  },
}
