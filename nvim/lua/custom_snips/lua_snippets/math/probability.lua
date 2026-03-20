local ctx = require("utils.factory").math
local p = ctx.p

return {
  ----------------------------------------------------------------------------
  -- 1. Basic Probability & Measure
  ----------------------------------------------------------------------------

  -- Expectation: \E{...} -> \mathbb{E}\left[ ... \right]
  p({ trig = "EE", name = "Expectation" }, "\\mathbb{E}\\left[ ${1:${TM_SELECTED_TEXT}} \\right] $0"),

  -- Probability: \P{...} -> \mathbb{P}\left( ... \right)
  p({ trig = "PP", name = "Probability" }, "\\mathbb{P}\\left( ${1:${TM_SELECTED_TEXT}} \\right) $0"),

  -- Variance: \V{...} -> \mathrm{Var}\left[ ... \right]
  p({ trig = "VV", name = "Variance" }, "\\mathrm{Var}\\left[ ${1:${TM_SELECTED_TEXT}} \\right] $0"),

  -- Covariance
  p({ trig = "Cov", name = "Covariance" }, "\\mathrm{Cov}\\left( ${1:${TM_SELECTED_TEXT}}, $2 \\right) $0"),

  ----------------------------------------------------------------------------
  -- 2. Subscripted Versions (e.g., Expectation with respect to a distribution)
  ----------------------------------------------------------------------------

  -- \Ex{A}{B} -> \mathbb{E}_{A}\left[ B \right]
  p({ trig = "EEx", name = "Expectation (subscript)" }, "\\mathbb{E}_{$1}\\left[ ${2:${TM_SELECTED_TEXT}} \\right] $0"),

  -- \Px{A}{B} -> \mathbb{P}_{A}\left( B \right)
  p({ trig = "PPx", name = "Probability (subscript)" }, "\\mathbb{P}_{$1}\\left( ${2:${TM_SELECTED_TEXT}} \\right) $0"),

  ----------------------------------------------------------------------------
  -- 3. Conditional Versions (Using \mid instead of \given)
  ----------------------------------------------------------------------------

  -- \Ec{A}{B} -> \mathbb{E}\left[ A \mid B \right]
  p({ trig = "EEc", name = "Conditional Expectation" }, "\\mathbb{E}\\left[ ${1:${TM_SELECTED_TEXT}} \\mid $2 \\right] $0"),

  -- \Pc{A}{B} -> \mathbb{P}\left( A \mid B \right)
  p({ trig = "PPc", name = "Conditional Probability" }, "\\mathbb{P}\\left( ${1:${TM_SELECTED_TEXT}} \\mid $2 \\right) $0"),

  -- \Exc{A}{B}{C} -> \mathbb{E}_{A}\left[ B \mid C \right]
  p({ trig = "EExc", name = "Cond. Expectation (subscript)" }, "\\mathbb{E}_{$1}\\left[ ${2:${TM_SELECTED_TEXT}} \\mid $3 \\right] $0"),

  ----------------------------------------------------------------------------
  -- 4. Indicator Functions
  ----------------------------------------------------------------------------

  -- Indicator with set braces: \mathds{1}\{ ... \}
  -- (Using \mathbb{1} as it is more standard without the dsfont package, 
  -- but you can change it to \mathds{1} if you prefer)
  p({ trig = "1i", name = "Indicator (braces)" }, "\\mathbb{1}_{\\left\\{ ${1:${TM_SELECTED_TEXT}} \\right\\}} $0"),

  -- Indicator without braces (just a subscript)
  p({ trig = "1I", name = "Indicator (subscript)" }, "\\mathbb{1}_{${1:${TM_SELECTED_TEXT}}} $0"),
  
  ----------------------------------------------------------------------------
  -- 5. Distributions & Relations
  ----------------------------------------------------------------------------
  
  -- Normal Distribution
  p({ trig = "Ndist", name = "Normal Distribution" }, "\\mathcal{N}\\left( ${1:\\mu}, ${2:\\sigma^2} \\right) $0"),
  
  -- Uniform Distribution
  p({ trig = "Udist", name = "Uniform Distribution" }, "\\mathrm{Unif}\\left( ${1:a}, ${2:b} \\right) $0"),
}
