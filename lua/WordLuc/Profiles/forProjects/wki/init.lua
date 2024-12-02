EnvManage.addEnv(EnvEnum.cs)
print("Welcome to wki")

vim.api.nvim_create_user_command('IssSet', function()
	local dir = vim.fn.getcwd() .. "\\"
	vim.cmd("!" .. dir .. "SetIISPaths.cmd " .. dir)
end, { bang = true, nargs = '*' })

vim.api.nvim_create_user_command('NpmAut', function()
	local dir = vim.fn.getcwd() .. "\\"
	vim.cmd("!" .. dir .. "NpmAuth.cmd " .. dir)
end, { bang = true, nargs = '*' })

vim.api.nvim_create_user_command('NpmInstall', function()
	local dir = vim.fn.getcwd() .. "\\"
	vim.cmd("!" .. dir .. "InstallNodePackage.cmd " .. dir .. " -f")
end, { bang = true, nargs = '*' })

vim.api.nvim_create_user_command('Build', function(opts)
	local dir = vim.fn.getcwd() .. "\\"
	vim.cmd("tabnew")
	vim.cmd("terminal ./Run_MSBuild.cmd " .. dir .. opts.args)
end, {
	bang = true,
	nargs = 1,
	complete = function()
		return {
			"GenyaAdv-TXD.sln",
			"GenyaAdv-TAX.sln",
			"GenyaAdv-ECO.sln",
			"GenyaAdv-DEL.sln",
			"GenyaAdv-BLL.sln",
			"GenyaAdv-BKK.sln",
			"GenyaAdv.slnf",
		}
	end,
})
Default_setup("typescript-tools")
Default_setup("html")
Default_setup("cssls")
Default_setup("angularls")
