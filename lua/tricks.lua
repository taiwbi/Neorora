-- Function to set buffer options
local function set_buffer_options()
  vim.bo.tabstop = 2
  vim.bo.shiftwidth = 2
  vim.bo.expandtab = true
end

-- Autocommand group for setting buffer options
vim.api.nvim_create_augroup("SetBufferOptions", { clear = true })

-- Autocommand to run the function on file read and new file creation
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "SetBufferOptions",
  callback = set_buffer_options,
})
