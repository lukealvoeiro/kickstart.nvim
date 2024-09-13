require 'core.options'
require 'core.keymaps'
require 'core.autocmds'

-- TODOs:
-- remember last dirs you were in
-- figure out dap for python
-- border for lazy and for mason
-- preview parameters for a function as you open the brakets
-- ghost text be kinda wierd (maybe it only shows up if your completion has same starting chars)
-- check out what else is available in noice
-- fix trouble highlight groups
-- add trouble as source of diagnostics
-- find a new remap for 's' as i don't use it enough
-- learn how to use 'g'
-- trouble diagnostics in lualine
-- resize buffers/splits using arrow keys
-- start using grapple or harpoon by seeing how much time you've spent in a buffer recently and if its over a certain amount and not in harpoon list, ask u to change
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

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update

-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
