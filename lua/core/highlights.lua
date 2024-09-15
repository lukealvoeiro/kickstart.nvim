local M = {}

M.setup = function()
  -- Make TS context always work across colorschemes
  local utils = require 'core.utils'
  local line_nr = utils.get_hlgroup 'LineNr'
  local line_numbers = utils.get_hlgroup('LineNrAbove', line_nr)
  local ts_context_bottom = utils.shallow_copy(line_numbers)
  local ts_context = utils.shallow_copy(line_numbers)

  ts_context_bottom.underline = true
  ts_context_bottom.fg = nil
  ts_context_bottom.sp = line_numbers.fg ~= 'NONE' and line_numbers.fg or line_nr.fg
  vim.inspect(ts_context_bottom)

  vim.api.nvim_set_hl(0, 'TreesitterContext', ts_context)
  vim.api.nvim_set_hl(0, 'TreesitterContextBottom', ts_context_bottom)
end

return M
