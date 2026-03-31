require('nvim-treesitter').install({ 'lua', 'rust', 'zig', 'python', 'javascript', 'markdown', 'markdown_inline' })

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'rust', 'javascript', 'zig', 'lua', 'python' },
    callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then
                vim.cmd.packadd('nvim-treesitter')
            end
            vim.cmd('TSUpdate')
        end
    end,
})
