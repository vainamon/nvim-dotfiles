-- global config for diagnostic
vim.diagnostic.config {
  underline = false,
  virtual_text = false,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  severity_sort = true,
  float = {
    source = true,
    header = "Diagnostics:",
    prefix = " ",
    border = "single",
  },
}

-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local set_qflist = function(buf_num, severity)
  local diagnostics = nil
  diagnostics = vim.diagnostic.get(buf_num, { severity = severity })

  local qf_items = vim.diagnostic.toqflist(diagnostics)
  vim.fn.setqflist({}, " ", { title = "Diagnostics", items = qf_items })

  -- open quickfix by default
  vim.cmd([[copen]])
end

-- this puts diagnostics from opened files to quickfix
vim.keymap.set('n', '<Space>qw', vim.diagnostic.setqflist, { desc = "Put window diagnostics to qf" })

-- this puts diagnostics from current buffer to quickfix
vim.keymap.set('n', '<Space>qb', function()
  set_qflist(0)
end, { desc = "Put buffer diagnostics to qf" })

-- automatically show diagnostic in float win for current line
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    if #vim.diagnostic.get(0) == 0 then
      return
    end

    if not vim.b.diagnostics_pos then
      vim.b.diagnostics_pos = { nil, nil }
    end

    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    if not vim.deep_equal(cursor_pos, vim.b.diagnostics_pos) then
      vim.diagnostic.open_float {
        border = 'rounded',
        width = 100,
        source = true,
      }
    end

    vim.b.diagnostics_pos = cursor_pos
  end,
})

-- custom file types
vim.filetype.add {
  extension = {
    li = 'linkerscript',
  },
}
