set runtimepath^=~/.config/root_config/.vim

" ----- Plugins {{{
call plug#begin('~/.config/root_config/.vim/plugged')
    " ----- LSP
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " ----- nvim-cmp
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
    "----- luasnip
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
    " ----- Git
  Plug 'tpope/vim-fugitive'
  Plug 'lewis6991/gitsigns.nvim'
    " ----- Language and Keyboard Switch
  Plug 'lyokha/vim-xkbswitch'
    " ----- indentline
  Plug 'lukas-reineke/indent-blankline.nvim'
    " ----- REPL
  Plug 'jpalardy/vim-slime'
    " ----- brackets
  Plug 'windwp/nvim-autopairs'
    " ----- vim obsession
  Plug 'tpope/vim-obsession'
    " ----- nvim-web-devicons
  Plug 'nvim-tree/nvim-web-devicons'
    " ----- Kitty navigator
  Plug 'MunsMan/kitty-navigator.nvim'
call plug#end()
" }}}

" ----- Basic settings {{{
set mouse=a
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set splitright
set splitbelow 
set autoindent
set smartindent
set smartcase
set cindent
set laststatus=0            "statusline 0 = hide 2 = always
set showmatch
set hlsearch
set backspace=eol,start,indent
set noshowmode
set spell
set spelllang=cjk,en_us
set spellfile=~/.config/root_config/.vim/spell/en.utf-8.add
set undodir=~/.config/root_config/.vim/undo_dir
set undofile
set wrap
set linebreak
set number
set relativenumber
set numberwidth=5
set breakindent
set encoding=utf-8
set fileencoding=utf-8
set signcolumn=yes
set foldmethod=marker
set foldcolumn=0
let g:tex_flavor = "latex"
set title
set titlestring=%{pathshorten(expand('%:p'))}
set autochdir
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾   " replace tilde sign with space for empty lines
"let &t_ZH="\e[3m" " italic
let &t_ZR="\e[23m" " italic or bold
set termguicolors
" }}}

" ----- line number auto toggle {{{
 :augroup numbertoggle
 :  autocmd!
 :  autocmd BufEnter,FocusGained,InsertLeave * let &statuscolumn='%s%{v:relnum}%='
 :  autocmd BufLeave,FocusLost,InsertEnter   * let &statuscolumn='%s%{v:lnum}%='
 :augroup END
" }}}

" ----- Copy to and Paste from clipboard {{{
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>y  "+y

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
" }}}

" ----- Split pane navigation {{{
" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>
" }}}

" ----- Remember Code folding {{{
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END
" }}}

" ----- Theme {{{
"colorscheme seoul256-light
"colorscheme solarized
" }}}

" ----- Remember the cursor position {{{
autocmd BufReadPost * silent!
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"zz" |
\ endif
" }}}

" ----- Insert modified timestamp for markdown files {{{
autocmd BufWritePre,FileWritePre *.md,*rmd   ks|call LastMod()|'s
fun LastMod()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  exe "1," .. l .. "g/modified: /s/modified: .*/modified: " ..
  \ strftime("%Y-%m-%d %H:%M:%S")
endfun
" }}}

" ----- XkbSwitch {{{
if has('mac') && filereadable('/usr/local/lib/libInputSourceSwitcher.dylib')
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
endif
" }}}

" ----- vim-slime {{{
"let g:slime_target="kitty"
let g:slime_target="tmux"
"let g:slime_default_config={"pane_direction":"next"}
"let g:slime_dont_ask_default = 1
let g:slime_bracketed_paste=1
"let g:slime_no_mappings=1
" }}}

" ----- Key mapping{{{
    " ----- compile {{{
        " -- C
        autocmd FileType c nmap <buffer><silent> <C-T> :!clang bufname('%') -o '%:t:r' && ./'%:t:r' <CR>
        "" -- Tex
        autocmd FileType tex nmap <buffer> <C-T> :!latexmk -pdflatex -quiet '%:p'<CR>
        autocmd FileType tex nmap <buffer> <C-C> :!latexmk -c '%:p'<CR>
        autocmd FileType tex nmap <buffer> <C-O> :!open -ga skim '%:p:r.pdf'<CR>
        "" -- Rmd
        autocmd FileType Rmd,rmd nnoremap <C-T> :!R -e "rmarkdown::render('%:p')"<CR>
        autocmd FileType tex nmap <buffer> <C-O> :!open -ga skim '%:p:r.pdf'<CR>
        autocmd FileType tex nmap <buffer> <C-O> :!open -ga skim '%:p:r.pdf'<CR>
        " -- md
        autocmd FileType md,markdown nnoremap <C-T> :!pandoc % -o %:r.pdf<CR>
        autocmd FileType tex nmap <buffer> <C-O> :!open -ga skim '%:p:r.pdf'<CR>
        " -- Python and R interpreter
        "nmap ,l <Plug>SlimeLineSend
        autocmd FileType python,r,Rmd,rmd nmap ,l <Plug>SlimeLineSend
        autocmd FileType python,r,Rmd,rmd xmap ,l <Plug>SlimeRegionSend
        autocmd FileType python,r,Rmd,rmd nmap ,; <Plug>SlimeParagraphSend
    " }}}
    " --- no highlight
    nnoremap <leader>e <esc>:nohl<CR>
    " --- luasnips
    nnoremap ,se :lua require("luasnip.loaders").edit_snippet_files(table)<CR>
    " --- new note
    nnoremap ,nn :lua new_note()<CR>
    " ----- delete current buffer file
    fun! DeleteFileAndCloseBuffer()
      let choice = confirm("Delete file and close buffer?", "&Yes \n&Nonono", 1)
      if choice == 1 | call delete(expand('%:p')) | bd | endif
    endfun
    nnoremap <Leader>bd :call DeleteFileAndCloseBuffer()<CR>
" }}}

" ----- Settings in lua
lua<<EOF
dofile('/Users/chanhyuk/.config/root_config/.vim/custom_functions/new_note.lua')

----- kitty-navigator {{{
require('kitty-navigator').setup({keybindings = {}})
--}}}

----- gitsigns {{{
require('gitsigns').setup()
-- }}}

----- indent-blankline {{{
require('ibl').setup({
  exclude = {filetypes = {'text', 'csv'}},
  indent = {char = '▏'},
  scope = {show_start = false, show_end = false},
})
local hooks = require 'ibl.hooks'
  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
  )
-- }}}

