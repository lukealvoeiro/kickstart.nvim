return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
        hover = { enabled = false },
        signature = { enabled = false },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      cmdline = {
        enabled = true,
        menu = 'popup',
      },
      popupmenu = {
        enabled = true,
      },
      views = {
        -- Clean cmdline_popup + palette
        cmdline_popup = {
          position = {
            row = 10,
            col = '50%',
          },
          border = {
            style = 'rounded',
          },
        },
        cmdline_popupmenu = {
          relative = 'editor',
          position = {
            row = 13,
            col = '50%',
          },
          size = {
            width = 60,
            height = 'auto',
            max_height = 15,
          },
          border = {
            style = 'rounded',
          },
          win_options = {
            winhighlight = { NormalFloat = 'NormalFloat', FloatBorder = 'NoiceCmdlinePopupBorder' },
          },
        },
        hover = {
          border = {
            style = 'rounded',
          },
        },
        confirm = {
          border = {
            style = 'rounded',
          },
        },
        popup = {
          border = {
            style = 'rounded',
          },
        },
      },
    },
    -- you can enable a preset for easier configuration
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },
}
