-- bootstrap lazy.nvim if missing
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

-- No Background
vim.cmd("highlight Normal guibg=#ffffff")
