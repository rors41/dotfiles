dap = require 'dap'
dap_view = require 'dap-view'
require 'dap.ui.widgets'

for _, group in ipairs {
  'DapBreakpoint',
  'DapBreakpointCondition',
  'DapBreakpointRejected',
  'DapLogPoint',
} do
  vim.fn.sign_define(group, { text = '●', texthl = group })
  vim.api.nvim_set_hl(0, group, { fg = '#e51400' })
end

vim.fn.sign_define('DapStopped', {
  text = '',
  texthl = 'DapStopped',
  linehl = 'debugPC',
  numhl = 'debugPC',
})

vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#ffcc00' })

dap.defaults.fallback.switchbuf = 'usevisible,usetab,newtab'

dap_view.setup {
  winbar = {
    sections = { 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl', 'console' },
  },
}

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    local port = (config.connect or config).port
    local host = (config.connect or config).host or 'localhost'
    cb {
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
    }
  else
    cb {
      type = 'executable',
      command = 'python',
      args = { '-m', 'debugpy.adapter' },
    }
  end
end

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })
vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = 'Debug: Terminate' })
vim.keymap.set('n', '<leader>dt', dap_view.toggle, { desc = 'Toggle DAP View' })
