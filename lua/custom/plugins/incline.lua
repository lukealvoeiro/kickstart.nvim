local num_of_files = 4

local function get_grapple_files()
  local grapple = require 'grapple'
  local files = {}
  local current_index = grapple.name_or_index()

  for i = 1, num_of_files do
    if not grapple.exists { index = i } then
      break
    end
    local path = grapple.find({ index = i }).path
    local file = { path = path, current = i == current_index }
    table.insert(files, file)
  end

  return files
end

local function get_name(path, depth)
  depth = depth or 1
  local parts = {}
  for part in string.gmatch(path, '[^/]+') do
    table.insert(parts, part)
  end

  local resultParts = {}
  for i = #parts - depth + 1, #parts do
    table.insert(resultParts, parts[i])
  end

  return table.concat(resultParts, '/')
end

local function generate_initial_names(files)
  for _, file in ipairs(files) do
    file.name = get_name(file.path)
  end
end

local function get_counts(files)
  local counts = {}
  for _, file in ipairs(files) do
    counts[file.name] = (counts[file.name] or 0) + 1
  end
  return counts
end

local function update_counts(files)
  local counts = get_counts(files)
  for _, file in ipairs(files) do
    file.count = counts[file.name]
  end
end

local function make_names(files)
  generate_initial_names(files)
  local duplicates = true
  local depth = 2
  while duplicates do
    duplicates = false
    update_counts(files)
    for _, file in ipairs(files) do
      if file.count > 1 then
        duplicates = true
        file.name = get_name(file.path, depth)
      end
    end
    depth = depth + 1
  end
end

return {
  'b0o/incline.nvim',
  config = function()
    local mocha = require('catppuccin.palettes').get_palette 'mocha'

    local icon_bg_color = require('config.utils').get_hlgroup('LineNr').fg
    local text_fg_color = require('config.utils').get_hlgroup('@word').fg
    local text_bg_color = require('config.utils').get_hlgroup('lualine_b_insert').bg

    text_bg_color = '#313244'

    local helpers = require 'incline.helpers'
    require('incline').setup {
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local function make_statusline(files)
          local result = {}
          local size = #files
          if size == 0 then
            return result
          end

          for i, file in ipairs(files) do
            local str_for_file = (i == 1 and '  ' or ' ') .. file.name .. (i == size and '  ' or ' ')
            if file.current then
              table.insert(result, { str_for_file, guibg = text_bg_color, guifg = icon_bg_color, gui = 'bold' })
            else
              table.insert(result, { str_for_file, guibg = text_bg_color, guifg = text_fg_color })
            end
          end
          table.insert(result, { ' 󰛢 ', guibg = icon_bg_color, guifg = helpers.contrast_color(icon_bg_color) })
          return result
        end

        local function get_new_grapple_status()
          local files = get_grapple_files()
          make_names(files)
          return make_statusline(files)
        end

        if props.focused then
          return {
            { get_new_grapple_status() },
          }
        end
      end,
    }
  end,
}
