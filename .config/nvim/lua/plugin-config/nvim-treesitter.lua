require'nvim-treesitter.configs'.setup {
  --[[
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- List of parsers to ignore installing
  ignore_install = { "javascript" },
  ]]

  -- Consistent syntax highlighting.
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },

  -- Incremental selection based on the named nodes from the grammar.
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = '<CR>',
      node_incremental  = '<CR>',
      node_decremental  = '<BS>',
      scope_incremental = '<TAB>',
    }
  },

  -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
  indent = {
    enable = false
  }
}
