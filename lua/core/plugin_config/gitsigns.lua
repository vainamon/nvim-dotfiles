local gitsigns = require('gitsigns')

gitsigns.setup {
  preview_config = {
    border = 'rounded',
  },
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<Leader>hs', gitsigns.stage_hunk, { desc = 'Git stage hunk' })
    map('n', '<Leader>hr', gitsigns.reset_hunk, { desc = 'Git reset hunk' })

    map('v', '<Leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'Git stage hunk' })

    map('v', '<Leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'Git reset hunk' })

    map('n', '<Leader>hS', gitsigns.stage_buffer, { desc = 'Git stage buffer' })
    map('n', '<Leader>hR', gitsigns.reset_buffer, { desc = 'Git reset buffer' })
    map('n', '<Leader>hp', gitsigns.preview_hunk, { desc = 'Git preview hunk' })
    map('n', '<Leader>hi', gitsigns.preview_hunk_inline, { desc = 'Git preview hunk inline' })

    map('n', '<Leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, { desc = 'Git blame line' })

    map('n', '<Leader>hd', gitsigns.diffthis, { desc = 'Git show diff' })

    map('n', '<Leader>hD', function()
      gitsigns.diffthis('~')
    end, { desc = 'Git show diff' })

    map('n', '<Leader>hQ', function() gitsigns.setqflist('all') end, { desc = 'Git show all hunks locations list' })
    map('n', '<Leader>hq', gitsigns.setqflist, { desc = 'Git show buffer hunks locations list' })

    -- Toggles
    map('n', '<Leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Git toggle current line blame' })
    map('n', '<Leader>td', gitsigns.toggle_deleted, { desc = 'Git toggle deleted' })
    map('n', '<Leader>tw', gitsigns.toggle_word_diff, { desc = 'Git toggle word diff' })

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Git select hunk' })
  end
}
