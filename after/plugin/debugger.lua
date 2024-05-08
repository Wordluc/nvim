local dap = require('dap')

vim.keymap.set('n', '<C-Right>', function() dap.continue() end)
vim.keymap.set('n', '<C-Up>', function() dap.step_over() end)
vim.keymap.set('n', '<C-Down>', function() dap.step_into() end)
vim.keymap.set('n', '<C-o>', function() dap.step_out() end)
vim.keymap.set('n', '<C-p>', function() dap.toggle_breakpoint() end)
--vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
--vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
--vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
--vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
	require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)

dap.adapters.delve = {
	type = 'server',
	port = '${port}',
	executable = {
		command = 'dlv',
		args = { 'dap', '-l', '127.0.0.1:${port}' },
		-- add this if on windows, otherwise server won't open successfully
		detached = false
	}
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}"
	},
}
dap.adapters.coreclr = {
	type = 'executable',
	command = '/usr/local/bin/netcoredbg/netcoredbg',
	args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
		end,
	},
}
