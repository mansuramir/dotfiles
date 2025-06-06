---@type vim.lsp.Config
return {
	cmd = { "deno", "lsp" },
	root_markers = { "deno.json", "deno.jsonc" },
	filetypes = { "json", "javascript", "typescript", "javascriptreact", "typescriptreact", "jsx", "tsx" },
}
