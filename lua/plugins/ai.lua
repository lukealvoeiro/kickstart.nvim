return {
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false, auto_trigger = true, debounce = 50, keymap = {
          accept = '<S-CR>',
        } },
        panel = { enabled = false },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = {
      'zbirenbaum/copilot.lua',
    },
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
