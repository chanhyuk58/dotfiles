set runtimepath^=~/.vim

" Plugins
call plug#begin('~/.vim/plugged')
    " ----- LSP
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
    " ----- nvim-cmp
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'rafamadriz/friendly-snippets'
    "----- luasnip
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
    " ----- nabla.nvim
  Plug 'jbyuki/nabla.nvim'
    "----- telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug '~/.vim/plugged/telescope-bibtex_ch.nvim'
    " ----- Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
    " ----- File explorer
  " Plug 'preservim/nerdtree'
    " ----- Language and Keyboard Switch
  Plug 'lyokha/vim-xkbswitch'
    " ----- indentline
  Plug 'lukas-reineke/indent-blankline.nvim'
    " ----- tags
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'
    " ----- vimux
  Plug 'preservim/vimux'
  Plug '~/.vim/autoload/vimux_plus.vim'
    " ----- autopair brackets
  Plug 'windwp/nvim-autopairs'
    " ----- looks
  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
  " Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
    " ----- vim obsession
  Plug 'tpope/vim-obsession'
call plug#end()

" ----- Basic settings
set colorcolumn=81
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
set laststatus=0            "0 = hide 2 = always
set title
set showmatch
set hlsearch
set backspace=eol,start,indent
set noshowmode
set cursorline
set number
set relativenumber
set nospell
set spelllang=en_us,cjk
set undodir=~/.vim/undo_dir
set undofile
set list
set listchars=eol:↴
set signcolumn=number
set encoding=utf-8
set fileencodings=utf-8,cp949
set breakindent
let &t_Cs="\e[4:3m"
let &t_Ce="\e[4:0m"
" set termguicolors 
let g:tex_flavor = "latex"
" set textwidth=80

" ----- line number auto toggle
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" ----- keep cursor line vertically centered
autocmd CursorMoved,CursorMovedI * call Center_cursor()
function! Center_cursor()
    let pos = getpos(".")
    normal! zz
    call setpos(".", pos)
endfunction

" ----- Copy to and Paste from clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>y  "+y

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" ----- Split pane navigation
" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

" ----- Vim split 
" nnoremap <silent> vv <C-w>v
" nnoremap <silent> ss <C-w>s

" ----- Code folding 
set foldmethod=manual
set foldcolumn=1
" Remember code fold
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" ----- Theme
colorscheme seoul256-light

highlight! DiagnosticUnderlineError gui=undercurl guifg=red
highlight! DiagnosticUnderlineWarn gui=undercurl guifg=orange
highlight! DiagnosticUnderlineInfo gui=undercurl guifg=lightred
highlight! DiagnosticUnderlineHint gui=undercurl guifg=green

" ----- Remember the cursor position
autocmd BufReadPost * silent!
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"zz" |
\ endif

" ----- (Ob)session 
" cabbrev sos source ~/.vim/session/
" cabbrev obs Obsess ~/.vim/session/
" cabbrev obd Obsess!
let g:session_dir = '~/.vim/session'
exec 'nnoremap <Leader>ss :Obsession ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sf :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" ----- Vimux seting 
" -- C
" autocmd FileType c nmap <buffer><silent> <C-T> :!clang % -o %:t:r && ./%:t:r <CR>

autocmd FileType c nmap <buffer><silent> <C-T> :call VimuxRunCommand("clang " . bufname('%') . " -o " . expand('%:t:r') . " && ./" . expand('%:t:r')) <CR>

" -- Tex
autocmd FileType tex nmap <buffer> <C-T> :call VimuxRunCommand("latexmk -pdflatex -pv " . bufname('%'))<CR>
autocmd FileType tex nmap <buffer> <C-C> :call VimuxRunCommand("latexmk -c " . bufname('%'))<CR>

" -- Rmd
" autocmd FileType Rmd,rmd nnoremap <C-T> :call system("Rscript -e \"rmarkdown::render(\'" . bufname('%') . "\')\" \&& open -g -a skim " . expand('%:t:r') . ".pdf")<CR>
autocmd FileType Rmd,rmd nnoremap <C-T> :call VimuxRunCommand("rmarkdown::render(\'" . bufname('%') . "\')")<CR><CR>

" -- Python and R interpreter
autocmd FileType python,r,Rmd,rmd nnoremap ,l  :call VimuxSendLine()<CR>
autocmd FileType python,r,Rmd,rmd vnoremap ,l  :call VimuxSendMultiLine()<CR>

" autocmd FileType python noremap <silent> <C-n> :call RunTmuxPythonCell(0)<CR>
" autocmd FileType python noremap <C-a> :call RunTmuxPythonAllCellsAbove()<CR>

" ----- NERDTree and Tagbar toggle 
nmap <F9> :NERDTreeToggle<CR> 
nmap <F8> :TagbarToggle<CR> 
" autocmd FileType python,tex,r,c TagbarOpen
let g:tagbar_left=1

