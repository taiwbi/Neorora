-- Improved Lua Neovim configuration for Alpha plugin
return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local term = vim.env.TERM

    -- Helper to calculate center position for the image
    local function calculate_center_x()
      local win_width = vim.api.nvim_win_get_width(0)
      local image_width = 35 -- Adjust based on your image width
      return math.floor((win_width - image_width) / 2)
    end

    -- Create ASCII art header for unsupported terminals
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
        [[     Glory to Mankind - through her sword, through her sacrifice.       ]],
      }
    end

    -- Create image header for Kitty and compatible terminals
    local function create_image_header()
      local img_api = require "image"
      local image

      -- Clear any existing image
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaClosed",
        callback = function()
          if image then image:clear() end
        end,
      })

      -- Load and render the image
      image = img_api.from_file("/home/mahdi/.config/nvim/assets/alpha-logo.png", {
        x = calculate_center_x(),
        y = 1,
        buffer = vim.api.nvim_get_current_buf(),
        window = vim.api.nvim_get_current_win(),
        height = 12,
      })

      if image then
        image:render()
        vim.schedule(function()
          if image and image.move then image:move(calculate_center_x(), 1) end
        end)
      end

      return {
        [[ ]],
        [[ ]],
        [[ ]],
        [[ ]],
        [[ ]],
        [[ ]],
        [[ ]],
        [[ ]],
        [[ ]],
        [[ ]],
        [[ ]],
        [[ Behind that blindfold lies a heart that, ]],
        [[ despite being artificial, feels deeply. ]],
      }
    end

    -- Main header creation logic
    local function create_header()
      if term == "xterm-kitty" or term == "xterm-ghostty" then
        return create_image_header()
      else
        return create_ascii_header()
      end
    end

    -- Configure header and buttons
    opts.section.header.val = create_header() or {}
    opts.section.header.opts = {
      position = "center",
    }
    opts.section.buttons.val = {}

    return opts
  end,
}
