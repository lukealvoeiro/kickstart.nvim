return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'Mark file with Harpoon' })
      vim.keymap.set('n', '<leader>hh', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Toggle Harpoon menu' })
      for i = 1, 4 do
        vim.keymap.set('n', '<leader>h' .. i, function()
          harpoon:list():select(i)
        end, { desc = 'Harpoon mark ' .. i })
      end
    end,
  },
  {
    'letieu/harpoon-lualine',
    dependencies = {
      {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
      },
    },
  },
}
