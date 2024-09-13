local M = {}

function M.open_git_status(dir)
  local current_buf_name = vim.api.nvim_buf_get_name(0)
  vim.cmd 'TSContextDisable'

  vim.fn.chdir(dir)
  vim.cmd 'Git'

  local fug_win = vim.api.nvim_get_current_win()
  local fug_buf = vim.api.nvim_win_get_buf(fug_win)
  local ui = vim.api.nvim_list_uis()[1]
  local width_pad = math.floor((ui.width / 3.14))
  local win_width = (ui.width - width_pad)
  local height_pad = math.floor((ui.height / 3.14))
  local win_height = (ui.height - height_pad)
  local win_opts = {
    border = 'rounded',
    col = ((ui.width - win_width) / 2),
    height = win_height,
    relative = 'editor',
    row = ((ui.height - win_height) / 2),
    style = 'minimal',
    width = win_width,
  }

  -- Immediately set the window configuration
  vim.api.nvim_win_set_config(fug_win, win_opts)
  vim.api.nvim_win_set_option(fug_win, 'number', true)
  vim.api.nvim_win_set_option(fug_win, 'relativenumber', true)
  -- Set up keymaps and autocmds
  vim.keymap.set('n', 'q', function()
    vim.api.nvim_win_close(fug_win, true)
    vim.cmd 'TSContextEnable'
  end, {
    buffer = fug_buf,
    desc = 'Close fugitive window with just q',
  })

  vim.keymap.set('n', '<Esc>', function()
    vim.api.nvim_win_close(fug_win, true)
    vim.cmd 'TSContextEnable'
  end, {
    buffer = fug_buf,
    desc = 'Close fugitive window with just <Esc>',
  })

  local fug_floatwin = vim.api.nvim_create_augroup('fugitiveFloatwin', { clear = true })
  vim.api.nvim_create_autocmd('BufLeave', {
    buffer = fug_buf,
    callback = function()
      vim.cmd 'TSContextEnable'
      vim.api.nvim_win_close(fug_win, true)
      vim.api.nvim_del_augroup_by_id(fug_floatwin)
    end,
    desc = 'Close fugitive floating window after we leave it',
    group = fug_floatwin,
  })

  vim.schedule(function()
    local lines = vim.api.nvim_buf_get_lines(fug_buf, 0, -1, false)
    for i, line in ipairs(lines) do
      if line:find(vim.fn.fnamemodify(current_buf_name, ':.')) then
        vim.api.nvim_win_set_cursor(fug_win, { i, 0 })
        break
      end
    end
  end)
end

return M
