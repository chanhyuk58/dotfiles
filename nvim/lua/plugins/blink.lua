require("blink.cmp").setup({
  snippets = { preset = "luasnip" },
  
  sources = { 
    default = { "path", "snippets", "buffer" },
    providers = {
      snippets = {
        score_offset = 100,
        max_items = 8,
      },
      buffer = {
        min_keyword_length = 4,
        max_items = 5,
      }
    }
  },
  fuzzy = { prebuilt_binaries = { download = true } },

  keymap = {
    preset = 'none',
    
    ['<CR>'] = { 'accept', 'fallback' },
    
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },
    
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
  },

  completion = {
    -- Show a preview of the snippet code in a side window
    documentation = { 
      auto_show = true, 
      auto_show_delay_ms = 200 
    },
    ghost_text = { enabled = true },
    list = { 
      selection = { 
        preselect = false,
        auto_insert = false 
      } 
    },
    menu = {
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" }
        },
      }
    }
  },
})
