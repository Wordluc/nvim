local lsp = require('lsp-zero')
lsp.preset("recommended")
local builtin = require('telescope.builtin')
lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	lsp.buffer_autoformat()

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "gl", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "gh", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>g", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.rename() end, opts)
	-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<C-g>", function() builtin.diagnostics({ severity_limit = 1 }) end, opts)
end)
vim.diagnostic.config { update_in_insert = true }
--vim.api.nvim_create_autocmd({ "BufWinEnter" }, { command = ":LspRestart" })
lsp.setup({
	virtual_text = true,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = 'minimal',
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
})
