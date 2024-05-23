local inputEnv = vim.fn.input("Enter env: ")
Env=nil
local profiles = {}
profiles[""] = function() end
profiles["wki"] = function() require("WordLuc.Profiles.wki") end
profiles["go"] = function() require("WordLuc.Profiles.go") end
--profiles["conf"] = function() end

if profiles[inputEnv] then
	print("\n")
	Env=inputEnv
	profiles[inputEnv]()
else
	print("\nNo profile found for " .. inputEnv)
end
