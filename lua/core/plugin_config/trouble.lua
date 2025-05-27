require('trouble').setup({
  preview = {
    type = "float",
    relative = "editor",
    border = "rounded",
    title = "Preview (Trouble)",
    title_pos = "center",
    position = { 0, -2 },
    size = { width = 0.4, height = 0.3 },
    zindex = 200,
  },
})

vim.keymap.set('n', '<Leader>xx', '<Cmd>Trouble diagnostics toggle<CR>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<Leader>xb', '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>',
  { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<Leader>xs', '<Cmd>Trouble symbols toggle focus=false win.position=bottom<CR>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<Leader>xq', '<Cmd>Trouble qflist toggle<CR>', { desc = 'Quickfix List (Trouble)' })
vim.keymap.set('n', '<Leader>xl', '<Cmd>Trouble loclist toggle<CR>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<Leader>xr', '<Cmd>Trouble lsp toggle focus=false<CR>',
  { desc = 'LSP Definitions / references / ... (Trouble)' })
vim.keymap.set('n', '<Leader>xd', '<Cmd>Trouble todo toggle<CR>', { desc = 'Todo List (Trouble)' })

require('todo-comments').setup()

vim.keymap.set("n", "]c", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[c", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
