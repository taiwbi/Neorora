-- customize alpha options

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
      pos = pos + getLen(header[i], start + 1)

      local color_name = colors[line:sub(j, j)]
      if color_name then table.insert(colorized_line, { color_name, start, pos }) end
    end

    table.insert(colorized, colorized_line)
  end

  return colorized
end

return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    -- customize the dashboard header
    local shape = {
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                  ⣠⣶⣾⣿⣿⣿⣿⣿⣦⣄                             ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀            ⣀⣠⣤⣶⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣇                          ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌                       ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀         ⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻                       ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⢸⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦                      ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⢸⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿                      ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⢸⠈⠁⠿⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇                     ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⣿⣿⠐⢗⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿                     ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⣿⣿⣿⣿⢗⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟                     ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⢰⣿⣿⣿⣿⣿⢗⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿                      ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠊⠬⢉⣹⣿⣿⣿⣿⣿⣿⣿⢗⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡                      ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⢙⣿⣿⣿⡻⡻⣿⢗⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏                       ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⡴⣿⣿⣿⣿⣿⡻⣿⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇                        ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⢫⣀⣀⠵⣿⣿⣿⣿⣶⣦⣿⣿⣿⣆⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸                         ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠞⠉⠉   ⠈⠙⠛⠛⠿⠿⣿⣿⣿⣿⣿⣿⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋                           ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀               ⠸⠟⡟   ⠀⠀⠀⠉⠀⠀⢀⣠⣰                           ]],
      [[       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                    ⠀⠀⠀⠀⣵⡀⢠⡿⠋                            ]],
      [[                 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿                              ]],
      [[                                                                          ]],
      [[                                                                          ]],
      [[                                                                          ]],
      [[  Why do it by hand in ten minutes when you can automate it in ten hours?]],
    }

    local color_map = {
      [[                                   YYYYYYYYYY                             ]],
      [[                             ZZZZYYYYYYYYYYYYYYY                          ]],
      [[                           YYYYYYYYYYYYYBBBYYYYYYYY                       ]],
      [[                          YYYYYYYYYYYYYYYYBBYYYYYYY                       ]],
      [[                         ZYYYYYYYYYYYYYYYYYYYYYYYYYY                      ]],
      [[                         ZYYYYYYYYYYYYYYYYYYYYYYYYYYY                     ]],
      [[                        ZYYZYYYYYYYYYYYYYYYYYYYYYYYYY                     ]],
      [[                        ZZYZYYYYYYYYYYYAAAAAAAAYYYYYY                     ]],
      [[                        ZZZZZA A AAAAAAAEEEEEEEAYYYYY                     ]],
      [[                        ZZZZZZZAEEEEEAAAAAAAAYYYYYYY                      ]],
      [[                    ZZZZZZZZZZZZEEEEEAAAAAAAAAAAYYYY                      ]],
      [[                   Z    ZZZZYYZZAAAAAAAAAAAAAAYYYYY                       ]],
      [[                         ZZZZZZYZAAAAAAAAAAAAAAYYY                        ]],
      [[                     ZZZZZZZZYYZZZZAAAAAAAAAAYYYY                         ]],
      [[                   ZZZ   ZZZZZZZZZZZZAAAAAAAYYY                           ]],
      [[                               ZZZZ   CCCAlCCCC                           ]],
      [[                                     lCCCCCCCC                            ]],
      [[                                      CCCCCC                              ]],
      [[                                                                          ]],
      [[                                                                          ]],
      [[                                                                          ]],
      [[BNCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC]],
    }

    local colors = {
      ["E"] = { fg = "#FDE9E0" }, -- Eyes
      ["A"] = { fg = "#FED5C6" }, -- Face
      ["Y"] = { fg = "#E88CBB" }, -- Hairs
      ["Z"] = { fg = "#8B5470" }, -- Hairs shadow
      ["B"] = { fg = "#486EEE" }, -- Flower
      ["C"] = { fg = "#474C69" }, -- Clothes
    }

    local colorized = colorize(shape, color_map, colors)

    opts.section.header.val = shape
    opts.section.header.opts = {
      hl = colorized,
      position = "center",
    }

    opts.section.buttons.val = {
      opts.button("<leader>n", "  New File", "<Cmd>enew<CR>"),
      opts.button(
        "<leader>SF",
        "  Search Session",
        function() require("resession").load(nil, { dir = "dirsession" }) end
      ),
      opts.button("<leader>Sl", "  Last Session", function() require("resession").load "Last Session" end),
    }
    return opts
  end,
}

-- opts.section.header.val
