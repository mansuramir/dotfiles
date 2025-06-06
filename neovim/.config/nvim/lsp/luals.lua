return {
    name = 'lua-language-server',
    cmd = { 'lua-language-server' },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git', '.vim', 'nvim' }, { upward = true })[1]),
    filetypes = { "lua" },
    root_markers = { ".luarc.json", "luarc.lua", ".git" },

    settings = { 
        Lua = { 
            diagnostics = { 
                globals = { 'vim' } 
            },
            workspace = {
				library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
			},
            telemetry = {
                enable = false,
            },

        },
    },
}
