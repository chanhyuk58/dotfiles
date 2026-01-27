function Cite(el)
  -- We only want to apply this if the output is Beamer
  if not (FORMAT == "beamer") then
    return el
  end

  -- el.citations is an array. We check the mode of the first citation.
  -- Mode "NormalCitation" is what Pandoc uses for square-bracket citations.
  if el.citations[1].mode == "NormalCitation" then
    return {
      pandoc.RawInline('latex', '{\\tiny\\color{black!50}'),
      el,
      pandoc.RawInline('latex', '}')
    }
  end

  -- For "AuthorInText" (@cite) or others, return unchanged
  return el
end
