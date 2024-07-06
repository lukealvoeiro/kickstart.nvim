return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Highlight the word under the cursor
      require('mini.cursorword').setup()

      -- Inline diffs
      require('mini.diff').setup {
        view = {
          style = 'sign',
          signs = {
            add = '',
            change = '',
            delete = '',
          },
          priority = 1000,
        },
      }

      vim.keymap.set('n', '+', ':lua MiniDiff.toggle_overlay()<CR>', { desc = 'Diff' })
    end,
  },
}
