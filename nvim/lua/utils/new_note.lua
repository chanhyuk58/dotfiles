-- utils/new_note.lua
local M = {}

-- Base directory for notes
local base_dir = "/Users/chanhyuk/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Fleeting/"

-- Helper to sanitize filenames
local function sanitize_filename(str)
  return str:gsub("%s+", "_")
end

function M.new_note()
  vim.ui.input({ prompt = "Title: " }, function(input)
    if input == nil then
      return -- user cancelled
    end

    local title, tag, filename

    if input ~= "" then
      title = input
      tag = ""
      filename = sanitize_filename(title) .. "_" .. os.date("%Y%m%d%H%M%S") .. ".md"
    else
      title = os.date("%Y-%m-%d")
      tag = "Diary"
      filename = title .. ".md"
    end

    local filepath = vim.fn.expand(base_dir .. filename)

    -- Open file
    vim.cmd("edit " .. filepath)

    -- Insert template if file is empty
    if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
      vim.api.nvim_buf_set_lines(0, 0, 0, false, {
        "---",
        'title: "' .. title .. '"',
        "created: " .. os.date("%Y-%m-%d %H:%M:%S"),
        "modified: ",
        "tags: ",
        "  - " .. tag,
        "---",
        "# " .. title,
      })
    end
  end)
end

return M
