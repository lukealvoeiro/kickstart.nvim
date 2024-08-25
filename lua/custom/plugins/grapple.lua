return {
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
}
