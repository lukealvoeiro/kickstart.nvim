return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
    keys = {
      { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Open Neogit' },
    },
    opts = {
      signs = {
        item = {
          '',
          '',
        },
        section = {

          '',
          '',
        },
      },
    },
  },
}
