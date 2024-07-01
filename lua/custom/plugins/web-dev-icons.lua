local mocha = require('catppuccin.palettes').get_palette 'mocha'

function SetRandomLineNrColor()
  math.randomseed(os.time())

  local colors = {
    mocha.lavender,
    mocha.maroon,
    mocha.green,
    mocha.flamingo,
    mocha.mauve,
    mocha.peach,
    mocha.blue,
    mocha.sky,
  }

  local index = math.random(#colors)
  vim.api.nvim_set_hl(0, 'LineNr', { fg = colors[index], bold = true })
end

-- Ensure the random color is selected each time Neovim starts
vim.cmd 'autocmd VimEnter * lua SetRandomLineNrColor()'
-- Setting highlights for lines above and below
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#6e738d', bold = false })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#6e738d', bold = false })

return {
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    config = function()
      require('tiny-devicons-auto-colors').setup()
    end,
  },
}
