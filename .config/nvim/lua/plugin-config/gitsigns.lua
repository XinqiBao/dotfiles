require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
    end

    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gs.nav_hunk('next')
      end
    end)
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gs.nav_hunk('prev')
      end
    end)

    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('n', '<leader>hb', function() gs.blame_line({ full = true }) end)
    map('x', '<leader>hs', function()
      gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
    map('x', '<leader>hr', function()
      gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)
  end,
})