----- tree-sitter settings {{{
vim.treesitter.language.register('markdown', 'rmd')
require'nvim-treesitter.configs'.setup {
  ensure_installed = {'c', 'lua', 'latex', 'python', 'vim', 'r'},
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
          return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = {
      enable = true
  }
}
-- }}}

----- luasnip settings {{{
-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, 'luasnip')
if not luasnip_status then
  return
end

-- Load vs-code style snippets
require('luasnip.loaders.from_vscode').lazy_load({paths = '~/.vim/custom_snips/vs_snippets'})
require('luasnip.loaders.from_lua').lazy_load({paths = '~/.vim/custom_snips/lua_snippets'})

-- Enable autotriggered snippets
require('luasnip').setup({ enable_autosnippets = true, })

-- link math templates
luasnip.filetype_extend('rmd', { 'math' })
luasnip.filetype_extend('markdown', { 'math' })
luasnip.filetype_extend('tex', { 'math' })
-- }}}

----- nvim-cmp setings {{{
-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  view = {
    docs = { auto_open = false },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
            -- or #cmp.get_entries() == 1 ) then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
     }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
          cmp.select_next_item()
      end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' },
  },{
    { name = 'path' },
  },{
    { name = 'buffer'},
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
    { name = 'buffer' },
    }, {
    { name = 'luasnip'}
    }, {
    { name = 'path'}
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }, {
    { name = 'buffer' }
     }
  )
})
--}}}

----- autopairs settings {{{
-- Import nvim-autopairs safely
local autopairs_setup, autopairs = pcall(require, 'nvim-autopairs')
if not autopairs_setup then
  return
end

-- configure autopairs
autopairs.setup({
  -- disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
  check_ts = true, -- Enable treesitter
  ts_config = {
    lua = { 'string', 'source' }, -- Don't add pairs in lua string treesitter nodes
    markdown = { 'inline_formula', 'displayed_equation' },
    tex = {'inline_formula', 'displayed_equation'},
    javascript = { 'template_string' }, -- Don't add pairs in JavaScript template_string treesitter nodes
    java = false, -- Don't check treesitter on Java
  },
})
-- Import nvim-autopairs completion functionality safely
local cmp_autopairs_setup, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if not cmp_autopairs_setup then
  return
end

-- do not work for backticks
autopairs.remove_rule('`')
autopairs.remove_rule('```')
-- Make autopairs and completion work together
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
-- }}}
EOF
