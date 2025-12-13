local M = {}

function M.setup()
  vim.g.slime_target = "tmux"
  vim.g.slime_default_config = { socket_name = "default", target_pane = "{next}" }
  vim.g.slime_dont_ask_default = 1
  vim.g.slime_bracketed_paste = 1
end

return M
