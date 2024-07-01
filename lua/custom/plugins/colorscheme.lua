return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      hide_inactive_statusline = true,
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
      on_highlights = function(highlights, colors)
        highlights.DiagnosticVirtualTextError = { bg = colors.none, fg = '#db4b4b' }
        highlights.DiagnosticVirtualTextWarn = { bg = colors.none, fg = '#e0af68' }
        highlights.DiagnosticVirtualTextHint = { bg = colors.none, fg = '#1abc9c' }
        highlights.DiagnosticVirtualTextInfo = { bg = colors.none, fg = '#0db9d7' }
      end,
    },
  },
  {
    'catppuccin/nvim',
    lazy = true,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
    name = 'catppuccin',
    opts = {
      transparent_background = true,
      no_italic = true,
      no_bold = false,
      integrations = {
        harpoon = true,
        fidget = true,
        cmp = true,
        flash = true,
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
        return {
          TreesitterContextBottom = { sp = colors.overlay1, style = { 'underline' } },
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
