local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set('n', '<leader>rca', function()
  vim.cmd.RustLsp 'codeAction'
end, { silent = true, buffer = bufnr, desc = 'LSP: [C]ode [A]ction' })

vim.keymap.set(
  'n',
  'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp { 'hover', 'actions' }
  end,
  { silent = true, buffer = bufnr, desc = 'LSP: ' .. 'Hover' }
)

vim.keymap.set(
  'n',
  '<leader>rt', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp 'testables'
  end,
  { silent = true, buffer = bufnr, desc = 'LSP: ' .. '[R]ust [T]estables' }
)

vim.keymap.set(
  'n',
  '<leader>rr', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp 'runnables'
  end,
  { silent = true, buffer = bufnr, desc = 'LSP: ' .. '[R]ust [R]unnables' }
)
