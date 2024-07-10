require("WordLuc.remap")
require("WordLuc.OpenvsCode")
require("WordLuc.resize")
if vim.fn.has('win32') == 1 then
	vim.o.shell = 'powershell'
else
	vim.o.shell = 'pwsh'
end

EnvManage = {
	envs = {}
}
function EnvManage.isEnv(env)
	for i = 1, #EnvManage.envs do
		if EnvManage.envs[i] == env then
			return true
		end
	end
	return false
end
EnvEnum = {
	wki = "wki",
	go = "go",
	cs = "cs",
	conf = "",
}
local profiles = {}
profiles[EnvEnum.wki] = function() require("WordLuc.Profiles.wki") end
profiles[EnvEnum.go] = function() require("WordLuc.Profiles.go") end
profiles[EnvEnum.cs] = function() require("WordLuc.Profiles.CSharp") end
profiles[EnvEnum.conf] = function() end

local inputEnv = vim.fn.input("Enter env: ")
print("\n")

function EnvManage.addEnv(env)
	if EnvManage.isEnv(env) then
		return
	end
	print("Adding " .. env)
	if profiles[env] == nil then
		print("not a valid env")
		return
	end
	profiles[env]()
	table.insert(EnvManage.envs, env)
end


EnvManage.addEnv(inputEnv)
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
--vim.cmd("set noequalalways")
vim.g.netrw_sort_by = 'name'
vim.g.netrw_sort_direction = 'reverse'

--vim.opt.autoread = true
--vim.api.nvim_create_autocmd({"FocusGained","BufEnter"},{
--		pattern = { "*" },
--		callback = function()
--			vim.cmd("checktime")
--		end
--})
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.api.nvim_create_user_command('Sleep', function()
	require("WordLuc.madeInPlugin.GameOfLife.main")()
end ,{ bang = true, nargs = '*' })
