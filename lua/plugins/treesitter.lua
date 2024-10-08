return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require 'nvim-treesitter.configs'.setup {
			ensure_installed = { "c", "c_sharp", "javascript", "typescript", "lua", "vim", "vimdoc", "zig", "rust" },
			modules = {},
			ignore_install = {},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			}, incremental_selection = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
				},
			},
			folding = {
				enable = true,
				enable_fold_comments = true,
			},
			playground = {
				enable = true,
			},
		}
	end
}
