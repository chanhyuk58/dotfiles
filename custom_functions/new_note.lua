function new_note()
  -- Request input from the user
  vim.ui.input({ prompt = "Title: " }, function(input)

    -- Set title based on date_time and input
    local title
    if input and input ~= "" then
      title = os.date("%Y%m%d%H%M%S") .. "_" .. input:gsub(" ", "_")
    else
      title = os.date("%Y-%m-%d")
    end

    -- Define file path
    local filepath = vim.fn.expand("/Users/chanhyuk/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/" .. title .. ".md")

    -- Open the file using :edit
    vim.cmd("edit " .. filepath)

    -- Check if the first line of the file is empty
    local first_line = vim.fn.getline(1)
    if first_line == "" then
      -- Insert markdown template at the start of the file
      vim.api.nvim_buf_set_lines(0, 0, 0, false, {
        '---',
        'title: '..'"'.. title ..'"',
        'created: '..os.date('%Y-%m-%d %H:%M:%S'),
        'modified: ',
        'tags: ',
        '---',
        '# '.. title
      })
    end
  end)
end
return
