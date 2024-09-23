require 'core.options'
require 'core.keymaps'
require 'core.autocmds'

-- TODOs:
-- make pasting faster
-- better session name management
-- aliases for nvim to n
-- border for lazy and for mason
-- preview parameters for a function as you open the brakets
-- check out what else is available in noice
-- fix trouble highlight groups
-- add trouble as source of diagnostics
-- trouble diagnostics in lualine
-- thing like lazy vim does that asks you whether you wanna close unsaved buffer before closing it with q
-- figure out ``` usage

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  { import = 'plugins' },
}
