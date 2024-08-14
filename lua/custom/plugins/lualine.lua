local mocha = require('catppuccin.palettes').get_palette 'mocha'

local second_tier_files = {}

local function is_second_tier_file()
  if require('config.utils').is_file_outside_cwd(file_path) then
    return true
  end

  if not require('config.utils').is_in_git_repo(file_path) then
    return false
  end
  --
  -- print 'why here'
  --
  -- if require('config.utils').is_file_git_gitignored(file_path) then
  --   return true
  -- end
  return false
end
-- or if the file is outside of the cwd and not a symlink

local theme = function()
  local colors = {
    darkgray = mocha.crust,
    gray = mocha.overlay1,
    innerbg = nil,
    outerbg = nil,
    normal = mocha.blue,
    insert = mocha.green,
    visual = mocha.peach,
    replace = mocha.red,
    command = mocha.peach,
    cyan = mocha.sky,
  }
  return {
    inactive = {
      a = { fg = colors.gray, bg = colors.outerbg },
      b = { fg = colors.cyan, bg = colors.outerbg },
      c = { fg = colors.text, bg = colors.innerbg },
    },
    visual = {
      a = { bg = colors.outerbg, fg = colors.visual, gui = 'bold' },
      b = { fg = colors.cyan, bg = colors.outerbg },
      c = { fg = colors.text, bg = colors.innerbg },
    },
    replace = {
      a = { bg = colors.outerbg, fg = colors.replace, gui = 'bold' },
      b = { fg = colors.cyan, bg = colors.outerbg },
      c = { fg = colors.text, bg = colors.innerbg },
    },
    normal = {
      a = { bg = colors.outerbg, fg = colors.normal, gui = 'bold' },
      b = { fg = colors.cyan, bg = colors.outerbg },
      c = { fg = colors.text, bg = colors.innerbg },
    },
    insert = {
      a = { bg = colors.outerbg, fg = colors.insert, gui = 'bold' },
      b = { fg = colors.cyan, bg = colors.outerbg },
      c = { fg = colors.text, bg = colors.innerbg },
    },
    command = {
      a = { bg = colors.outerbg, fg = colors.command, gui = 'bold' },
      b = { fg = colors.cyan, bg = colors.outerbg },
      c = { fg = colors.text, bg = colors.innerbg },
    },
  }
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons' },
    opts = function()
      local utils = require 'config.utils'
      local icon_bg_color = require('config.utils').get_hlgroup('LineNr').fg
      local copilot_colors = {
        [''] = utils.get_hlgroup 'Comment',
        ['Normal'] = utils.get_hlgroup 'Comment',
        ['Warning'] = utils.get_hlgroup 'DiagnosticError',
        ['InProgress'] = utils.get_hlgroup 'DiagnosticWarn',
      }

      return {
        options = {
          component_separators = { left = ' ', right = ' ' },
          section_separators = { left = ' ', right = ' ' },
          theme = theme(),
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
                local is_second_tier = utils.get_cached_or_compute(second_tier_files, file_path, is_second_tier_file, file_path)
                return { fg = is_second_tier and mocha.overlay1 or mocha.text }
              end,
            },
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
              'diff',
              padding = { left = 2, right = 0 },
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
                return copilot_colors[status.status] or copilot_colors['']
              end,
            },
          },
          lualine_y = {
            {
              'progress',
            },
          },
          lualine_z = {
            {
              require('grapple-line').status,
              icon = { ' 󰛢 ', align = 'right', color = { bg = icon_bg_color, fg = '#000000', gui = 'bold' } },
              padding = { left = 1, right = 0 },
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
        active = 'LineNr',
        inactive = 'LineNrAbove',
      },
    },
  },
}
