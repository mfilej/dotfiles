-- https://github.com/phelipetls/jsonpath.nvim/blob/main/lua/jsonpath.lua

local M = {}

local parsers = require("nvim-treesitter.parsers")
local ts_utils = require("nvim-treesitter.ts_utils")

local get_node_text = function(node)
  return vim.treesitter.get_node_text(node, 0)
end

local get_string_content = function(node)
  for _, child in ipairs(ts_utils.get_named_children(node)) do
    if child:type() == "string_content" then
      return get_node_text(child)
    end
  end

  return ""
end

local starts_with_number = function(str)
  return str:match("^%d")
end

local contains_special_characters = function(str)
  return str:match("[^a-zA-Z0-9_]")
end

M.get = function()
  if not parsers.has_parser() then
    return ""
  end

  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return ""
  end

  local accessors = {}
  local node = current_node

  while node do
    local accessor = ""

    if node:type() == "pair" then
      local key_node = unpack(node:field("key"))
      local key = get_string_content(key_node)

      if starts_with_number(key) or contains_special_characters(key) then
        accessor = string.format('["%s"]', key)
      else
        accessor = string.format("%s", key)
      end
    end

    if node:type() == "array" then
      accessor = "[]"

      for i, child in ipairs(ts_utils.get_named_children(node)) do
        if ts_utils.is_parent(child, current_node) then
          accessor = string.format("[%d]", i - 1)
        end
      end
    end

    if accessor ~= "" then
      table.insert(accessors, 1, accessor)
    end

    node = node:parent()
  end

  if #accessors == 0 then
    return "."
  end

  local path = ""

  for i, accessor in ipairs(accessors) do
    if i == 1 then
      path = path .. "." .. accessor
    elseif vim.startswith(accessor, "[") then
      path = path .. accessor
    else
      path = path .. "." .. accessor
    end
  end

  return path
end

return M
