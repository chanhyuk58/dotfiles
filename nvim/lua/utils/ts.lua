local M = {}

-- 1. Define the Map: Context Name -> List of Treesitter Node Types
local CONTEXTS = {
  math = {
    "math_environment",
    "inline_formula",
    "displayed_equation",
    "latex_block", -- Markdown specific
  },
  list = {
    "list",
    "list_item",
    "bullet_list",
    "enum_list",
    "environment", -- LaTeX generic
  },
  code = {
    "fenced_code_block",
    "code_span",
    "chunk", -- Rmd/Quarto
  },
  comment = {
    "comment",
    "line_comment",
    "block_comment",
  }
}

-- 2. The Core "Tree Climber"
-- Checks if the cursor is inside any of the node types defined for a context
function M.in_context(context_name)
  local node = vim.treesitter.get_node() -- Gets node at cursor (handles injections)
  local target_nodes = CONTEXTS[context_name]
  
  if not target_nodes then return false end

  while node do
    local type = node:type()
    -- Check if current node type is in our target list
    for _, target in ipairs(target_nodes) do
      if type == target then
        -- Special check for LaTeX generic environments (itemize/enumerate)
        if type == "environment" or type == "generic_environment" then
          local text = vim.treesitter.get_node_text(node, 0)
          if text:match("itemize") or text:match("enumerate") or text:match("description") then
            return true
          end
        else
          return true
        end
      end
    end
    node = node:parent()
  end
  return false
end

return M
