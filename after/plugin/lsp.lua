vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
local telescope = require('telescope.builtin')
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "gl", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "gh", function() vim.diagnostic.goto_prev() end, opts)
		vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>g", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "gr", function() vim.lsp.buf.rename() end, opts)
		-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set("n", "<C-g>", function() telescope.diagnostics({ severity_limit = 1 }) end, opts)
	end
})
vim.diagnostic.config { update_in_insert = true }

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({})
end)
