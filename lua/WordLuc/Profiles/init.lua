local inputEnv = vim.fn.input("Enter env: ")
Env={
cur=nil,
wki="wki",
go="go",
cs="cs",
conf="",
}
local profiles = {}
profiles[Env.wki] = function() require("WordLuc.Profiles.wki") end
profiles[Env.go] = function() require("WordLuc.Profiles.go") end
profiles[Env.cs] = function() require("WordLuc.Profiles.CSharp") end
profiles[Env.conf] = function() end

if profiles[inputEnv] then
	print("\n")
	Env.cur=inputEnv
	profiles[inputEnv]()
else
	print("\nNo profile found for " .. inputEnv)
end
