require("diffview").setup({
  keymaps = {
    file_panel = {
      {
        "n", "cc",
        "<Cmd>Git commit <bar> wincmd J<CR>",
        { desc = "Commit staged changes" },
      },
      {
        "n", "ca",
        "<Cmd>Git commit --amend <bar> wincmd J<CR>",
        { desc = "Amend the last commit" },
      },
      {
        "n", "c<space>",
        ":Git commit ",
        { desc = "Populate command line with \":Git commit \"" },
      },
    },
  }
})

vim.keymap.set('n', '<Space>hh', '<cmd>DiffviewFileHistory<CR>', { desc = 'Repo history' })
vim.keymap.set('n', '<Space>hf', '<cmd>DiffviewFileHistory --follow %<CR>', { desc = 'File history' })
vim.keymap.set('v', '<Space>hl', "<esc><cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = 'Range history' })
vim.keymap.set('n', '<Space>hl', '<cmd>.DiffviewFileHistory --follow<CR>', { desc = 'Line history' })
vim.keymap.set('n', '<Space>d', '<cmd>DiffviewOpen<cr>', { desc = 'Repo diff' })

local function get_default_branch_name()
  local res = vim
      .system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true })
      :wait()
  return res.code == 0 and 'main' or 'master'
end

-- diff against local master branch
vim.keymap.set('n', '<Space>hm',
  function() vim.cmd('DiffviewOpen ' .. get_default_branch_name()) end,
  { desc = 'Diff against master' }
)

-- diff against remote master branch
vim.keymap.set('n', '<Space>hM',
  function() vim.cmd('DiffviewOpen HEAD..origin/' .. get_default_branch_name()) end,
  { desc = 'Diff against origin/master' }
)
