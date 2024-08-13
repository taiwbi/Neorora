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
        guifont = "Cartograph CF,Vazir Code Hack:h11",
        -- line spacing
        linespace = 0,
        guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",
        winblend = 50,
        pumblend = 20,
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
        neovide_floating_blur_amount_x = 16,
        neovide_floating_blur_amount_y = 16,
        neovide_floating_shadow = false,
        neovide_floating_z_height = 10,
        neovide_light_angle_degrees = 45,
        neovide_light_radius = 5,
        neovide_scroll_animation_length = 0.1,
        neovide_cursor_animation_length = 0.1,
        neovide_cursor_trail_size = 0.2,
        neovide_hide_mouse_when_typing = true,
        neovide_cursor_smooth_blink = true,
        neovide_cursor_vfx_mode = "pixiedust",
        neovide_cursor_vfx_particle_lifetime = 3,
        neovide_cursor_vfx_particle_density = 20,
      },
    },
  },
}
