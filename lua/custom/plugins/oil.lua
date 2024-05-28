return {
  {
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['<C-s>'] = false,
        ['<C-h>'] = false,
        ['<C-t>'] = false,
        ['<C-l>'] = false,
        ['q'] = 'actions.close',
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
