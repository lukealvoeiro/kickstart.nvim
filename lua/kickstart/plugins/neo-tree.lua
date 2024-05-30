-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local show_diff = function(state)
  -- some variables. use any if you want
  local node = state.tree:get_node()
  -- local abs_path = node.path
  -- local rel_path = vim.fn.fnamemodify(abs_path, ":~:.")
  -- local file_name = node.name
  local is_file = node.type == 'file'
  if not is_file then
    vim.notify('Diff only for files', vim.log.levels.ERROR)
    return
  end
  -- open file
  local cc = require 'neo-tree.sources.common.commands'
  cc.open(state, function()
    -- do nothing for dirs
  end)

  vim.cmd [[Gvdiffsplit]]
end

local add_global = function(t)
  t.show_diff = show_diff
  return t
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
    { '-', "<C-w><C-l><cmd>lua require('oil').open_float()<CR>", { desc = 'Open oil' } },
  },
  opts = {
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
    close_if_last_window = true,
    window = {
      mappings = {
        ['\\'] = 'close_window',
        ['D'] = 'show_diff',
        ['s'] = false,
      },
    },
    filesystem = {
      use_libuv_file_watcher = true,
      commands = add_global {},
    },
    buffers = {
      commands = add_global {},
    },
    git_status = {
      commands = add_global {},
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      git_status = {
        symbols = {
          unstaged = '󰄱',
          staged = '󰱒',
        },
      },
    },
  },
}
