return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local term = vim.env.TERM
    local image_instance = nil
    local startup_complete = false

    -- Calculate centered X position for the image
    local function calculate_center_x()
      return math.floor((vim.api.nvim_win_get_width(0) - 35) / 2) -- Adjust 35 to your image width
    end

    -- Autocommand group for image management
    local alpha_augroup = vim.api.nvim_create_augroup("AlphaImage", { clear = true })

    -- Clear image when Alpha closes
    vim.api.nvim_create_autocmd("User", {
      group = alpha_augroup,
      pattern = "AlphaClosed",
      callback = function()
        if image_instance then
          image_instance:clear()
          image_instance = nil
        end
      end,
    })

    -- Handle window resizing
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
      group = alpha_augroup,
      callback = function()
        if image_instance and image_instance.move and startup_complete then
          image_instance:move(calculate_center_x(), 1)
        end
      end,
    })

    -- Handles image position after startup
    vim.schedule(function()
      if image_instance and image_instance.move then
        image_instance:move(calculate_center_x(), 1)
        startup_complete = true
      end
    end)

    -- ASCII art fallback
    local function create_ascii_header()
      return {
        [[    ⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡔⠁⠀⠀⠀⠀⠰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠈⠀⠀⠀⠀⠘⢿⣿⣿⣧⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀      ⠀]],
        [[⠀⠀⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⢠⠎⠀⠀⠀⠀⢀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣆⠀⠀⠀⠙⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[⠀   ⠀⠀⠀⠀⠀    ⠀⠀⠀⠰⠈⡎⠀⠐⠀⡀⡰⢁⠐⠱⡀⠠⠀⠀⠁⠄⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⡖⡀⠀⠀⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⡼⢀⠐⡀⠄⢀⠆⠀⠀⣿⠐⠀⠁⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣷⠐⠀⠀⠀⣇⠀⠀⠀⠀⠀⠀⠀       ]],
        [[     ⠀⠀⠀   ⠀⠀⠀⠀⠀⠠⠗⡀⠆⠀⠀⢸⠀⠀⣼⣾⡀⠀⠂⢂⠀⠀⠀⠀⠀⡐⠢⢀⠀⡀⠈⠠⡀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡌⠀⠀⠀⠘⡀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠀⢱⠀⠀⠀⢸⠀⠀⣿⣿⣇⠀⠀⠉⢤⡀⠀⠀⠀⠀⠀⠀⣿⡔⡠⢀⠀⠀⡀⠀⠐⠆⠀⠀⢸⡜⠅⠀⠀⠀⠀⢧⠀⠀⠀⠀⠀⠀⠀      ]],
        [[       ⠀⠀⠀⠀⠀⠀⠀⠀⢀⡇⠈⢤⠀⠀⠀⢸⠀⠐⣿⣿⣿⡀⡀⠀⠀⢊⢄⠀⠀⠀⠀⠀⠹⣷⡌⠠⠉⠢⠀⠄⢠⢸⡀⠀⠀⣿⣈⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀      ]],
        [[⠀⠀⠀       ⠀⠀⠀⠀⠀⢸⡅⠀⢸⠀⠀⠀⠀⡆⡥⣿⣿⣿⣷⡐⢄⠀⠀⠐⡑⠄⠀⠀⠀⠀⢿⣿⡄⠀⠀⠀⠙⠆⢸⠘⢄⠀⢹⠂⠀⠀⠀⠀⠀⣇⠀⠀⠀⠀⠀⠀      ]],
        [[⠀⠀⠀⠀⠀       ⠀⠀⠀⣾⡇⠀⢼⠀⠀⠀⠀⣥⣿⣽⣿⣿⣿⣷⣄⠑⡢⠀⡀⠢⢄⠀⠀⣆⠈⢿⣿⣆⠀⢂⠀⠈⢺⠆⡹⡀⢰⠀⠀⠀⠀⠀⡁⢸⠀⠀⠀⠀⠀⠀      ]],
        [[⠀⠀⠀⠀⠀       ⠀⠀⠀⣽⢧⠀⢺⢨⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣦⡘⢦⡀⠉⠐⠑⠀⢹⣧⡈⢿⣿⣆⠀⠆⠀⠨⠀⠀⢱⢀⠀⠀⠀⠀⠀⠆⠘⠢⠀⠀⠀⠀⠀      ]],
        [[⠀       ⠀⠀⠀⠀⠀⠀⠀⣏⢸⡆⢹⠀⡇⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣹⢆⠀⠀⠀⠀⣿⣿⡎⣿⣿⡆⡶⠀⠀⠀⠀⠀⢾⠀⠀⠀⠀⠀⣾⢰⠁⠀⠀⠀⠀⠀      ]],
        [[⠀       ⠀⠀⠀⠀⠀⠀⠀⣼⠀⡇⢸⢧⠈⢆⠀⡄⠘⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠉⠑⠠⢀⠀⠡⡉⠉⠪⠏⡛⣤⠀⡋⠀⠀⠀⢘⠀⠀⠀⠀⠀⡟⠀⠀⠀⠀⠀⠀⠀      ]],
        [[⠀       ⠀⠀⠀⠀⠀⠀⠀⢹⡂⢹⡆⣿⡂⠈⠣⡐⣄⠸⣿⣿⣿⡿⠛⠉⢠⠆⠀⠑⠀⠀⠀⠁⠐⠢⠀⠀⠈⡇⢸⢰⠁⢠⢂⠀⠘⠀⠀⠀⠀⡰⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠈⡇⢸⠘⡎⠜⠄⠀⠙⢮⡳⣼⢟⡁⠀⠀⠀⠈⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⠀⡎⣐⠂⢠⠀⡌⠀⠂⢀⡠⠁⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[⠀       ⠀⠀⠀⠀⠀⠀⠀⠀⢷⠈⣇⠈⢂⠑⠄⠀⠘⡻⡓⠢⠉⠀⠀⠀⠀⣀⠄⣀⡀⠀⠀⠀⠀⠀⠀⠀⣰⠃⡼⡐⣜⢢⠩⡐⠀⠀⡠⠕⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⢿⣆⠈⡂⠈⢢⡀⠱⡈⠢⡀⠀⠀⠀⠲⢮⣭⣧⠬⠐⠀⠀⠀⠀⡠⢈⠇⠸⠕⣐⡀⠀⡓⠁⠂⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡾⡌⠲⣔⠄⠀⠰⣦⡳⡀⠈⠢⣄⠀⠀⠀⠀⠀⠀⠀⠂⢀⣼⠊⢠⠐⠢⠎⢐⢀⠇⡜⣡⠂⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[       ⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠘⢗⠀⠈⠳⣄⠀⠐⢌⠓⣄⠀⢀⣽⣦⣀⠀⠀⣀⡠⢖⠙⠈⠀⠁⡐⠁⣠⠀⣈⡬⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[       ⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠈⠊⠤⠀⠈⠑⠤⡈⢿⣼⣗⣌⢿⣿⣶⣭⣦⣥⣘⣊⣠⣤⣶⠟⣀⣶⣧⡾⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣻⣏⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣾⣏⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[       ⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢄⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⡽⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ]],
        [[]],
        [[                   2B - The Epitome of Android Grace                    ]],
        [[           A masterpiece of YoRHa engineering and elegance,             ]],
        [[        her silver hair dancing in the winds of a ruined world.         ]],
        [[     Behind that blindfold lies an unwavering sense of duty and         ]],
        [[        a heart that, despite being artificial, feels deeply.           ]],
        [[]],
        [[     Glory to Mankind - through her sword, through her sacrifice.       ]],
      }
    end

    -- Image header for supported terminals
    local function create_image_header()
      local img_api = require "image"
      image_instance = img_api.from_file(vim.fn.expand "$HOME/.config/nvim/assets/2B.png", {
        x = calculate_center_x(),
        y = 1,
        buffer = vim.api.nvim_get_current_buf(),
        window = vim.api.nvim_get_current_win(),
        height = 14,
      })

      if image_instance then image_instance:render() end

      -- Create header space for image and text
      local header_lines = {}
      for _ = 1, 10 do
        table.insert(header_lines, [[ ]])
      end

      -- Add centered text below image
      return vim.list_extend(header_lines, {
        [[]],
        [[     Behind that blindfold lies an unwavering sense of duty and         ]],
        [[        a heart that, despite being artificial, feels deeply.           ]],
        [[]],
        [[     Glory to Mankind - through her sword, through her sacrifice.       ]],
      })
    end

    -- Determine header type
    local function create_header()
      return (term == "xterm-kitty" or term == "xterm-ghostty") and create_image_header() or create_ascii_header()
      -- return create_image_header()
    end

    -- Configure Alpha
    -- opts.section.header = {
    --   type = "text",
    --   val = create_header(),
    --   opts = {
    --     position = "center",
    --     hl = "AlphaHeader",
    --   },
    -- }
    opts.section.header.val = create_header()

    opts.section.buttons.val = {
      opts.button("LDR n", "  New File"),
      opts.button("LDR sf", "󰁯  Load a Session"),
      opts.button("LDR sF", "  Load a DirSession"),
    }

    return opts
  end,
}
