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
}
