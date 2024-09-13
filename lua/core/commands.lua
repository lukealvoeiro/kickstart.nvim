function YankDiagnosticError()
  vim.diagnostic.open_float()
  vim.diagnostic.open_float()
  local win_id = vim.fn.win_getid() -- get the window ID of the floating window
  vim.cmd 'normal! j' -- move down one row
  vim.cmd 'normal! VG' -- select everything from that row down
  vim.cmd 'normal! "+y' -- yank selected text
  vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID
end
