return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local term = vim.env.TERM
    local image_instance = nil
    local alpha_win_id = nil
    local startup_complete = false

    -- Lunara – Inspired by the moon (Luna) and mystery, reflecting her enigmatic aura and elegance.
    -- Obsidian Grace – A name that embodies her dark attire and refined yet powerful presence.
    -- Seraphine Veil – Combining angelic beauty (Seraphine) with the veil-like mystery of her blindfold.
    local image_name = "Lunara" -- Should be a png file
    local image_y = 2
    local image_margin_right = 40
    local image_size = 14
    local top_text_margin = 12

    -- Calculate centered X position for the image
    local function calculate_center_x() return math.floor((vim.api.nvim_win_get_width(0) - image_margin_right) / 2) end

    -- Autocommand group for image management
    local alpha_augroup = vim.api.nvim_create_augroup("AlphaImage", { clear = true })

    -- Handle window focus changes
    vim.api.nvim_create_autocmd({ "WinLeave", "WinEnter" }, {
      group = alpha_augroup,
      callback = function()
        if alpha_win_id and image_instance then
          local win_id = vim.api.nvim_get_current_win()
          local win_config = vim.api.nvim_win_get_config(win_id)

          if win_id ~= alpha_win_id and win_config.relative ~= "" then
            image_instance:clear()
          else
            image_instance:render()
          end
        end
      end,
    })

    -- Handle window resizing only when in Alpha window
    vim.api.nvim_create_autocmd({ "WinResized", "WinLeave", "WinEnter", "WinScrolled", "BufWinEnter" }, {
      group = alpha_augroup,
      callback = function()
        if
          alpha_win_id
          and startup_complete
          and vim.api.nvim_get_current_win() == alpha_win_id
          and image_instance
          and image_instance.move
        then
          image_instance:move(calculate_center_x(), image_y)
        end
      end,
    })

    -- Clear resources when Alpha closes
    vim.api.nvim_create_autocmd("User", {
      group = alpha_augroup,
      pattern = "AlphaClosed",
      callback = function()
        if image_instance then
          image_instance:clear()
          image_instance = nil
        end
        alpha_win_id = nil
      end,
    })

    vim.schedule(function()
      if image_instance and image_instance.move then
        image_instance:move(calculate_center_x(), image_y)
        startup_complete = true
      end
    end)

    local function getLen(str, start_pos)
      local byte = string.byte(str, start_pos)
      if not byte then return nil end
      return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
    end

    local function colorize(header, header_color_map, colors)
      for letter, color in pairs(colors) do
        local color_name = "AlphaJemuelKwelKwelWalangTatay" .. letter
        vim.api.nvim_set_hl(0, color_name, color)
        colors[letter] = color_name
      end

      local colorized = {}

      for i, line in ipairs(header_color_map) do
        local colorized_line = {}
        local pos = 0

        for j = 1, #line do
          local start = pos
          pos = pos + getLen(header[i], start + 1) -- LINE 94

          local color_name = colors[line:sub(j, j)]
          if color_name then table.insert(colorized_line, { color_name, start, pos }) end
        end

        table.insert(colorized, colorized_line)
      end

      return colorized
    end

    -- ASCII art fallback
    local ascii_header = {
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
    }

    -- Image header management
    local image_header = {}
    for _ = 1, top_text_margin do
      table.insert(image_header, [[ ]])
    end
    image_header = vim.list_extend(image_header, {
      [[ ]],
      [[       Behind that blindfold lies an unwavering sense of duty and          ]],
      [[         a 󱙤 heart that, despite being artificial, feels deeply.           ]],
      [[ ]],
      [[ ]],
      [[              Create New File                              󱁐 n            ]],
      [[              Restore Session                              󱁐 sf           ]],
      [[              View History                                 󱁐 sF           ]],
    })
    -- 
    local colors = {
      ["w"] = { fg = "#ffffff", ctermfg = 33 },
      ["a"] = { fg = "#e0def4", ctermfg = 35 },
      ["b"] = { fg = "#31748f", ctermfg = 33 },
      ["r"] = { fg = "#eb6f92", ctermfg = 33 },
      ["h"] = { fg = "#ebbcba", ctermfg = 35 },
      ["g"] = { fg = "#f6c177", ctermfg = 33 },
      ["i"] = { fg = "#c4a7e7", ctermfg = 33 },
    }

    local color_map = {}
    for _ = 1, top_text_margin do
      table.insert(color_map, [[w]])
    end
    color_map = vim.list_extend(color_map, {
      [[w]],
      [[       aaaaaa aaaa aaaaaaaaa aaaa aa aaaaaaaaaa aaaaa aa aaaa aaa          ]],
      [[         a r rrrrr aaaaa aaaaaaa aaaaa aaaaaaaaaaa aaaaa aaaaaaa           ]],
      [[w]],
      [[w]],
      [[            i  hhhhhh hhh hhhh                              g g            ]],
      [[            i  hhhhhhh hhhhhhh                              g gg           ]],
      [[            i  hhhh hhhhhhh                                 g gg           ]],
    })

    local function draw_image()
      -- Only create image once when Alpha starts
      if not image_instance then
        local img_api = require "image"
        alpha_win_id = vim.api.nvim_get_current_win()

        image_instance = img_api.from_file(vim.fn.expand "$HOME/.config/nvim/assets/" .. image_name .. ".png", {
          x = calculate_center_x(),
          y = image_y,
          buffer = vim.api.nvim_get_current_buf(),
          window = alpha_win_id,
          height = image_size,
        })
        if image_instance then image_instance:render() end
      end
    end

    -- Determine header type
    if term == "xterm-kitty" or term == "xterm-ghostty" then
      opts.section.header.val = image_header
      opts.section.header.opts.hl = colorize(image_header, color_map, colors) -- LINE 199
    else
      opts.section.header.val = ascii_header
    end

    opts.section.buttons.val = {}
    opts.section.footer = {}

    -- Create image when Alpha opens
    vim.api.nvim_create_autocmd("User", {
      group = alpha_augroup,
      pattern = "AlphaReady",
      callback = function()
        if term ~= "xterm-kitty" and term ~= "xterm-ghostty" then return end
        draw_image()
      end,
    })

    return opts
  end,
}
