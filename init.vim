set runtimepath^=~/.vim

" ----- Plugins {{{
call plug#begin('~/.vim/plugged')
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
    "----- telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'nvim-telescope/telescope-bibtex.nvim'
    " ----- Git
  Plug 'tpope/vim-fugitive'
  Plug 'lewis6991/gitsigns.nvim'
    " ----- Language and Keyboard Switch
  Plug 'lyokha/vim-xkbswitch'
    " ----- indentline
  Plug 'lukas-reineke/indent-blankline.nvim'
    " ----- tags
  "Plug 'ludovicchabant/vim-gutentags'
  "Plug 'majutsushi/tagbar'
    " ----- REPL
  Plug 'jpalardy/vim-slime'
    " ----- brackets
  Plug 'windwp/nvim-autopairs'
    " ----- vim obsession
  Plug 'tpope/vim-obsession'
    " ----- nvim-web-devicons
  Plug 'nvim-tree/nvim-web-devicons'
    " ----- images.nvim
  "Plug '3rd/image.nvim'
    " ----- markdown
  "Plug 'OXY2DEV/markview.nvim'
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
set spellfile=~/.vim/spell/en.utf-8.add
set undodir=~/.vim/undo_dir
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
set foldmethod=manual
set foldcolumn=0
let g:tex_flavor = "latex"
"set title
"set titlestring=%{pathshorten(expand('%:p'))}
set autochdir
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾   " replace tilde sign with space for empty lines
"set termguicolors
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
colorscheme seoul256-light
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

" ----- (Ob)session {{{
let g:session_dir = '~/.vim/session'
exec 'nnoremap ,ss :Obsession ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap ,sf :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
" }}}

" ----- XkbSwitch {{{
if has('mac') && filereadable('/usr/local/lib/libInputSourceSwitcher.dylib')
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
endif
" }}}

" ----- vim-slime {{{
let g:slime_target="kitty"
"let g:slime_default_config={"pane_direction":"next"}
"let g:slime_dont_ask_default = 1
let g:slime_bracketed_paste=1
let g:slime_no_mappings=1
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
        " -- md
        "autocmd FileType md,markdown nnoremap <C-T> :!pandoc % -o %:r.pdf<CR>
        " -- Python and R interpreter
        "nmap ,l <Plug>SlimeLineSend
        autocmd FileType python,r,Rmd,rmd nmap ,l <Plug>SlimeLineSend
        autocmd FileType python,r,Rmd,rmd xmap ,l <Plug>SlimeRegionSend
        autocmd FileType python,r,Rmd,rmd nmap ,; <Plug>SlimeParagraphSend
    " }}}
    " --- no highlight
    nnoremap <leader>e <esc>:nohl<CR>
    " --- telescope
    nnoremap ,bb :Telescope buffers<CR>
    nnoremap ,off :Telescope file_browser path=/Users/chanhyuk/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian<CR>
    nnoremap ,ff :Telescope file_browser<CR>
    nnoremap ,fg :Telescope live_grep<CR>
    nnoremap ,bib :Telescope bibtex<CR>
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
    " ----- tagbar toggle
    nmap <F8> :TagbarToggle<CR> 
    " let g:tagbar_left=1 " put tagbar on the left
" }}}

" ----- Settings in lua
lua<<EOF
dofile('/Users/chanhyuk/.vim/custom_functions/new_note.lua')

----- kitty-navigator {{{
require('kitty-navigator').setup({keybindings = {}})
--}}}

-- ----- markview.nvim {{{
--
-- require('markview').setup({
--     -- headings = presets.simple,
--     markdown = {
--       headings = {
--         enable = false,
--         heading_1 = { style = 'simple' },
--         heading_2 = { style = 'simple' },
--         heading_3 = { style = 'simple' },
--       },
--       list_items = {
--         enable = false,
--         indent_size = 0,
--         shift_width = 2,
--       },
--       code_blocks = {
--           enable = false,
--           pad_amount = 0,
--           min_width = 0,
--           -- style = 'simple',
--       }
--     },
--     preview = {
--       enable = true,
--       filetypes = { 'markdown', 'quarto', 'rmd' },
--       hybrid_modes = { 'n', 'i', 'v' },
--       linewise_hybrid_mode = false,
--     },
--     latex = {
--       inlines = { 
--         enable = true,
--         hl = '',
--         },
--       blocks = {
--           enable = false,
--       }
--     },
--     yaml = {
--         enable = false,
--         }
-- });
-- --}}}

