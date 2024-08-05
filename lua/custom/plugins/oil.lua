local close_in_float = {
  function()
    if require('config.utils').is_curr_buffer_float() then
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
}
