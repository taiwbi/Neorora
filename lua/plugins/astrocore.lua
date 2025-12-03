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
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
        [".*%.blade%.php"] = "php",
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
        cursorline = false,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
      },
    },
    -- Mappings
    mappings = {
      -- first key is the mode
      n = {
        ["<Leader>W"] = { function() vim.cmd "noautocmd w" end, desc = "Save without formatting" },

        -- ["<Leader>e"] = { function() Snacks.picker.explorer() end, desc = "Toggle Explorer" },

        -- second key is the lefthand side of the map
        ["<Leader>r"] = { desc = "Genral helpful keys" },
        ["<Leader>ra"] = { function() vim.fn.setreg("+", vim.fn.expand "%:p") end, desc = "Copy file's absolute path" },
        ["<Leader>rr"] = { function() vim.fn.setreg("+", vim.fn.expand "%:.") end, desc = "Copy file's relative path" },

        -- Navigate buffer tabs
        ["<Tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-Tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- Database Keys
        ["<leader>D"] = { desc = " Database" },
        ["<leader>Db"] = { function() vim.cmd "DBUIToggle" end, desc = "Toggle UI" },

        -- VS Tasks Keys (using <leader>j for "jobs/tasks")
        ["<leader>j"] = { desc = " Tasks" },
        ["<leader>ja"] = { function() require("vstask").tasks() end, desc = "Tasks" },
        ["<leader>ji"] = { function() require("vstask").inputs() end, desc = "Task Inputs" },
        ["<leader>jj"] = { function() require("vstask").jobs() end, desc = "Running Jobs" },
        ["<leader>jl"] = { function() require("vstask").launches() end, desc = "Launch Configs" },
        ["<leader>jr"] = { function() require("vstask").command() end, desc = "Run Command" },

        -- Neovide scale factor controls
        ["<C-0>"] = {
          function()
            if vim.g.neovide_scale_factor then vim.g.neovide_scale_factor = 1 end
          end,
          desc = "Reset Neovide scale factor",
        },
        ["<C-+>"] = {
          function()
            if vim.g.neovide_scale_factor then
              vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1, 2.0)
            end
          end,
          desc = "Increase Neovide scale factor",
        },
        ["<C-_>"] = {
          function()
            if vim.g.neovide_scale_factor then
              vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1, 0.5)
            end
          end,
          desc = "Decrease Neovide scale factor",
        },
      },
      v = {
        ["<leader>p"] = { '"_dP', desc = "Paste without overwriting clipboard" },
        ["<leader>x"] = { '"_x', desc = "Delete without overwriting clipboard" },
      },
    },
  },
}
