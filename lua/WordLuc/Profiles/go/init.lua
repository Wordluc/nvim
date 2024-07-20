local utils = require("WordLuc.utils")
print("Welcome to go")

vim.api.nvim_create_user_command('Tests', function(v)
	local parms = utils.GetParms(v.args)
	local command = "!go test"
	if parms["v"] then
		command = command .. ' -v'
	end
	if parms["path"] ~= nil then
		command = command .. ' -run ' .. parms["path"]
	end
	command = command .. ' ./...'
	vim.cmd(command)
end, { bang = true, nargs = '*' })
Default_setup("gopls", {
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				parameterNames = true,
			},
		},
	}
})
