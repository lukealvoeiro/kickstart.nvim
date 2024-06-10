require 'config.undo'
require 'config.commands'

-- Ctrl+z to suspend nvim. Remap Ctrl+z in the terminal to fg
vim.keymap.set('n', '<C-z', ':suspend', { desc = 'Suspend nvim' })

-- Paste and Delete without yanking
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })

-- SETTINGS FOR NEOVIDE
if vim.g.neovide then
  vim.keymap.set('n', '<D-s>', ':w<CR>', { desc = 'Save file' }) -- Save
  vim.keymap.set('v', '<D-c>', '"+y', { desc = 'Copy to clipboard' }) -- Copy
  vim.keymap.set('n', '<D-v>', '"+P', { desc = 'Paste' }) -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P', { desc = 'Paste' }) -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+', { desc = 'Paste' }) -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli', { desc = 'Paste' }) -- Paste insert mode
end
-- END OF NEOVIDE CONFIG

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

vim.keymap.set('v', '<D-c>', '"+y') -- Copy
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move Lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- Join line while keeping the cursor in the same position
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join line' })

-- Keep cursor centred while scrolling up and down
vim.keymap.set('n', '<C-d>', '12<C-d>zz', { desc = 'Scroll up' })
vim.keymap.set('n', '<C-u>', '12<C-u>zz', { desc = 'Scroll down' })
--
-- Delete previous word in insert mode
vim.keymap.set('i', '<A-BS>', '<Esc>cvb', { desc = 'Delete previous word in insert mode' })

-- Copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank selection to system clipboard', silent = true })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard', silent = true })

-- Oil
vim.keymap.set('n', '-', "<cmd>lua require('oil').open_float()<CR>", { desc = 'Oil' })

-- buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Close everything
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- Git Status on left
vim.keymap.set('n', '<leader>gs', '<cmd>Neotree toggle git_status<CR>', { desc = '[S]tatus' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Toggle format on save
vim.keymap.set('n', '<leader>tf', '<cmd>FormatToggle<CR>', { desc = 'Toggle format on save' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Remap backspace to be ^. This is useful for switching between files and going to the first char on the line
vim.keymap.set('n', '<BS>', '^', { desc = 'Go to first char on line' })

-- Remap arrow keys for tmux integration
vim.keymap.set('n', '<left>', '<cmd> TmuxNavigateLeft<CR>')
vim.keymap.set('n', '<right>', '<cmd> TmuxNavigateRight<CR>')
vim.keymap.set('n', '<down>', '<cmd> TmuxNavigateDown<CR>')
vim.keymap.set('n', '<up>', '<cmd> TmuxNavigateUp<CR>')

-- Insert newline without entering insert mode
vim.keymap.set('n', '<S-CR>', '@="m`o<C-V><Esc>``"<CR>', { desc = '[Enter] a new line below' }) -- <CR> is "Enter"
vim.keymap.set('n', '<M-p>', 'o<Esc>p', { desc = 'Paste on new line below' })
vim.keymap.set('n', '<M-P>', 'o<Esc>P', { desc = 'Paste on new line above' })

vim.api.nvim_set_keymap('n', '<leader>ee', [[:lua YankDiagnosticError()<CR>]], { noremap = true, silent = true, desc = 'Copy error' })
