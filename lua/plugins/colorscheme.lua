vim.g.transparency_enabled = false

return {
  {
    'Shatur/neovim-ayu',
    config = function()
      local colors = require 'ayu.colors'
      colors.generate(false)
      require('ayu').setup {
        terminal = true,
        mirage = true,
        overrides = function()
          return require('core.utils').table_merge({
            LineNr = { fg = colors.special, bold = true },
            LineNrAbove = { fg = colors.comment },
            LineNrBelow = { fg = colors.comment },
            -- NormalFloat = { bg = '#353944' },
          }, vim.g.transparency_enabled and {
            Normal = { bg = 'None' },
            ColorColumn = { bg = 'None' },
            SignColumn = { bg = 'None' },
            Folded = { bg = 'None' },
            FoldColumn = { bg = 'None' },
            CursorLine = { bg = 'None' },
            CursorColumn = { bg = 'None' },
            WhichKeyFloat = { bg = 'None' },
            VertSplit = { bg = 'None' },
            NormalFloat = { bg = 'None' },
          } or {})
        end,
      }
    end,
  },
  {
    'catppuccin/nvim',
    lazy = true,
    init = function()
      vim.cmd.colorscheme 'ayu'
    end,
    name = 'catppuccin',
    opts = {
      transparent_background = false,
      no_italic = true,
      no_bold = false,
      integrations = {
        harpoon = true,
        fidget = true,
        cmp = true,
        leap = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        treesitter_context = true,
      },
      highlight_overrides = {
        all = function(colors)
          return {
            DiagnosticVirtualTextError = { bg = colors.none },
            DiagnosticVirtualTextWarn = { bg = colors.none },
            DiagnosticVirtualTextHint = { bg = colors.none },
            DiagnosticVirtualTextInfo = { bg = colors.none },
          }
        end,
      },
      custom_highlights = function(colors)
        math.randomseed(os.time())

        local line_colors = {
          colors.lavender,
          colors.maroon,
          colors.flamingo,
          colors.mauve,
          colors.peach,
        }

        local index = math.random(#line_colors)
        return {
          TreesitterContextBottom = { sp = colors.overlay1, style = { 'underline' } },
          TreesitterContextLineNumber = { fg = colors.overlay1 },
          LineNr = { fg = line_colors[index], bold = true },
          LineNrAbove = { fg = colors.overlay1, bold = false },
          LineNrBelow = { fg = colors.overlay1, bold = false },
        }
      end,
      color_overrides = {
        mocha = {
          -- I don't think these colours are pastel enough by default!
          peach = '#fcc6a7',
          green = '#d2fac5',
        },
      },
    },
  },
}
