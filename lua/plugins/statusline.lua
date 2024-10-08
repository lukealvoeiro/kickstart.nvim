local mocha = require('catppuccin.palettes').get_palette 'mocha'

local second_tier_files = {}

local function is_second_tier_file(file_path)
  if require('core.utils').is_file_outside_cwd(file_path) then
    return true
  end

  if not require('core.utils').is_in_git_repo(file_path) then
    return false
  end

  if require('core.utils').is_file_git_gitignored(file_path) then
    return true
  end
  return false
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons' },
    config = function(_, opts)
      require('lualine').setup(opts)
      local utils = require 'core.utils'
      local lualine_bg_color = utils.get_hlgroup('lualine_b_normal').bg

      local grappleLineContentInactive = utils.get_hlgroup 'Comment'
      grappleLineContentInactive.bg = lualine_bg_color

      local grappleLineContentActive = utils.get_hlgroup 'lualine_b_normal'
      grappleLineContentActive.bg = lualine_bg_color
      grappleLineContentActive.bold = true

      vim.api.nvim_set_hl(0, 'GrappleLineContentActive', grappleLineContentActive)
      vim.api.nvim_set_hl(0, 'GrappleLineContentInactive', grappleLineContentInactive)
    end,
    opts = function()
      local utils = require 'core.utils'
      local lualine_bg_color = utils.get_hlgroup('lualine_b_normal').bg
      local copilot_colors = {
        [''] = utils.get_hlgroup 'Comment',
        ['Normal'] = utils.get_hlgroup 'Comment',
        ['Warning'] = utils.get_hlgroup 'DiagnosticError',
        ['InProgress'] = utils.get_hlgroup 'DiagnosticWarn',
      }
      local buffer_number_color = utils.get_hlgroup 'Operator'
      buffer_number_color.bg = lualine_bg_color

      return {
        options = {
          component_separators = { left = ' ', right = ' ' },
          section_separators = { left = ' ', right = ' ' },
          theme = 'ayu',
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
        },

        sections = {
          lualine_a = { { 'mode', icon = ' ' } },
          lualine_b = { { 'branch', icon = '' } },
          lualine_c = {
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            {
              'filename',
              padding = { left = 1, right = 0 },
              path = 1,
              color = function()
                local file_path = utils.get_current_buffer_path()
                -- local is_second_tier = false
                local is_second_tier = utils.get_cached_or_compute(second_tier_files, file_path, is_second_tier_file, file_path)
                return { fg = is_second_tier and mocha.overlay1 or mocha.text }
              end,
            },
            {
              function()
                -- TODO: this ain't working
                local buffer_count = require('core.utils').get_buffer_count()

                return '+' .. buffer_count - 1 .. ' '
              end,
              cond = function()
                return require('core.utils').get_buffer_count() > 1
              end,
              color = buffer_number_color,
              padding = { left = 1, right = 1 },
            },
            {
              'diff',
              padding = { left = 1, right = 1 },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_x = {
            {
              'diagnostics',
              padding = { left = 0, right = 1 },
            },
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
                local colors = copilot_colors[status.status] or copilot_colors['']
                colors.bg = lualine_bg_color
                return colors
              end,
            },
          },
          lualine_y = {
            {
              'progress',
            },
            {
              require('grapple-line').lualine,
              padding = { left = 0, right = 0 },
            },
          },
          lualine_z = {
            {
              function()
                return ' 󰛢 '
              end,
              padding = { left = 0, right = 0 },
            },
          },
        },
        extensions = { 'lazy', 'mason', 'neo-tree', 'trouble' },
      }
    end,
  },
  {
    'will-lynas/grapple-line.nvim',
    version = '1.x',
    dependencies = {
      'cbochs/grapple.nvim',
    },
    opts = {
      colors = {
        active = 'GrappleLineContentActive',
        inactive = 'GrappleLineContentInactive',
      },
    },
  },
}
