return {
  'zbirenbaum/copilot.lua',
  config = function()
    require('copilot').setup {
      suggestion = { enabled = true, auto_trigger = true, debounce = 50, keymap = {
        accept = '<C-CR>',
      } },
      panel = { enabled = false },
    }
  end,
}
