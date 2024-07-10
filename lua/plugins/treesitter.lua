return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,
	config = {
		ensure_installed = { "c", "c_sharp", "javascript", "typescript", "lua", "vim", "vimdoc", "query", "zig", "rust" },
		sync_install = false,

		auto_install = true,

		highlight = {
			enable = true,
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = true,
		},
	}
}
