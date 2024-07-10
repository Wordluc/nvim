return {
	"nvim-telescope/telescope.nvim",
	dependencies = "tsakirist/telescope-lazy.nvim",
	config = function()
		require("telescope").setup {
			defaults = {
				path_display = {
					filename_first = {
						reverse_directories = true
					}
				},
				file_ignore_patterns = { "./^.git/*", "./node_modules/*", "node_modules", "^node_modules/*", "node_modules/*" },
			}
		}
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fvv', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set('v', '<leader>fvv', function()
			vim.cmd('noau normal! "ay"')
			builtin.grep_string({ search = vim.fn.getreg("a") })
		end)
		vim.keymap.set('n', '<leader>fb', function()
			builtin.buffers({ sort_mru = true })
		end)

		vim.keymap.set('n', '<leader>fg', function()
			builtin.lsp_references()
		end)
		vim.keymap.set('n', '<leader>fv', builtin.live_grep, {})

		vim.keymap.set('n', '<leader>fs', builtin.tagstack, {})
	end
}
