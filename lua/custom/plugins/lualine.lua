return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = function()
    local utils = require 'config.utils'
    local copilot_colors = {
      [''] = utils.get_hlgroup 'Comment',
      ['Normal'] = utils.get_hlgroup 'Comment',
      ['Warning'] = utils.get_hlgroup 'DiagnosticError',
      ['InProgress'] = utils.get_hlgroup 'DiagnosticWarn',
    }
    local diagnostic_symbols = require 'config.constants'

    return {
      options = {
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = ' ', right = ' ' },
        theme = 'catppuccin',
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
      },
      sections = {
        lualine_a = { { 'mode' } },
        lualine_b = { { 'branch', icon = '' } },
        lualine_c = {
          {
            'diagnostics',
            symbols = diagnostic_symbols,
          },
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          { 'filename', padding = { left = 1, right = 0 } },
          {
            function()
              local buffer_count = require('core.utils').get_buffer_count()

              return '+' .. buffer_count - 1 .. ' '
            end,
            cond = function()
              return require('config.utils').get_buffer_count() > 1
            end,
            color = utils.get_hlgroup('Operator', nil),
            padding = { left = 0, right = 1 },
          },
          {
            'harpoon2',
            icon = '󰀱 ',
            indicators = { '1', '2', '3', '4' },
            active_indicators = { '[1]', '[2]', '[3]', '[4]' },
            _separator = ' ',
            no_harpoon = 'Harpoon not loaded',
          },
        },
        lualine_x = {
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = utils.get_hlgroup 'String',
          },
          {
            function()
              local icon = ' '
              local status = require('copilot.api').status.data
              return icon .. (status.message or '')
            end,
            cond = function()
              local ok, clients = pcall(vim.lsp.get_clients, { name = 'copilot', bufnr = 0 })
              return ok and #clients > 0
            end,
            color = function()
              if not package.loaded['copilot'] then
                return
              end
              local status = require('copilot.api').status.data
              return copilot_colors[status.status] or copilot_colors['']
            end,
          },
          { 'diff' },
        },
        lualine_y = {
          {
            'progress',
          },
          {
            'location',
            color = utils.get_hlgroup 'Boolean',
          },
        },
        lualine_z = {
          {
            'datetime',
            style = '  %X',
          },
        },
      },

      extensions = { 'lazy', 'mason', 'neo-tree', 'trouble' },
    }
  end,
}
