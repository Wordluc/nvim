return{
	'saghen/blink.cmp',
	dependencies = 'rafamadriz/friendly-snippets',
	build = "cargo build --release",

	opts = {
		keymap = {
			preset = 'default',
			['<Up>'] = { 'select_prev', 'fallback' },
			['<Down>'] = { 'select_next', 'fallback' },
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-j>'] = { 'select_next', 'fallback' },
			['<CR>']={
				function(cmp)
					if cmp.is_visible() then
						cmp.select_and_accept({index=1})
						return
					end
					vim.api.nvim_feedkeys('\n', 'n', true)
				end
				},
		},
		completion = {
			keyword = { range = 'full' },
			menu = {
				draw = {
					columns = {
						{ "kind" },
						{ "label", "label_description", gap = 1 },
					},
				}
			},
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},
	}
}
