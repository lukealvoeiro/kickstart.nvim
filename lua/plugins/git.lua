return {
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>GG', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'tpope/vim-fugitive',
  },
  {
    'tpope/vim-fugitive',
  },
  {
    -- opens a file in github
    'almo7aya/openingh.nvim',
  },
}
