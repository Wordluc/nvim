return {
	"williamboman/mason.nvim",
	dependencies = {
		"folke/neodev.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require('mason').setup({
			registries = {
				'github:mason-org/mason-registry',
				'github:syndim/mason-registry'
			},
		})
		require("mason-lspconfig").setup {
			ensure_installed =
			{
				--			"csharp_ls",
				"roslyn",-- da sistemare 
				"pyright",
				"lua_ls",
				"vimls",
				"gopls",
				"angularls",
				"zls",
				"clangd",
				"html",
				"cssls",
			},
			automatic_installation = true,
		}

		vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
		vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
		vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
		local telescope = require('telescope.builtin')
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
				vim.keymap.set("n", "gl", function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "gh", function() vim.diagnostic.goto_prev() end, opts)
				vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
				vim.keymap.set("n", "<leader>g", function() vim.lsp.buf.references() end, opts)
				vim.keymap.set("n", "gr", function() vim.lsp.buf.rename() end, opts)
				vim.keymap.set("n", "<C-g>", function() telescope.diagnostics({ severity_limit = 1 }) end, opts)
				vim.keymap.set("n", "<C-d>", function() vim.lsp.buf.hover() end)
			end
		})
		vim.diagnostic.config { update_in_insert = true }

		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({})
			vim.fn.feedkeys("gg=G''")
		end)
	end
}
