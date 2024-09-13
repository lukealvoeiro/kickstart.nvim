return {
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
}
