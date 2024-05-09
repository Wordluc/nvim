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
	},
	automatic_installation = true,
}
local cap = require('cmp_nvim_lsp').default_capabilities()
local lsp = require("lspconfig")
lsp.lua_ls.setup {
	settings = { Lua = {
		diagnostics = {
			globals = { 'vim' } }
	}
	},
	capabilities = cap
}
lsp.zls.setup {
	capabilities = cap
}
lsp.clangd.setup {
	capabilities = cap
}
lsp.csharp_ls.setup {
	capabilities = cap
}
lsp.pyright.setup {
	capabilities = cap
}
lsp.tsserver.setup {
	capabilities = cap
}
lsp.vimls.setup {
	capabilities = cap
}
lsp.hls.setup {
	capabilities = cap
}
lsp.gopls.setup {
	capabilities = cap
}
lsp.angularls.setup {
	capabilities = cap
}
