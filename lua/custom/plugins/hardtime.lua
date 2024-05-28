return {
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      disabled_filetypes = { 'qf', 'netrw', 'neo-tree*', 'lazy', 'mason', 'noice', 'oil', 'neo-tree' },
      disable_mouse = false,
      disabled_keys = {
        ['<Up>'] = { '', 'i' },
        ['<Down>'] = { '', 'i' },
        ['<Left>'] = { '' },
        ['<Right>'] = { '' },
      },
    },
  },
}
