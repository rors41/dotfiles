require('conform').setup {
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { 'stylua' },

    -- You can use a function here to determine the formatters dynamically
    python = function(bufnr)
      if require('conform').get_formatter_info('ruff_format', bufnr).available then
        return { -- To fix auto-fixable lint errors.
          'ruff_fix',
          -- To run the Ruff formatter.
          'ruff_format',
          -- To organize the imports.
          'ruff_organize_imports',
        }
      else
        return {}
      end
    end,
  },
  -- Set this to change the default values when calling conform.format()
  -- This will also affect the default values for format_on_save/format_after_save
  default_format_opts = {
    lsp_format = 'fallback',
  },
  -- If this is set, Conform will run the formatter on save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_format = 'fallback',
    timeout_ms = 500,
  },
  notify_on_error = true,
  -- Conform will notify you when no formatters are available for the buffer
  notify_no_formatters = true,
}
