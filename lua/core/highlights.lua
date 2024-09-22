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
  vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', ts_context)
  vim.api.nvim_set_hl(0, 'TreesitterContextBottom', ts_context_bottom)

  local win_separator = utils.get_hlgroup 'WinSeparator'
  win_separator.bg = 'NONE'
  vim.api.nvim_set_hl(0, 'WinSeparator', win_separator)

  vim.api.nvim_set_hl(0, 'TelescopeResultsStaged', { link = 'Added' })
  vim.api.nvim_set_hl(0, 'TelescopeResultsUnstaged', { link = 'Removed' })
end

return M
