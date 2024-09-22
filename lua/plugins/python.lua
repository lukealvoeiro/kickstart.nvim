return {
  {
    'alexpasmantier/pymple.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- optional (nicer ui)
      'stevearc/dressing.nvim',
      'stevearc/oil.nvim',
    },
    build = ':PympleBuild',
    config = function()
      require('pymple').setup()
    end,
  },
}
