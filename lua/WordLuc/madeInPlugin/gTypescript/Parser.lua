local lexer = require("WordLuc.madeInPlugin.gTypescript.Lexer")
local function contains(table, value)
	for i = 1, #table do
		if table[i] == value then
			return true
		end
	end
	return false
end
local complexTypeKnow = {
	"List", "IEnumerable"
}
local visibility = { "public", "private", "protected" }
local optionalType = { ["true"] ="|null", ["false"] = ""}
local translationType = {
	int = "number",
	string = "string",
	bool = "boolean",
	float = "number"
}
local typeScriptparm = {
	type = nil,
	name = nil,
	optional = false
}


local function isAComplexType(l)
	local token = l:PeekCur()
	if token == nil then
		return false
	end
	if token.type == Token.Word then
		local nextType = l:PeekNext()
		if nextType ~= nil and nextType.type == Token.Lower then
			return true
		end
	end
	return false
end
local function parsingGenericType(l)
	local token = l:PeekCur()
	if token == nil then
		return token.value
	end
	local genericParm = {}
	local nextToken = l:Next()
	if nextToken.type == Token.Lower then
		l:Increment()
		while true do
			local t = l:PeekCur()
			if t == nil then
				return token.value
			end
			if t.type == Token.Word then
				genericParm[#genericParm + 1] = t.value
			end
			if t.type == Token.Greater then
				break
			end
			l:Increment()
		end
	end
	return token.value .. "<" .. table.concat(genericParm, ",") .. ">"
end
local function parsingType(l, res)
	local token = l:PeekCur()
	if isAComplexType(l) then
		if contains(complexTypeKnow, token.value) then
			l:Increment()
			token = l:Next()
			res.type = "[]" .. token.value
			l:Increment()
			return res
		else
			res.type = parsingGenericType(l)
			l:Increment()
			return res
		end
		res.type = token.value
		l:Increment()
		return res
	end
end
local function parsingParams(l, res)
	local token = l:PeekCur()
	if token == nil then
		return res
	end
	if (contains(visibility, token.value)) then
		l:Increment()
		return parsingParams(l, res)
	end
	if token.type == Token.Word then
		if (res.type == nil) then
			parsingType(l, res)
			parsingParams(l, res)
		elseif (res.name == nil) then
			res.name = token.value
			l:Increment()
			parsingParams(l, res)
		end
	end
	if token.type == Token.QuestionMark then
		res.optional = true
	end
	l:Increment()
	return parsingParams(l, res)
end
