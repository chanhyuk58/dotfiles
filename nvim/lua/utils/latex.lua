local M = {}

-- Finds the matching opening parenthesis by climbing backwards
function M.get_balanced_parens(str)
  local depth = 0
  for i = #str, 1, -1 do
    local c = str:sub(i, i)
    if c == ")" then depth = depth + 1
    elseif c == "(" then depth = depth - 1 end
    if depth == 0 then return i end
  end
  return nil
end

-- Logic for the "Smart Fraction"
-- Returns: { stripped_line, numerator }
function M.parse_smart_frac(trigger)
  local stripped = trigger:sub(1, #trigger - 1) -- Remove the trailing '/'
  
  -- Case 1: Parentheses (a + b)/ -> \frac{a + b}{}
  if stripped:sub(-1) == ")" then
    local start_index = M.get_balanced_parens(stripped)
    if start_index then
      local prefix = stripped:sub(1, start_index - 1)
      local num = stripped:sub(start_index + 1, #stripped - 1)
      return prefix, num
    end
  end

  -- Case 2: Subscripts/Superscripts x^{2}/ or x_n/
  local sub_super = stripped:match("[%w\\]+[%^_]{[%w%s%+%-%*]+}$") or 
                    stripped:match("[%w\\]+[%^_]%w$")
  if sub_super then
    local prefix = stripped:sub(1, #stripped - #sub_super)
    return prefix, sub_super
  end

  -- Case 3: Commands or Words \alpha/ or abc/
  local word = stripped:match("[%w\\]+$")
  if word then
    local prefix = stripped:sub(1, #stripped - #word)
    return prefix, word
  end

  return stripped, ""
end

return M
