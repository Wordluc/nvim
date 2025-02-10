return {
	"Wordluc/telescope.nvim",
	dependencies = { "tsakirist/telescope-lazy.nvim",{"natecraddock/telescope-zf-native.nvim", build="make" }},
	config = function()
		local extra = {}
		require("telescope").setup {
			defaults = {
				path_display = {
					filename_first = {
						reverse_directories = true
					}
				},
				file_ignore_patterns = { "./^.git/*", "./node_modules/*", "node_modules", "^node_modules/*", "node_modules/*", unpack(extra) },
				mappings = {
					i = {
						["<M-k>"] = "preview_scrolling_up",
						["<M-j>"] = "preview_scrolling_down",
						["<M-h>"] = "preview_scrolling_left",
						["<M-l>"] = "preview_scrolling_right",

						["<C-k>"] = "move_selection_previous",
						["<C-j>"] = "move_selection_next",
					},
					n = {
						["<M-k>"] = "preview_scrolling_up",
						["<M-j>"] = "preview_scrolling_down",
						["<M-h>"] = "preview_scrolling_left",
						["<M-l>"] = "preview_scrolling_right",

						["<C-k>"] = "move_selection_previous",
						["<C-j>"] = "move_selection_next",
					}
				}
			},
		}
		require("telescope").load_extension("lazy")
		require("telescope").load_extension("marks_nvim")
		require("telescope").load_extension("zf-native")
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
		vim.keymap.set('n', '<leader>fvv', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Grep text" })
		vim.keymap.set('v', '<leader>fvv', function()
			vim.cmd('noau normal! "ay"')
			builtin.grep_string({ search = vim.fn.getreg("a") })
		end, { desc = "Grep text selected" })
		vim.keymap.set('n', '<leader>fb', function()
			builtin.buffers({ sort_mru = true })
		end, { desc = "Find buffers" })

		vim.keymap.set('n', '<leader>fm', function()
			require('telescope').extensions.marks_nvim.marks_list_all() --[[ List all marks ]]
		end, { desc = "Find buffers" })

		vim.keymap.set('n', '<leader>fh', function()
			builtin.lsp_references()
		end, { desc = "Find LSP references" })
		vim.keymap.set('n', '<leader>fv', builtin.live_grep, { desc = "Live Grep" })
		vim.keymap.set('n', '<leader>fg', builtin.git_status, { desc = "Git status" })
		vim.keymap.set('n', '<leader>fl', function() builtin.builtin({ filter_match = "lsp_", title = "LSP Picker" }) end,
			{ desc = "LSP Functions" })
		vim.keymap.set('n', '<C-x>', function() builtin.keymaps() end, { desc = "Keymaps" })
	end
}
