print("Welcome to all profiles")
require("WordLuc.Profiles.CSharp")
require("WordLuc.Profiles.go")
require("WordLuc.Profiles.rust")
Default_setup("pyright")
Default_setup("vimls")
Default_setup("zls")
Default_setup("clangd")

local cap = require('lspconfig').util.default_config.capabilities
require("neodev").setup()
require('lspconfig').lua_ls.setup {
	settings = {
		Lua = {
			hint = {
				enable = true
			},
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
