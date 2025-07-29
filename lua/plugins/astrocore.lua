-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    -- see `:h vim.filetype.add` for usage
    filetypes = {
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
        ["*.blade.php"] = "blade",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        scrolloff = 3,
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        showtabline = 0,
        showcmdloc = "statusline",
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
      },
    },
    -- Mappings
    mappings = {
      -- first key is the mode
      n = {
        -- Open dashboard automatically when no more buffers
        ["<Leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = 1 }
            require("astrocore.buffer").close(0)
            if not bufs[2] then require("snacks").dashboard() end
          end,
          desc = "Close buffer",
        },

        ["<Leader>W"] = { function() vim.cmd "noautocmd w" end, desc = "Save without formatting" },

        -- second key is the lefthand side of the map
        ["<Leader>r"] = { desc = "Genral helpful keys" },
        ["<Leader>ra"] = { function() vim.fn.setreg("+", vim.fn.expand "%:p") end, desc = "Copy file's absolute path" },
        ["<Leader>rr"] = { function() vim.fn.setreg("+", vim.fn.expand "%:.") end, desc = "Copy file's relative path" },

        -- Navigate buffer tabs
        ["<Tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-Tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- Database Keys
        ["<leader>D"] = { function() vim.cmd "DBUIToggle" end, desc = " Database" },
        ["<leader>Db"] = { function() vim.cmd "DBUIToggle" end, desc = "Toggle UI" },
      },
    },
  },
}
