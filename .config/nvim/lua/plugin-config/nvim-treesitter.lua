require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
}

local function enable(buf)
  if not pcall(vim.treesitter.start, buf) then
    return
  end

  vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo[0][0].foldmethod = 'expr'
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args) enable(args.buf) end,
})

-- Startup filetype detection can precede this config being sourced.
if vim.bo.filetype ~= '' then
  enable(0)
end
