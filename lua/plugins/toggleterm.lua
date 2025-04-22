return {
  "akinsho/toggleterm.nvim",
  opts = function(_, opts)
    opts.shell = function()
      -- Get the current working directory
      local cwd = vim.fn.getcwd()
      -- Extract the base name (directory name) from the path
      local dir_name = vim.fn.fnamemodify(cwd, ":t")

      -- Sanitize the directory name for tmux session naming
      dir_name = string.gsub(dir_name, "[.:]", "_")

      -- Handle cases where the directory name might be empty (e.g., root '/')
      if dir_name == "" then dir_name = "ROOT" end

      -- Construct the desired session name
      local session_name = "Astro_" .. dir_name

      -- Construct the tmux command
      local tmux_cmd = string.format("tmux new-session -A -s %s", session_name)

      -- Return the calculated command string
      return tmux_cmd
    end

    return opts
  end,
}
