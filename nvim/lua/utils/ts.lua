local M = {}

local CONTEXTS = {
  math = {
    -- LaTeX parser nodes
    "math_environment",
    "inline_formula",
    "displayed_equation",
    -- Markdown parser nodes
    "latex_block",
    "math_span",
    "formula_content",
  },
  list = {
    "list",
    "list_item",
    "bullet_list",
    "enum_list",
    "environment",
    "generic_environment",
  },
  code = {
    "fenced_code_block",
    "code_span",
    "chunk",
  },
}

-- Helper: Search backwards for the nearest \begin or \end in Markdown
local function in_latex_env_markdown(env_names)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_num = cursor[1] - 1
  
  -- Search upwards for the nearest \begin or \end
  for l = line_num, 0, -1 do
    local line = vim.api.nvim_buf_get_lines(0, l, l + 1, false)[1]
    
    -- If we find an \end first, we are NOT inside the environment
    for _, env in ipairs(env_names) do
      if line:match("\\end{" .. env .. "}") then return false end
      if line:match("\\begin{" .. env .. "}") then return true end
    end
  end
  return false
end

function M.in_context(context_name)
  local node = vim.treesitter.get_node({ ignore_injections = false })
  local target_nodes = CONTEXTS[context_name]
  if not target_nodes then return false end

  -- 1. Try Treesitter first (Works for .tex and native Markdown lists)
  local temp_node = node
  while temp_node do
    local type = temp_node:type()
    for _, target in ipairs(target_nodes) do
      if type == target then
        -- If it's a LaTeX environment node, check the name
        if type == "environment" or type == "generic_environment" then
          local begin_node = temp_node:child(0)
          if begin_node then
            local text = vim.treesitter.get_node_text(begin_node, 0)
            if text:match("itemize") or text:match("enumerate") or text:match("description") then
              return true
            end
          end
        else
          -- It's a math node or a native Markdown list node
          return true
        end
      end
    end
    temp_node = temp_node:parent()
  end

  -- 2. Fallback for LaTeX environments in Markdown (where TS fails)
  if vim.bo.filetype == "markdown" and context_name == "list" then
    return in_latex_env_markdown({"itemize", "enumerate", "description"})
  end

  return false
end

return M
