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
local oldMath = require("vim.lsp._watchfiles")._match

require("vim.lsp._watchfiles")._match = function(pattern, path)
	if EnvManage.isEnv(EnvEnum.cs) then
		if string.find(path, '.csproj') or string.find(path, '.sln') then
			return false
		end
		if string.find(path, 'bin') or string.find(path, 'obj') then
			return false
		end
	end
	if EnvManage.isEnv(EnvEnum.wki) then
		if string.find(path, 'FakeCredentials') or string.find(path, 'GenyaUploads') then
			return false
		end
	end
	return oldMath(pattern, path)
end
cap.workspace.didChangeWatchedFiles.dynamicRegistration = true

local default_setup = function(server)
	require('lspconfig')[server].setup({
		capabilities = cap,
	})
end

if EnvManage.isEnv(EnvEnum.conf) then
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
