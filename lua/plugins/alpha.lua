-- TODO: Make the image to move when windows or buffer is resized
-- TODO: Make the image to be visible on second Alpha and more
return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local img_api = require "image"
    local image = nil

    local function calculate_center_x()
      local win_width = vim.api.nvim_win_get_width(0)
      local image_width = 30
      return math.floor((win_width - image_width) / 2)
    end

    local function create_image_header()
      local term = vim.env.TERM
      if term ~= "xterm-kitty" and term ~= "xterm-ghostty" then
        return {
          [[                   2B - The Epitome of Android Grace                    ]],
          [[           A masterpiece of YoRHa engineering and elegance,             ]],
          [[        her silver hair dancing in the winds of a ruined world.         ]],
          [[     Behind that blindfold lies an unwavering sense of duty and         ]],
          [[        a heart that, despite being artificial, feels deeply.           ]],
          [[     Glory to Mankind - through her sword, through her sacrifice.       ]],
        }
      end

      -- Clear existing image if it exists
      if image then
        image:clear()
        image = nil
      end

      -- Create new image instance
      image = img_api.from_file("/home/mahdi/.config/nvim/assets/alpha-logo.png", {
        x = calculate_center_x(),
        y = 1,
        buffer = vim.api.nvim_get_current_buf(),
        window = vim.api.nvim_get_current_win(),
        height = 12,
      })

      -- Ensure image exists before rendering
      if image then
        image:render()
        -- Move image to center after rendering
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

    -- Add cleanup autocmd
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaClosed",
      callback = function()
        if image then
          image:clear()
          image = nil
        end
      end,
    })

    opts.section.header.val = create_image_header()
    opts.section.header.opts = {
      position = "center",
    }

    opts.section.buttons.val = {}
    return opts
  end,
}
