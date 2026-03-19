local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local function is_inside_list_treesitter()
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "generic_environment" then
      -- Get the name of the environment
      local text = vim.treesitter.get_node_text(node, 0)
      if text:match("itemize") or text:match("enumerate") then
        return true
      end
    end
    node = node:parent()
  end
  return false
end

ls.add_snippets("tex", {
    s({ trig = "it", name = "item" }, 
      { t("\\item "), i(0) },
      { show_condition = in_latex_list }
    ),
})
