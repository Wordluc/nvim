require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed =
	{
		"csharp_ls",
		"pyright",
		"tsserver",
		"lua_ls",
		"vimls",
		"hls",
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
local oldMath = require("vim.lsp._watchfiles")._match

require("vim.lsp._watchfiles")._match = function(a, b)
	if string.find(b, '.csproj') or string.find(b, '.sln') then
		return false
	end

	return oldMath(a, b)
end

local default_setup = function(server)
	require('lspconfig')[server].setup({
		capabilities = cap,
	})
end

if Env.cur == Env.conf then
	require("neodev").setup()
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
end
default_setup("csharp_ls")
default_setup("pyright")
default_setup("tsserver")
default_setup("vimls")
default_setup("hls")
default_setup("gopls")
default_setup("angularls")
default_setup("zls")
default_setup("clangd")
default_setup("html")
default_setup("cssls")
