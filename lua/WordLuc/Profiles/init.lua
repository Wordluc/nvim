local env = vim.fn.input("Enter env: ")

local profiles = {}
profiles[""] = function() end
profiles["wki"] = function() require("WordLuc.Profiles.wki") end
profiles["go"] = function() require("WordLuc.Profiles.go") end


if profiles[env] then
	print("\n")
	profiles[env]()
else
	print("\nNo profile found for " .. env)
end
