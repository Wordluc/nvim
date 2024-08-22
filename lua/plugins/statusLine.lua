return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local colors = {
			bg       = '#202328',
			fg       = '#bbc2cf',
			yellow   = '#ECBE7B',
			cyan     = '#008080',
			darkblue = '#081633',
			green    = '#98be65',
			orange   = '#FF8800',
			violet   = '#a9a1e1',
			magenta  = '#c678dd',
			blue     = '#51afef',
			red      = '#ec5f67',
		}
		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = 'nord',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch' },
				lualine_c = {
					{
						'filename',
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 1,   -- 0: Just the filename
						symbols = {
							modified = '[+]', -- Text to show when the file is modified.
							readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
							unnamed = '[No Name]', -- Text to show for unnamed buffers.
							newfile = '[New]', -- Text to show for newly created file before first write
						}
					}
				},
				lualine_x = { 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = {
					{
						'diagnostics',
						sources = { 'nvim_diagnostic', 'coc' },
						sections = { 'error', 'warn', 'info', 'hint' },
						diagnostics_color = {
							error = 'DiagnosticError', -- Changes diagnostics' error color.
							warn  = 'DiagnosticWarn', -- Changes diagnostics' warn color.
							info  = 'DiagnosticInfo', -- Changes diagnostics' info color.
							hint  = 'DiagnosticHint', -- Changes diagnostics' hint color.
						},
					symbols = { error = ' ', warn = ' ', info = ' ' },
						colored = true, -- Displays diagnostics status in color if set to true.
						update_in_insert = true, -- Update diagnostics in insert mode.
						always_visible = false, -- Show diagnostics even if there are none.
					}
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		}
	end
}
