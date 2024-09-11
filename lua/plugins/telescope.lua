return {
	"Wordluc/telescope.nvim",
	dependencies = "tsakirist/telescope-lazy.nvim",
	config = function()
		local extra = {}
		local actions = require("telescope.actions")
		if EnvManage.isEnv(EnvEnum.wki) then
			extra = { "%.d.ts", "%.js", "%.css", "%.dgml", "%.csso", "%.csso.map", "%.jso.d.ts.map", "%.jso.map" }
		end
		require("telescope").setup {
			defaults = {
				path_display = {
					filename_first = {
						reverse_directories = true
					}
				},
				file_ignore_patterns = { "./^.git/*", "./node_modules/*", "node_modules", "^node_modules/*", "node_modules/*", unpack(extra) },
				mappings = {
					i={
						["<C-k>"] = "preview_scrolling_up",
						["<C-j>"] = "preview_scrolling_down",
						["<C-h>"] = "preview_scrolling_left",
						["<C-l>"] = "preview_scrolling_right",
						["<Down>"] = "move_selection_next",
						["<Up>"] = "move_selection_previous",
						["<c-w>"] = "move_selection_previous",
						["<c-s>"] = "move_selection_next",

					}
				}
			},
		}
		require("telescope").load_extension("lazy")
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

		vim.keymap.set('n', '<leader>fh', function()
			builtin.lsp_references()
		end)
		vim.keymap.set('n', '<leader>fv', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fg', builtin.git_status, {})
	end
}
