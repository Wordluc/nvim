return {
	"williamboman/mason.nvim",
	dependencies = {
		"folke/neodev.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup()
		local glob = require('vim.glob')
		local poll = require("vim.lsp._watchfiles")._poll_exclude_pattern
		if EnvManage.isEnv(EnvEnum.cs) then
			poll = poll + glob.to_lpeg("**/*.sln")
			poll = poll + glob.to_lpeg("**/*.csproj")
			poll = poll + glob.to_lpeg("**/bin/**")
			poll = poll + glob.to_lpeg("**/obj/**")
		end
		if EnvManage.isEnv(EnvEnum.wki) then
			poll = poll + glob.to_lpeg("**/FakeCredentials/**")
			poll = poll + glob.to_lpeg("**/*.js")
			poll = poll + glob.to_lpeg("**/GenyaUploads/**")
		end
		require("vim.lsp._watchfiles")._poll_exclude_pattern = poll

		require("mason-lspconfig").setup {
			ensure_installed =
			{
				"csharp_ls",
				"pyright",
				"tsserver",
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

		local cap = require('lspconfig').util.default_config.capabilities
		cap.workspace.didChangeWatchedFiles.dynamicRegistration = true

		local default_setup = function(server)
			require('lspconfig')[server].setup({
				capabilities = cap,
			})
		end

		if EnvManage.isEnv(EnvEnum.conf) then
			require("neodev").setup()
		end
		require('lspconfig').lua_ls.setup {
			settings = { Lua = {
				diagnostics = {
					globals = { 'vim' } }
			},
				workspace = {
					library = {
						vim.env.VIMRUNTIME,
					}
				}
			},
			capabilities = cap
		}
		default_setup("csharp_ls")
		default_setup("pyright")
		default_setup("tsserver")
		default_setup("vimls")
		default_setup("gopls")
		default_setup("angularls")
		default_setup("zls")
		default_setup("clangd")
		default_setup("html")
		default_setup("cssls")
		vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
		vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
		vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
		local telescope = require('telescope.builtin')
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = { buffer = event.buf }
				local cli = vim.lsp.get_client_by_id(event.data.client_id)
				cli.init_options = { watchers = { { globPattern = "**/*.cs" } } }
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
	end

}
