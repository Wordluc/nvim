local inputEnv = vim.fn.input("Enter env: ")
print("\n")
EnvManage = {
	envs = {}
}

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

function EnvManage.isEnv(env)
	for i = 1, #EnvManage.envs do
		if EnvManage.envs[i] == env then
			return true
		end
	end
	return false
end

EnvManage.addEnv(inputEnv)
