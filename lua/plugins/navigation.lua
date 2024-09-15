local close_in_float = {
  function()
    if require('core.utils').is_curr_buffer_float() then
      require('oil.actions').close.callback()
    end
  end,
  desc = 'Close in float',
  mode = 'n',
}

return {
  {
    'stevearc/oil.nvim',
    dependencies = {},
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['<C-s>'] = false,
        ['<C-h>'] = false,
        ['<C-t>'] = false,
        ['<C-l>'] = false,
        ['q'] = close_in_float,
        ['<Esc>'] = close_in_float,
        ['yp'] = {
          desc = 'Copy filepath to system clipboard',
          callback = function()
            require('oil.actions').copy_entry_path.callback()
            vim.fn.setreg('+', vim.fn.getreg(vim.v.register))
          end,
        },
        ['yrp'] = {
          desc = 'Copy relative filepath to system clipboard',
          callback = function()
            local entry = require('oil').get_cursor_entry()
            local dir = require('oil').get_current_dir()
            if not entry or not dir then
              return
            end
            local relpath = vim.fn.fnamemodify(dir, ':.')
            vim.fn.setreg('+', relpath .. entry.name)
          end,
        },
      },
      float = {
        -- Padding around the floating window
        padding = 5,
        max_width = 78,
        max_height = 40,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
    },
  },
  {
    'ggandor/leap.nvim',
    enabled = true,
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap Forward to' },
      { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap Backward to' },
      { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from Windows' },
    },
    config = function(_, opts)
      local leap = require 'leap'
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
    end,
  },
  {
    'cbochs/grapple.nvim',
    dependencies = {},
    opts = {
      scope = 'git_branch', -- also try out "git_branch"
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = 'Grapple',
    keys = {
      { '<leader>ha', '<cmd>Grapple toggle<cr>', desc = 'Tag a file' },
      { '<leader>hh', '<cmd>Grapple toggle_tags<cr>', desc = 'Toggle tags menu' },

      { '<leader>h1', '<cmd>Grapple select index=1<cr>', desc = 'Select first tag' },
      { '<leader>h2', '<cmd>Grapple select index=2<cr>', desc = 'Select second tag' },
      { '<leader>h3', '<cmd>Grapple select index=3<cr>', desc = 'Select third tag' },
      { '<leader>h4', '<cmd>Grapple select index=4<cr>', desc = 'Select fourth tag' },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },
}
