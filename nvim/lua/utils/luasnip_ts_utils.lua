local M = {}

local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
  latex_block = true,
}
local TEXT_NODES = {
  text_mode = true,
  label_definition = true,
  label_reference = true,
}
local CODE_NODES = {
  code_span = true,
}
local MARKDOWN = {
    markdown = true,
    rmd = true,
}

local function get_node_at_cursor()
  local pos = vim.api.nvim_win_get_cursor(0)
  -- Subtract one to account for 1-based row indexing in nvim_win_get_cursor
  local row, col = pos[1] - 1, pos[2]
  if MARKDOWN[vim.bo.filetype] then
    parser = vim.treesitter.get_parser(0, "markdown_inline")
  else
    parser = vim.treesitter.get_parser(0)
  end

  if not parser then
    return
  end

  local root_tree = parser:parse({ row, col, row, col })[1]
  local root = root_tree and root_tree:root()
  if not root then
    return
  end
  return root:named_descendant_for_range(row, col, row, col)
end

local function get_node_at_cursor2()
  local pos = vim.api.nvim_win_get_cursor(0)
  -- Subtract one to account for 1-based row indexing in nvim_win_get_cursor
  local row, col = pos[1] - 1, pos[2]

  local parser = vim.treesitter.get_parser(0, "markdown_inline")
  if not parser then
    return
  end

  local root_tree = parser:parse({ row, col, row, col })[1]
  local root = root_tree and root_tree:root()
  if not root then
    return
  end

  return root:named_descendant_for_range(row, col, row, col)
end

function M.in_text(check_parent)
  local node = get_node_at_cursor()
  while node do
    if TEXT_NODES[node:type()] then
      return true
    end
    node = node:parent()
  end
  return true
end

function M.in_mathzone()
  local node = get_node_at_cursor()
    while node do
      if MATH_NODES[node:type()] then
        return true
      elseif TEXT_NODES[node:type()] then
        return false
      end
      node = node:parent()
    end
  return false
end

return M
