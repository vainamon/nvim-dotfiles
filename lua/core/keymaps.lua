-- navigate vim panes better
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')

-- clear search selection
vim.keymap.set('n', '<Leader>cs', ':nohlsearch<CR>', { desc = 'Clear search selection' })

-- for yanky
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Put after cursor' })
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Put before cursor' })
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)', { desc = 'Put after cursor and leave the cursor after' })
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)', { desc = 'Put before cursor and leave the cursor after' })

vim.keymap.set('n', '<A-p>', '<Plug>(YankyPreviousEntry)', { desc = 'Paste previous entry' })
vim.keymap.set('n', '<A-n>', '<Plug>(YankyNextEntry)', { desc = 'Paste next entry' })

vim.keymap.set('n', '<Leader>s', '<cmd>ClangdSwitchSourceHeader<cr>', { desc = 'Switch between source and header files' })

-- terminal toggle function
local term_buf = nil
local term_win = nil

function TermToggle(height)
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.cmd("hide")
  else
    vim.cmd("botright new")
    local new_buf = vim.api.nvim_get_current_buf()
    vim.cmd("resize " .. height)
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      vim.cmd("buffer " .. term_buf)       -- go to terminal buffer
      vim.cmd("bd " .. new_buf)            -- cleanup new buffer
    else
      vim.cmd("terminal")
      term_buf = vim.api.nvim_get_current_buf()
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.signcolumn = "no"
    end
    vim.cmd("startinsert!")
    term_win = vim.api.nvim_get_current_win()
  end
end

-- term toggle keymaps
vim.keymap.set("n", "<A-t>", ":lua TermToggle(10)<CR>", { desc = 'Toggle terminal', noremap = true, silent = true })
vim.keymap.set("i", "<A-t>", "<Esc>:lua TermToggle(10)<CR>", { desc = 'Toggle terminal', noremap = true, silent = true })
vim.keymap.set("t", "<A-t>", "<C-\\><C-n>:lua TermToggle(10)<CR>",
  { desc = 'Toggle terminal', noremap = true, silent = true })
