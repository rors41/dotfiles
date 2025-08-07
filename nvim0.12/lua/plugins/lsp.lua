require('mason').setup()

vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>td', function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
  else
    vim.diagnostic.enable(true)
  end
end, { desc = '[T]oggle [d]iagnostics' })

-- sort diagnostics
vim.diagnostic.config {
  severity_sort = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      typeCheckingMode = 'off',
    },
    python = {
      analysis = {
        ignore = { '*' },
      },
    },
  },
})

vim.lsp.enable { 'lua_ls', 'basedpyright' }

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('nvim-lsp-attach', { clear = true }),
  callback = function(event)
    vim.keymap.set('n', 'grD', function()
      MiniExtra.pickers.lsp { scope = 'declaration' }
    end, { desc = '[G]oto [D]eclaration' })
    vim.keymap.set('n', 'grd', function()
      MiniExtra.pickers.lsp { scope = 'definition' }
    end, { desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gOa', function()
      MiniExtra.pickers.lsp { scope = 'document_symbol' }
    end, { desc = '[G]oto [D]ocument [S]ymbol' })
    vim.keymap.set('n', 'gri', function()
      MiniExtra.pickers.lsp { scope = 'implementation' }
    end, { desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', 'grr', function()
      MiniExtra.pickers.lsp { scope = 'references' }
    end, { desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'grt', function()
      MiniExtra.pickers.lsp { scope = 'type_definition' }
    end, { desc = '[G]oto [T]ype [D]efinition' })
    vim.keymap.set('n', 'gWa', function()
      MiniExtra.pickers.lsp { scope = 'workspace_symbol' }
    end, { desc = '[G]oto [W]orkspace [S]ymbol' })

    vim.keymap.set({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, { desc = '[G]oto Code [A]ction' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('nvim-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('nvim-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'nvim-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, { desc = '[T]oggle Inlay [H]ints' })
    end
  end,
})
