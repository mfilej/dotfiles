-- https://github.com/liangxianzhe/nap.nvim/blob/6c5b91d194a884c9d476c96fef09bff8525b4ed3/lua/nap.lua#L79

local M = {}

-- Get directory containing the buffer, or cwd.
local get_dir_path = function()
  local cur_buf_path = vim.api.nvim_buf_get_name(0)
  return cur_buf_path ~= "" and vim.fn.fnamemodify(cur_buf_path, ":p:h") or vim.fn.getcwd()
end

-- Get files in directory.
-- @param dir_path string Directory path.
local get_files = function(dir_path)
  -- Compute sorted array of all files in target directory
  local dir_handle = vim.loop.fs_scandir(dir_path)
  if dir_handle == nil then
    return
  end
  local files_stream = function()
    return vim.loop.fs_scandir_next(dir_handle)
  end

  local files = {}
  for basename, fs_type in files_stream do
    if fs_type == "file" then
      table.insert(files, basename)
    end
  end

  -- - Sort files ignoring case
  table.sort(files, function(x, y)
    return x:lower() < y:lower()
  end)

  return files
end

-- Find index of current buffer in files.
-- @param files table Table of file names.
local cur_file_index = function(files)
  local cur_basename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  local cur_basename_ind
  if cur_basename ~= "" then
    for i, f in ipairs(files) do
      if cur_basename == f then
        cur_basename_ind = i
        break
      end
    end
  end
  return cur_basename_ind
end

-- Jump to next file in the same directory with current buffer, sorted by name.
function M.next_file()
  local dir_path = get_dir_path()
  local files = get_files(dir_path)
  if files == nil then
    return
  end
  local index = cur_file_index(files)
  if index + 1 <= #files then
    local path_sep = package.config:sub(1, 1)
    local target_path = dir_path .. path_sep .. files[index + 1]
    vim.cmd("edit " .. target_path)
  end
end
--
-- Jump to prev file in the same directory with current buffer, sorted by name.
function M.prev_file()
  local dir_path = get_dir_path()
  local files = get_files(dir_path)
  if files == nil then
    return
  end
  local index = cur_file_index(files)
  if index > 1 then
    local path_sep = package.config:sub(1, 1)
    local target_path = dir_path .. path_sep .. files[index - 1]
    vim.cmd("edit " .. target_path)
  end
end

return M
