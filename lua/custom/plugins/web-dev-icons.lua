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
    'dgox16/devicon-colorscheme.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      colors = {
        blue = mocha.blue,
        cyan = mocha.teal,
        green = mocha.green,
        magenta = mocha.pink,
        orange = mocha.maroon,
        purple = mocha.mauve,
        red = mocha.red,
        white = mocha.subtext0,
        yellow = mocha.yellow,
        bright_blue = mocha.blue,
        bright_cyan = mocha.teal,
        bright_green = mocha.green,
        bright_magenta = mocha.pink,
        bright_orange = mocha.maroon,
        bright_purple = mocha.mauve,
        bright_red = mocha.red,
        bright_yellow = mocha.yellow,
      },
    },
  },
}
