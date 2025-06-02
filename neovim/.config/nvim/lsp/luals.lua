return {
    name = 'lua-language-server',
    cmd = { 'lua-language-server' },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git', '.vim', 'nvim' }, { upward = true })[1]),
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
}
