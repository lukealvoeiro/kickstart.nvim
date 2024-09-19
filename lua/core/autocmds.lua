local function augroup(name)
  return vim.api.nvim_create_augroup('lalvoeiro_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ 'VimResized' }, {
  desc = 'Resize splits when the window is resized',
  group = augroup 'resize_splits',
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close certain filetypes with <q>',
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Go to the last location when opening a buffer',
  group = augroup 'last_loc',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Override all colorscheme highlights in a custom way',
  callback = function()
    require('core.highlights').setup()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Disable hover capability from Ruff',
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('User', {
  desc = 'Close certain windows when opening Telescope',
  pattern = 'TelescopeFindPre',
  group = augroup 'pre_open_telescope',
  callback = function(_)
    local win_number = vim.api.nvim_get_current_win()
    local is_float = vim.api.nvim_win_get_config(win_number).zindex
    if is_float then
      vim.api.nvim_win_close(win_number, false)
    end
  end,
})

vim.api.nvim_create_autocmd('ModeChanged', {
  desc = 'Modify the statusline colors when changing modes',
  callback = function()
    local utils = require 'core.utils'
    local color = utils.get_hlgroup 'lualine_b_normal'
    local mode_color = {
      n = utils.get_hlgroup 'lualine_b_normal',
      i = utils.get_hlgroup 'lualine_b_insert',
      v = utils.get_hlgroup 'lualine_b_visual',
      [' '] = utils.get_hlgroup 'lualine_b_normal',
      V = utils.get_hlgroup 'lualine_b_visual',
      c = utils.get_hlgroup 'lualine_b_command',
      R = utils.get_hlgroup 'lualine_b_replace',
    }
    local mode = vim.fn.mode()
    color = mode_color[mode]
    color.bold = true
    vim.api.nvim_set_hl(0, 'GrappleLineContentActive', color)
  end,
})

vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  desc = 'Paint the background of the terminal so there is no padding',
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})
vim.api.nvim_create_autocmd('UILeave', {
  callback = function()
    io.write '\027]111\027\\'
  end,
})

local function set_terminal_title()
  local cwd = vim.fn.getcwd()
  local last_dir = vim.fn.fnamemodify(cwd, ':t')
  vim.cmd('let &titlestring = "' .. last_dir .. '"')
end

-- Function to setup autocommands
local function setup_autocommands()
  local events = { 'BufEnter', 'BufWritePost', 'WinEnter', 'DirChanged' }

  for _, event in ipairs(events) do
    vim.api.nvim_create_autocmd(event, {
      callback = set_terminal_title,
    })
  end
end

-- Ensure the title is set when starting Neovim
vim.cmd [[let &title = 1]]
set_terminal_title()

-- Setup the autocommands
setup_autocommands()
