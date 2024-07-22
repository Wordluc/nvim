return function(string)
	local parms = {}
	for segment in string:gmatch("[ ]*([^ ]+)[ ]*") do
		local parts = { segment:match("(.*)=(.*)") }
		if #parts == 2 then
			parms[parts[1]] = parts[2]
		else
			local flag = { segment:match("(.*)") }
			if #flag == 1 then
				parms[flag[1]] = true
			else
				parms[flag[1]] = false
			end
		end
	end
	return parms
end
