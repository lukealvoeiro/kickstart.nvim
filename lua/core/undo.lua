local undopoints = { '<BS>', '<left>', '<right>', '<up>', '<down>', '<CR>', '<C-w>', '<C-u>', '.', ',' }
for _, key in pairs(undopoints) do
  vim.keymap.set('i', key, '<C-g>u' .. key)
end
