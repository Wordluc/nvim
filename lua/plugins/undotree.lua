return {
	'mbbill/undotree',
	config=function()
	vim.keymap.set('n', '<leader>r', vim.cmd.UndotreeToggle)	end
}
