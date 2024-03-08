require("mason").setup()
require("mason-lspconfig").setup{
	ensure_installed =
	{
	"omnisharp",
	"biome",
	"pyright",
	"tsserver",
	"lua_ls",
	"vimls",
        "hls",
	"gopls"
	},
	automatic_installation = true,


}
require("lspconfig").lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = {'vim'} }
			}
		}}
require("lspconfig").omnisharp.setup {}
require("lspconfig").biome.setup {}
require("lspconfig").pyright.setup {}
require("lspconfig").tsserver.setup {}
require("lspconfig").vimls.setup {}
require("lspconfig").hls.setup {}
require("lspconfig").gopls.setup {}
