require("nvim-tree").setup({
  sort_by = "case_sensitive",
  git = {
    enable = true,
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = { git = true, },
    },
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set('n', '<C-n>', ':NvimTreeFindFile<CR>', { desc = 'Find file and open in tree' })
