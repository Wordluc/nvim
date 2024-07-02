require("mason").setup()
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
local glob = require('vim.glob')
local poll=require("vim.lsp._watchfiles")._poll_exclude_pattern
if EnvManage.isEnv(EnvEnum.cs)then
	poll=poll+glob.to_lpeg("**/*.sln")
	poll=poll+glob.to_lpeg("**/*.csproj")
	poll=poll+glob.to_lpeg("**/bin/**")
	poll=poll+glob.to_lpeg("**/obj/**")
end
if EnvManage.isEnv(EnvEnum.wki)then
	poll=poll+glob.to_lpeg("**/FakeCredentials/**")
	poll=poll+glob.to_lpeg("**/GenyaUploads/**")
end
require("vim.lsp._watchfiles")._poll_exclude_pattern=poll

local cap = require('lspconfig').util.default_config.capabilities
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
default_setup("gopls")
default_setup("angularls")
default_setup("zls")
default_setup("clangd")
default_setup("html")
default_setup("cssls")
