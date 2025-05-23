require('telescope').setup({
  defaults = {
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        preview_cutoff = 0,
      },
    },
    previewer = true,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    path_display = { "truncate" },
  },
  file_ignore_patterns = { "node%_modules/.*" }
})

require('telescope').load_extension("live_grep_args")

local builtin = require('telescope.builtin')
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

-- Forward Visual Selection to Live-Grep-Args --
local function grep_visual_selection()
  -- Yank the current visual selection into to register "a"
  vim.cmd('normal! "ay')

  -- Get the content of register "a" and escape spaces
  local visual_selection = vim.fn.escape(vim.fn.getreg('a'), ' ')

  -- Call Telescope live_grep with the escaped visual selection
  vim.cmd('Telescope live_grep default_text=' .. visual_selection)
end

vim.keymap.set('n', '<Space>lf', builtin.find_files, { desc = 'Find files by name' })
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, { desc = 'Show recently used files list' })
vim.keymap.set('n', '<Space>lg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = 'Run live grep search' })
vim.keymap.set('n', '<Leader>b', builtin.buffers, { desc = 'Show buffers' })
vim.keymap.set('n', '<Space>ht', builtin.help_tags, { desc = 'Show help tags' })
vim.keymap.set('n', '<Space>ls', live_grep_args_shortcuts.grep_word_under_cursor,
  { desc = 'Run live grep search for symbol under cursor' })
vim.keymap.set('v', '<Space>lg', grep_visual_selection, { desc = 'Run live grep search', noremap = true, silent = true })
