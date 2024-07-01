local mocha = require('catppuccin.palettes').get_palette 'mocha'

-- vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = 'red' })
vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true, sp = mocha.overlay1 })

return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      multiline_threshold = 1,
    },
  },
}
