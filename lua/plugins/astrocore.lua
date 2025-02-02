-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        scrolloff = 7,
        tabstop = 2,
        softtabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        showtabline = 0,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapLeader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        -- L = {
        --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- H = {
        --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        ["<Tab>"] = {
          function() require("astrocore.buffer").nav(vim.v.count1) end,
          desc = "Next buffer",
        },
        ["<S-Tab>"] = {
          function() require("astrocore.buffer").nav(-vim.v.count1) end,
          desc = "Previous buffer",
        },
        ["<Leader>bn"] = {
          function() vim.cmd "Telescope buffers" end,
          desc = "Show Buffers list",
        },
        ["<Leader>gy"] = {
          function() vim.cmd "Flog" end,
          desc = "Shows the Git commits graph",
        },
        -- TODO List
        ["<Leader>T"] = {
          function() end,
          desc = " Todos list",
        },
        ["<Leader>Tt"] = {
          function() vim.cmd "TodoTelescope" end,
          desc = "Todos list in Telescope",
        },
        ["<Leader>Tl"] = {
          function() vim.cmd "TodoLocList" end,
          desc = "Todos list in Location list",
        },
        -- Open Alpha when the last buffesr closes
        ["<Leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = true }
            require("astrocore.buffer").close(0)
            if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
          end,
          desc = "Close buffer",
        },
        -- Code Companion
        ["<Leader>P"] = {
          function() end,
          desc = "Code Companion",
        },
        ["<leader>Pc"] = { function() vim.cmd "CodeCompanionChat" end, desc = "Open a new AI Chat" },
        ["<leader>Pa"] = { function() vim.cmd "CodeCompanionActions" end, desc = "AI Actions" },
        ["<Leader>Pp"] = {
          function()
            vim.api.nvim_command "normal aINSERT_HERE"
            vim.defer_fn(function() end, 300)
            vim.api.nvim_command "normal 10kV14j"
            vim.defer_fn(function() end, 300)
            vim.cmd "CodeCompanion Rewrite this code but complete the code by generating what should most probably come instead of INSERT_HERE. Write functional, clean and working code."
          end,
          desc = "Inline Completion",
        },
        -- LSP
        ["grr"] = {
          function() vim.cmd "Telescope lsp_references" end,
          desc = "Search references",
        },
        ["<leader>lR"] = {
          function() vim.cmd "Telescope lsp_references" end,
          desc = "Search references",
        },
      },
      v = {
        ["<Leader>P"] = {
          function() end,
          desc = "AI Assistant",
        },
        ["<leader>PA"] = {
          function() vim.cmd "CodeCompanionChat Add" end,
          desc = "Add selected chat to the current chat buffer",
        },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
