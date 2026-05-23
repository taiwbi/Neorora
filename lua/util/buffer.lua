local M = {}

function M.is_valid(bufnr)
  bufnr = bufnr or 0
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

local function buflist()
  if not vim.t.bufs then vim.t.bufs = vim.tbl_filter(M.is_valid, vim.api.nvim_list_bufs()) end
  return vim.t.bufs
end

function M.nav(n)
  local bufs = buflist()
  if #bufs < 2 then return end
  local current = vim.api.nvim_get_current_buf()
  for i, bufnr in ipairs(bufs) do
    if bufnr == current then
      local target = bufs[(i + n - 1) % #bufs + 1]
      if target ~= current then vim.api.nvim_set_current_buf(target) end
      return
    end
  end
  if bufs[1] then vim.api.nvim_set_current_buf(bufs[1]) end
end

function M.move(n)
  if n == 0 then return end
  local bufs = vim.t.bufs
  local current = vim.api.nvim_get_current_buf()
  for i, bufnr in ipairs(bufs) do
    if bufnr == current then
      for _ = 0, (n % #bufs) - 1 do
        local new_i = i == #bufs and 1 or i + 1
        if i == #bufs then
          table.remove(bufs, i)
          table.insert(bufs, new_i, bufnr)
        else
          bufs[i], bufs[new_i] = bufs[new_i], bufs[i]
        end
        i = new_i
      end
      break
    end
  end
  vim.t.bufs = bufs
  vim.cmd.redrawtabline()
end

local function snacks_or_fallback(bufnr, force)
  if package.loaded["snacks"] then
    require("snacks").bufdelete { buf = bufnr, force = force }
    return
  end
  vim.cmd(("silent! %s %d"):format(force and "bdelete!" or "confirm bdelete", bufnr))
end

function M.close(bufnr, force)
  bufnr = (bufnr == nil or bufnr == 0) and vim.api.nvim_get_current_buf() or bufnr
  snacks_or_fallback(bufnr, force)
end

function M.close_all(keep_current, force)
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.t.bufs or {}) do
    if not keep_current or bufnr ~= current then M.close(bufnr, force) end
  end
end

function M.close_left(force)
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.t.bufs or {}) do
    if bufnr == current then break end
    M.close(bufnr, force)
  end
end

function M.close_right(force)
  local current = vim.api.nvim_get_current_buf()
  local seen = false
  for _, bufnr in ipairs(vim.t.bufs or {}) do
    if seen then M.close(bufnr, force) end
    if bufnr == current then seen = true end
  end
end

local fnamemodify = vim.fn.fnamemodify
local function bufinfo(bufnr) return vim.fn.getbufinfo(bufnr)[1] end

M.comparators = {
  bufnr = function(a, b) return a < b end,
  extension = function(a, b) return fnamemodify(bufinfo(a).name, ":e") < fnamemodify(bufinfo(b).name, ":e") end,
  full_path = function(a, b) return fnamemodify(bufinfo(a).name, ":p") < fnamemodify(bufinfo(b).name, ":p") end,
  relative_path = function(a, b) return fnamemodify(bufinfo(a).name, ":.") < fnamemodify(bufinfo(b).name, ":.") end,
  modified = function(a, b) return bufinfo(a).lastused > bufinfo(b).lastused end,
}

function M.sort(method)
  local cmp = M.comparators[method]
  if not cmp or not vim.t.bufs then return end
  local bufs = vim.t.bufs
  table.sort(bufs, cmp)
  vim.t.bufs = bufs
  vim.cmd.redrawtabline()
end

return M
