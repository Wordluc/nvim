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
			["<CR>"] = { "accept", "fallback" },
		},
		completion = {
			keyword = { range = 'full' },
			menu = {
				draw = {
					columns = {
						{ "kind_icon","kind",gap=2 },
						{ "label", "label_description", gap = 1 },
					},
				}
			},
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},
	}
}
