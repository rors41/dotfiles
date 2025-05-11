-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.keymap.set('n', '<C-h>', '<cmd> TmuxNavigateLeft<cr>', { desc = 'Window left', silent = true, noremap = true })
      vim.keymap.set('n', '<C-l>', '<cmd> TmuxNavigateRight<cr>', { desc = 'Window right', silent = true, noremap = true })
      vim.keymap.set('n', '<C-j>', '<cmd> TmuxNavigateDown<cr>', { desc = 'Window down', silent = true, noremap = true })
      vim.keymap.set('n', '<C-k>', '<cmd> TmuxNavigateUp<cr>', { desc = 'Window up', silent = true, noremap = true })
    end,
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.cmd [[Lazy load markdown-preview.nvim]]
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree' })
    end,
  },
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup {
        completion = {
          crates = {
            enabled = true,
            max_results = 8,
            min_chars = 3,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      }
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    'tamton-aquib/duck.nvim',
    config = function()
      vim.keymap.set('n', '<leader>Dd', function()
        require('duck').hatch()
      end, { desc = '[D]uck hatch' })
      vim.keymap.set('n', '<leader>DD', function()
        local duck = require 'duck'
        for _ = 0, 12 do
          duck.hatch()
        end
      end, { desc = '[D]uck hatch a [D]ozen' })
      vim.keymap.set('n', '<leader>Dc', function()
        require('duck').cook()
      end, { desc = '[D]uck [c]ook' })
      vim.keymap.set('n', '<leader>Da', function()
        require('duck').cook_all()
      end, { desc = '[D]uck cook [a]ll' })
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
}
