local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- core settings
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- load remote plugins via lazy.nvim
require("plugins")

-- Colorscheme
require("catppuccin").setup({
  flavour = "latte",
  auto_integrations = true,
})
vim.cmd.colorscheme("catppuccin")

-- treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'python', 'tex', 'R', 'markdown', 
  'lua', 'vim', 'zsh', 'bash', 'rmd'},
  callback = function() vim.treesitter.start() end,
})

