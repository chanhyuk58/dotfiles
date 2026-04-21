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
vim.treesitter.language.register("markdown", "rmd")
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    if lang then
      pcall(vim.treesitter.start, bufnr, lang)
    end
  end,
})
