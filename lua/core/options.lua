vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- For Neovide
vim.o.guifont = 'ZedMono Nerd Font:h17'
vim.g.neovide_remember_window_size = true
vim.g.neovide_transparency = 0.90
vim.g.neovide_window_blurred = true
vim.opt.linespace = -1
vim.g.neovide_input_macos_option_key_is_meta = 'both'

vim.opt.fillchars:append { diff = '╱' } -- makes diffs look better

vim.opt.termguicolors = true
vim.opt.pumblend = 15
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = string.rep(' ', 3) -- Make it so that long lines wrap smartly
vim.opt.linebreak = true
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- For better auto-session performance
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

vim.opt.guicursor = ''
vim.opt.swapfile = false
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true
--
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
vim.opt.statuscolumn = [[%!v:lua.require('core.ui').statuscolumn()]]

vim.opt.foldlevel = 99
vim.opt.smoothscroll = true
vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
vim.opt.foldmethod = 'expr'
vim.opt.foldtext = ''

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Maximum num of entries in a popup
vim.opt.pumheight = 10

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.opt.wildmode = 'longest:full,full'
