local lexer = require("WordLuc.madeInPlugin.gTypescript.Lexer")
local function contains(table, value)
	for i = 1, #table do
		if table[i] == value then
			return true
		end
	end
	return false
end
local visibility = { "public", "private", "protected" }
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
local Node = {
	type = "",
	translation = "",
}
local Parser = {}
local fparser = {
}
function Parser:Parse(string)
	local tokens = lexer.Lexer:New(string)
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
			res.type = token.value
			l:Increment()
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

function Parser:Parsing(l)

end
local l=Lexer:New("public string nome;")
local res=parsingParams(l, typeScriptparm)
print(res.optional)
