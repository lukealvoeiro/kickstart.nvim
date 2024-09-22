return { -- Fuzzy Finder (files, lsp, etc)
  'lukealvoeiro/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim', version = '^1.0.0' },
  },
  config = function()
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    -- See `:help telescope` and `:help telescope.setup()`
    local lga_actions = require 'telescope-live-grep-args.actions'

    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          additional_args = {},
          mappings = { -- extend mappings
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
              ['<tab>'] = lga_actions.quote_prompt { postfix = ' -t' },
              ['<C-f>'] = lga_actions.quote_prompt { postfix = ' --fixed-strings' },
            },
          },
        },
      },
    }
    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'live_grep_args')

    local builtin = require 'telescope.builtin'
    local all_file_search = function()
      return builtin.find_files { hidden = true, no_ignore = true, prompt_title = 'Find All Files' }
    end

    local git_status_search = function()
      return builtin.git_status {
        col_width = 1,
        git_icons = {
          added = 'A',
          changed = 'M',
          deleted = 'D',
          copied = 'M',
          renamed = 'R',
          unmerged = 'U',
          untracked = 'A',
        },
      }
    end

    local find_projects = function(directory)
      directory = '~/Development' or directory
      require('telescope.builtin').find_files {
        prompt_title = 'Find Directories',
        cwd = directory,
        find_command = { 'sh', '-c', 'find ' .. directory .. ' -maxdepth 1 -type d -print' },
        entry_maker = function(entry)
          return {
            value = entry,
            display = function()
              -- TODO: use a MiniIconsDirectory highlight group for the directory icon
              -- TODO: only display the last part of the path
              local icon = require('mini.icons').get('default', 'Directory')
              return icon .. ' ' .. entry
            end,
            ordinal = entry,
            path = entry,
          }
        end,
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local selection = require('telescope.actions.state').get_selected_entry()
            require('telescope.actions').close(prompt_bufnr)
            local selected_path = selection.path or selection[1]
            vim.api.nvim_set_current_dir(selected_path)
            require('oil').open_float(selected_path)
          end)
          return true
        end,
      }
    end

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>saf', all_file_search, { desc = '[S]earch [A]ll [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('telescope').extensions.live_grep_args.live_grep_args, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sp', find_projects, { desc = '[S]earch [P]rojects' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sv', git_status_search, { desc = '[S]earch [V]CS' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        -- winblend = 10,
        previewer = true,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
