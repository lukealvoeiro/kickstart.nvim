local M = {}

--- Get highlight properties for a given highlight name
--- @param name string The highlight group name
--- @param fallback? table The fallback highlight properties
--- @return table properties # the highlight group properties
function M.get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local group = vim.api.nvim_get_hl(0, { name = name })

    local hl = {
      fg = group.fg == nil and 'NONE' or M.parse_hex(group.fg),
      bg = group.bg == nil and 'NONE' or M.parse_hex(group.bg),
    }

    return hl
  end
  return fallback or {}
end

--- Remove a buffer by its number without affecting window layout
--- @param buf? number The buffer number to delete
function M.delete_buffer(buf)
  if buf == nil or buf == 0 then
    buf = vim.api.nvim_get_current_buf()
  end

  vim.api.nvim_command('bwipeout ' .. buf)
end

--- Switch to the previous buffer
function M.switch_to_previous_buffer()
  local ok, _ = pcall(function()
    vim.cmd 'buffer #'
  end)
  if not ok then
    vim.notify('No other buffer to switch to!', 3, { title = 'Warning' })
  end
end

--- Get the number of open buffers
--- @return number
function M.get_buffer_count()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.bufname(buf) ~= '' then
      count = count + 1
    end
  end
  return count
end

--- Parse a given integer color to a hex value.
--- @param int_color number
function M.parse_hex(int_color)
  return string.format('#%x', int_color)
end

--- Check if the specified buffer is floating
--- @param winid integer
function M.is_buffer_float(winid)
  return vim.api.nvim_win_get_config(winid).zindex
end

function M.is_curr_buffer_float()
  if M.is_buffer_float(vim.api.nvim_get_current_win()) then
    return true
  end
end

--- Check if the file is gitignored
--- @param file_path string
--- @return boolean: Returns true if the file is gitignored, false otherwise.
function M.is_file_git_gitignored(file_path)
  local handle = io.popen('git check-ignore ' .. file_path)
  if not handle then
    return false
  end

  local result = handle:read '*a'
  handle:close()

  if result ~= '' then
    return true
  else
    return false
  end
end

--- Checks if a given file is outside the current working directory.
--- @param file_path string: The path of the file to check.
--- @return boolean: Returns true if the file is outside the current working directory, false otherwise.
function M.is_file_outside_cwd(file_path)
  local cwd = vim.fn.getcwd() -- Get the current working directory
  local abs_file_path = vim.fn.fnamemodify(file_path, ':p') -- Get the absolute path of the file

  -- Check if the file path starts with the cwd
  if string.sub(abs_file_path, 1, #cwd) ~= cwd then
    return true
  else
    return false
  end
end

--- Get the absolute path of the current buffer.
--- @return string: The absolute path of the current buffer.
function M.get_current_buffer_path()
  --- @type string
  local buf_name = vim.api.nvim_buf_get_name(0)
  --- @type string
  local abs_path = vim.fn.fnamemodify(buf_name, ':p')
  return abs_path
end

function M.is_in_git_repo(file_path)
  local handle = io.popen 'git rev-parse --is-inside-work-tree 2>/dev/null'
  if not handle then
    return false
  end
  local _, exit_code = handle:close()
  if exit_code ~= 0 then
    return false
  end
  local check_ignore_handle = io.popen('git check-ignore ' .. file_path)
  if not check_ignore_handle then
    return false
  end
  local check_ignore_result = check_ignore_handle:read '*a'
  check_ignore_handle:close()
  if check_ignore_result ~= '' then
    return true
  else
    return false
  end
end

-- Define a generic table type
function M.shallow_copy(t)
  local t2 = {}
  for k, v in pairs(t) do
    t2[k] = v
  end
  return t2
end

--- Gets a cached value or computes it and caches the result.
--- @param cache table<string, any>: The table used to store cached values.
--- @param key string: The key to identify the cached value.
--- @param compute_func function: The function to compute the value if not cached.
--- @param ... any: Additional arguments to pass to the compute function.
--- @return any: The cached or computed value.
function M.get_cached_or_compute(cache, key, compute_func, ...)
  -- Check if the value is already cached
  if cache[key] then
    return cache[key]
  end

  -- Call the compute function with arguments and cache the result
  local result = compute_func(...)
  cache[key] = result

  return result
end

return M
