require("WordLuc.remap")
require("WordLuc.OpenvsCode")
require("WordLuc.resize")
if vim.fn.has('win32') == 1 then
	vim.o.shell = 'powershell'
else
	vim.o.shell = 'pwsh'
end

vim.o.shellcmdflag =
'-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellquote = ''
vim.o.shellxquote = ''

vim.opt.incsearch = true
vim.opt.nu = true
vim.api.nvim_set_option('tabstop', 2)
vim.api.nvim_set_option('shiftwidth', 2)
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.scrolloff = 10
vim.g.netrw_sort_by = 'name'
vim.g.netrw_sort_direction = 'reverse'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.api.nvim_create_user_command('Sleep', function()
	require("WordLuc.madeInPlugin.GameOfLife.main")()
end ,{ bang = true, nargs = '*' })
