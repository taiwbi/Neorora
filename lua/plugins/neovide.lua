if not vim.g.neovide then
  return {} -- do nothing if not in a Neovide session
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- configure vim.opt options
        -- configure font
        guifont = "Lotion,Vazir Code Hack:h13.2",
        -- line spacing
        linespace = -2,
        guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",
      },
      g = { -- configure vim.g variables
        -- configure scaling
        neovide_scale_factor = 1.0,
        -- configure padding
        neovide_padding_top = 0,
        neovide_padding_bottom = 0,
        neovide_padding_right = 0,
        neovide_padding_left = 0,
        neovide_transparency = 0.8,
        neovide_floating_blur_amount_x = 12.0,
        neovide_floating_blur_amount_y = 12.0,
        neovide_scroll_animation_length = 0.5,
        neovide_cursor_animation_length = 0.5,
        neovide_cursor_trail_size = 0,
        neovide_hide_mouse_when_typing = false,
        neovide_cursor_smooth_blink = true,
      },
    },
  },
}
