function new_note()
  -- Request input from the user
  vim.ui.input({ prompt = 'Title: ' }, function(input)

    -- Set title based on date_time and input
    local title
    local tag
    if input and input ~= '' then
      filepath = vim.fn.expand('/Users/chanhyuk/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Fleeting/' .. input:gsub(' ', '_') .. '_' .. os.date('%Y%m%d%H%M%S') .. '.md')
      title = input
      tag = ''
    elseif input == '' then
      title = os.date('%Y-%m-%d')
      filepath = vim.fn.expand('/Users/chanhyuk/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Fleeting/' .. title .. '.md')
      tag = 'Diary'
    else
      return
    end


    -- Open the file using :edit
    vim.cmd('edit ' .. filepath)

    -- Check if the first line of the file is empty
    local first_line = vim.fn.getline(1)
    if first_line == '' then
      -- Insert markdown template at the start of the file
      vim.api.nvim_buf_set_lines(0, 0, 0, false, {
        '---',
        'title: '..'"'.. title ..'"',
        'created: '..os.date('%Y-%m-%d %H:%M:%S'),
        'modified: ',
        'tags: ',
        '    - ' .. tag,
        '---',
        '',
      })
    end
  end)
end
return
