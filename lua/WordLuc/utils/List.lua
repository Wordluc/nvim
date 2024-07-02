local List = {}
function List:Add(value)
	table.insert(self,value)
end

function List:Contains(value)
	for i = 1, self do
		if self[i] == value then
			return true
		end
	end
	return false
end

function List:Remove(value)
	for i = 1, self do
		if self[i] == value then
			table.remove(self,i)
		end
	end
end

return List