-- ----- image.nvim {{{
-- require('image').setup({
--   backend = 'kitty',
--   processor = 'magick_cli', -- or 'magick_cli'
--   integrations = {
--     markdown = {
--       enabled = false,
--       clear_in_insert_mode = false,
--       download_remote_images = false,
--       only_render_image_at_cursor = true,
--       floating_windows = false, -- if true, images will be rendered in floating markdown windows
--       filetypes = { 'markdown', 'rmd' }, -- markdown extensions (ie. quarto) can go here
--     },
--     html = {
--       enabled = false,
--     },
--     css = {
--       enabled = false,
--     },
--   },
--   max_width = nil,
--   max_height = nil,
--   max_width_window_percentage = nil,
--   max_height_window_percentage = 50,
--   window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
--   window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
--   editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
--   tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
--   hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' }, -- render image files as images when opened
-- })
-- -- }}}

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

----- diagnostic messages {{{
vim.diagnostic.config({
   virtual_text = false,
   signs = false,
   update_in_insert = false,
   severity_sort = false,
})
-- }}}

----- telescope settings {{{
local bibtex_actions = require('telescope-bibtex.actions')
local bibtex_add = dofile('/Users/chanhyuk/.vim/custom_functions/bibtex_add.lua')
require('telescope').setup {
  defaults = {
    layout_strategy = 'flex', -- flex automatically decide vertical and horizontal mode
    layout_config = {
      horizontal = {
          preview_width = 0.5,
          },
      vertical = {
        preview_cutoff = 1,
        preview_height = 0.4
        }
      },
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    initial_mode = 'normal',
    path_display = {
        shorten = 2
        }
  },
  extensions = {
    file_browser = {
      grouped = true,
      depth = 3,
      auto_depth = true,
      follow_symlinks = true,
      display_stat = {},
      hijack_netrw = true,
      git_status = true,
      dir_icon = '󰉖', -- default icon is a bit wide
      mappings = {
        ['i'] = { -- insert mode
          ['<bs>'] = false, -- unlink backspace behavior 'go to the parent dir' 
          ['<C-n>'] = function(prompt_bufnr)
            local action_state = require 'telescope.actions.state'
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            local finder = current_picker.finder
            local get_target_dir = function(finder)
              local entry_path
              if finder.files == false then
                local entry = action_state.get_selected_entry()
                entry_path = entry and entry.value -- absolute path
              end
              return finder.files and finder.path or entry_path
            end
            require 'telescope.actions'.close(prompt_bufnr)
            new_note(get_target_dir(finder) .. '/')
          end
          },
        }
      },
    bibtex = {
      -- Depth for the *.bib file
      depth = 1,
      -- Custom format for citation label
      -- custom_formats = {
      --     { id = 'obsidian', cite_marker = '[%s](../Reading_Notes/%s.md)'}
      --     },
      -- Format to use for citation label.
      -- Try to match the filetype by default, or use 'plain'
      -- format = '',
      -- Path to global bibliographies (placed outside of the project)
      global_files = {'/Users/chanhyuk/Documents/MyLibrary.bib'},
      -- Define the search keys to use in the picker
      search_keys = { 'author', 'year', 'title' },
      -- Template for the formatted citation
      citation_format = '{{author}}, ({{year}}), {{title}}.',
      -- Only use initials for the authors first name
      citation_trim_firstname = true,
      -- Max number of authors to write in the formatted citation
      -- following authors will be replaced by 'et al.'
      citation_max_auth = 2,
      -- Context awareness disabled by default
      context = false,
      -- Fallback to global/directory .bib files if context not found
      -- This setting has no effect if context = false
      context_fallback = false,
      -- Wrapping in the preview window is disabled by default
      wrap = false,
      mappings = {
        n = {
          ['<CR>'] = bibtex_add.citation_note(),
          ['<C-c>'] = bibtex_actions.key_append('%s'),
        },
        i = {
          ['<CR>'] = bibtex_add.citation_note(),
          ['<C-c>'] = bibtex_actions.key_append('%s'),
        },
      },
    },
  }
}
require('telescope').load_extension('bibtex')
require('telescope').load_extension('file_browser')
-- }}}
EOF
