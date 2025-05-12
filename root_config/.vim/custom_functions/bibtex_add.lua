--[[
This lua script works with telescope-bibtex, and adds two additional functions:  
  1) Create a markdown note for the selected bibliography. 
  2) Open pdf file that is linked with the bibliography (still needs more work to run properly).
]]--

package.path = package.path .. ";/Users/chanhyuk/.vim/plugged/telescope-bibtex.nvim/lua/"
local actions = require('telescope.actions')
local utils = require('telescope-bibtex.utils')
local action_state = require('telescope.actions.state')

return {
  citation_note = function(prompt_bufnr)
    return function(prompt_bufnr)
      local entry = action_state.get_selected_entry().id.content
      actions.close(prompt_bufnr)
      local path_reading_notes = '/Users/chanhyuk/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Reading_Notes/'
      local citeKey = utils.format_citation(entry, '{{label}}', opts)
      local pubTitle = utils.format_citation(entry, '{{title}}', opts)
      local pubType = utils.format_citation(entry, '{{type}}', opts)
      local pubAuthor = utils.format_citation(entry, '{{author}}', opts)
      local pubYear = utils.format_citation(entry, '{{year}}', opts)
      local pubAbstract = utils.format_citation(entry, '{{abstract}}', opts)
      local pubContainer = ''
      if pubType == 'article' then
        pubContainer = utils.format_citation(entry, '{{journal}}', opts)
      elseif pubType == 'techreport' then
        pubContainer = utils.format_citation(entry, '{{institution}}', opts)
      elseif pubType == 'incollection' then
        pubContainer = utils.format_citation(entry, '{{booktitle}}', opts)
      elseif pubType == 'unpublished' then
        pubContainer = 'unpublished'
      end
      local pubAbstract = utils.format_citation(entry, '{{abstract}}', opts)
      local fileName = path_reading_notes..citeKey..'.md'
      local noteTemplate = {
                '---',
                'title: '..'"'.. pubTitle..'"',
                'authors: '..'"'..pubAuthor..'"',
                'year: '..pubYear,
                'journal / book: '..'"'..pubContainer..'"',
                'abstract: '..'"'..pubAbstract..'"',
                'created: '..os.date('%Y-%m-%d %H:%M:%S'),
                'modified: ',
                'tags: ',
                '    - Research/reading',
                '---',
                '# '..citeKey,
                '## Research Question',
                '',
                '## Theory',
                '',
                '## Design and Data',
                '',
                '## Results',
                '',
                '## Comments'
            }
      vim.cmd('e '..fileName)
      local contentCount = vim.api.nvim_buf_line_count(0)
      if contentCount < 2 then
        local mode = vim.api.nvim_get_mode().mode
        if mode == 'i' then
          vim.api.nvim_put(noteTemplate, '', false, true)
          -- vim.api.nvim_feedkeys('a', 'n', true)
        else
          vim.api.nvim_put(noteTemplate, '', false, true)
        end
      end
    end
  end,
  open_pdf = function(prompt_bufnr)
    return function(prompt_bufnr)
      local entry = action_state.get_selected_entry().id.content
      actions.close(prompt_bufnr)
      local pubPath = utils.format_citation(entry, '{{bdsk-file-1}}', opts)
      local pubPathDecoded = from_base64(pubPath)
      print(pubPathDecoded)
      -- print('open -g -a skim '..pubPathDecoded)
      os.execute('open -g -a skim '..pubPathDecoded)
    end
  end
}
