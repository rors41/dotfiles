local lint = require 'lint'

local python_linters = {}

if vim.fn.executable 'ruff' == 1 then
  table.insert(python_linters, 'ruff')
end

if vim.fn.executable 'mypy' == 1 then
  local mypy = require('lint').linters.mypy
  local virtual = os.getenv 'VIRTUAL_ENV'
  mypy.args = {
    '--show-column-numbers',
    '--show-error-end',
    '--hide-error-context',
    '--no-color-output',
    '--no-error-summary',
    '--no-pretty',
  }

  if virtual then
    table.insert(mypy.args, '--python-executable')
    table.insert(mypy.args, virtual .. '/bin/python')
  end
  table.insert(python_linters, 'mypy')
end

lint.linters_by_ft = {
  markdown = { 'markdownlint' },
  python = python_linters,
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- Only run the linter in buffers that you can modify in order to
    -- avoid superfluous noise, notably within the handy LSP pop-ups that
    -- describe the hovered symbol using Markdown.
    if vim.opt_local.modifiable:get() then
      lint.try_lint()
    end
  end,
})
