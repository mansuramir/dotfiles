return {
    --'bluz71/vim-moonfly-colors',
    --name = 'moonfly',
    --theme = 'moonfly',
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        vim.cmd [[colorscheme tokyonight]]
    end,
}