" ----- XkbSwitch Settings
if has('mac') && filereadable('/usr/local/lib/libInputSourceSwitcher.dylib')
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
endif

" ----- Key mapping
  " --- erase search register
nnoremap <leader>e <esc>:let @/=""<CR>
  " --- nabla
nnoremap ,s :lua require("nabla").popup()<CR>
  " --- telescope
nnoremap ,ls :Telescope buffers<CR>
nnoremap ,ff :Telescope find_files<CR>
nnoremap ,bib :Telescope bibtex<CR>
  " --- luasnips
nnoremap ,se :lua require("luasnip.loaders").edit_snippet_files(table)<CR>
  " --- new note
nnoremap ,nn :lua new_note

" ----- Delete current buffer file
fun! DeleteFileAndCloseBuffer()
  let choice = confirm("Delete file and close buffer?", "&Yes \n&Nonono", 1)
  if choice == 1 | call delete(expand('%:p')) | bd | endif
endfun
nnoremap <Leader>bd :call DeleteFileAndCloseBuffer()<CR>

" ----- Settings in lua
lua<<EOF
-- indent-blankline
require("ibl").setup()
dofile("/Users/chanhyuk/.vim/plugged/new_note.lua")

----- tree-sitter settings
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "latex", "python", "vim", "r"},
    
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "markdown" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  
  indent = {
      enable = true
  }
}

----- nvim-cmp settings
-- Load vs-code style snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.vim/custom_snips"}
)
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require'cmp'
luasnip.filetype_extend("rmarkdown", { "markdown" }) -- treat rmarkdown as markdown
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
      -- that way you will only jump inside the snippet region
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item()
      -- elseif has_words_before() then
      --   cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  },{
    { name = 'path' },
  },{
    { name = 'buffer' },
    },{
    { name = 'nvim_lsp' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
    { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local lsp = require "lspconfig"
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lsp.marksman.setup{capabilities = capabilities}
lsp.ltex.setup{capabilities = capabilities}
lsp.pyright.setup{capabilities = capabilities}
lsp.ccls.setup{capabilities = capabilities}
lsp.r_language_server.setup{capabilities = capabilities}
lsp.texlab.setup{
    enabled = {"rmd", "tex", "bibtex"},
    require('cmp_nvim_lsp').default_capabilities{
        filetypes = {"tex", "bib", "markdown", "rmd", "Rmd"},
        settings = {
            texlab = {
                build = {
                    executable = "latexmk",
                    args = {"-pdf", "-pv", "-interaction=nonstopmode", "-synctex=1", "%f"},
                    onSave = true,
                    -- isContinuous = true
                },
                chktex = {
                    onOpenAndSave = true
                },
                forwardSearch = {
                    executable = "sioyek",
                    args = {
                        '--reuse-window',
                        '--execute-command', 'toggle_synctex', -- Open Sioyek in synctex mode.
                        '--inverse-search',
                        [[nvim-texlabconfig -file %%%1 -line %%%2 -server ]] .. vim.v.servername,
                        '--forward-search-file', '%f',
                        '--forward-search-line', '%l', '%p'
                    }
                }
            }
        }
    }
}

----- autopairs settings
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({
    map_bs = false, 
    map_cr = false,
    enable_check_bracket_line = false
    })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

----- diagnostics 
-- hover line diagnostic
vim.diagnostic.config({
   virtual_text = false,
   signs = false,
   update_in_insert = true,
   severity_sort = false,
 })
vim.o.updatetime = 200
vim.keymap.set(
    'n' , ',d', function() vim.diagnostic.open_float(nil, {focus=false, scope="cursor"}) end
)

----- telescope settings
require("telescope").setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    layout_strategy = 'flex', -- vertical if small window size
    layout_config = {
      preview_cutoff = 1, -- Preview should always show
    },
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    bibtex = {
      -- Depth for the *.bib file
      depth = 1,
      -- Custom format for citation label
      custom_formats = {},
      -- Format to use for citation label.
      -- Try to match the filetype by default, or use 'plain'
      format = '',
      -- Path to global bibliographies (placed outside of the project)
      global_files = {'/Users/chanhyuk/Documents/MyLibrary.bib'},
      -- Define the search keys to use in the picker
      search_keys = { 'author', 'year', 'title' },
      -- Template for the formatted citation
      citation_format = '{{author}}, ({{year}}), {{title}}.',
      -- Only use initials for the authors first name
      citation_trim_firstname = true,
      -- Max number of authors to write in the formatted citation
      -- following authors will be replaced by "et al."
      citation_max_auth = 2,
      -- Context awareness disabled by default
      context = false,
      -- Fallback to global/directory .bib files if context not found
      -- This setting has no effect if context = false
      context_fallback = true,
      -- Wrapping in the preview window is disabled by default
      wrap = false,
    },
  }
}
require('telescope').load_extension('bibtex')
EOF
