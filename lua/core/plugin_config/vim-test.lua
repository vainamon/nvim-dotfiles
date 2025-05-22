vim.cmd [[
  let test#strategy = "vimux"
]]

vim.keymap.set('n', '<Leader>t', ':TestNearest<CR>', { desc = 'Run nearest test' })
vim.keymap.set('n', '<Leader>T', ':TestFile<CR>', { desc = 'Run tests for file' })
