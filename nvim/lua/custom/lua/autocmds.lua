-- Create group to assign commands
-- "clear = true" must be set to prevent loading an
-- auto-command repeatedly every time a file is resourced
local autocmd_group = vim.api.nvim_create_augroup('Custom auto-commands', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.zsh', '*.sh' },
  desc = 'Auto-format shell files after saving',
  callback = function()
    local fileName = vim.api.nvim_buf_get_name(0)
    vim.cmd(':silent !beautysh ' .. fileName)
  end,
  group = autocmd_group,
})
