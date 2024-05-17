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

function prova()
	return "prova"
end

vim.api.nvim_create_user_command('Build', function(opts)
	local dir = vim.fn.getcwd() .. "\\"
	vim.cmd("tabnew")
	vim.cmd("terminal msbuild " .. dir .. opts.args .. ".sln")
end, {
	bang = true,
	nargs = 1,
	complete = function()
		return {
			"GenyaAdv-TXD",
			"GenyaAdv-TAX",
			"GenyaAdv-ECO",
			"GenyaAdv-DEL",
			"GenyaAdv-BLL",
			"GenyaAdv-BKK",
			"GenyaAdv-ALL",
		}
	end,
})
