
EnvManage = {
	envs = {}
}
local profiles = {}
EnvEnum = {
	wki = "wki",
	go = "go",
	cs = "cs",
	conf = "",
}
profiles[EnvEnum.wki] = function() require("WordLuc.Profiles.forProjects.wki") end
profiles[EnvEnum.go] = function() require("WordLuc.Profiles.go") end
profiles[EnvEnum.cs] = function() require("WordLuc.Profiles.CSharp") end
profiles[EnvEnum.conf] = function() require("WordLuc.Profiles") end
function EnvManage.isEnv(env)
	for i = 1, #EnvManage.envs do
		if EnvManage.envs[i] == env then
			return true
		end
	end
	return false
end

function EnvManage.softAddEnv(env)
	if EnvManage.isEnv(env) then
		return
	end
	if profiles[env] == nil then
		print("not a valid env")
		return
	end
	table.insert(EnvManage.envs, env)
end

function EnvManage.addEnv(env)
	EnvManage.envs = {}
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

local inputEnv = vim.fn.input("Enter env: ")
EnvManage.softAddEnv(inputEnv)--TO allow packaging personalization
require("WordLuc.packer")
local cap = require('lspconfig').util.default_config.capabilities
Default_setup = function(server,opts)
	if opts == nil then
		opts = {}
	end
	opts.capabilities = cap
	require('lspconfig')[server].setup(opts)
end

print("\n")
EnvManage.addEnv(inputEnv)
require("WordLuc")
