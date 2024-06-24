local M = {}
Token = {
	Word = 1,
	CircleBracketO = 2,
	CircleBracketC = 3,
	CurlyBracketO = 4,
	CurlyBracketC = 5,
	Assign = 6,
	Comma = 7,
	Semicolon = 8,
	Space = 9,
	QuestionMark = 10,
	ERROR = 0
}
Lexer = {
	index = 1,
	Tokens = {},
}

local function match(string)
	if string == "(" then
		return Token.CircleBracketO
	elseif string == ")" then
		return Token.CircleBracketC
	elseif string == "{" then
		return Token.CurlyBracketO
	elseif string == "}" then
		return Token.CurlyBracketC
	elseif string == "=" then
		return Token.Assign
	elseif string == "," then
		return Token.Comma
	elseif string == ";" then
		return Token.Semicolon
	elseif string == "?" then
		return Token.QuestionMark
	elseif string == " " then
		return Token.Space
	else
		if string:match("%a") then
			return Token.Word
		end
		return Token.ERROR
	end
end

function Tokenizing(str)
	local tokens = {}
	local preToken = {type=nil,value=""}
	for i = 1, #str do
		local c = str:sub(i, i)
		local t = match(c)
		if c == " " then
			if preToken.type ~= nil then
				table.insert(tokens, preToken)
			end
			preToken = {type=nil,value=""}
			goto continue
		end
		if t ~= Token.ERROR and preToken.type ~= nil and t ~= preToken.type then
			table.insert(tokens, preToken)
			preToken = {type=t,value=c}
		else
			preToken.value = preToken.value .. c
			preToken.type = t
		end
		::continue::
	end
	if preToken.type ~= nil then
		table.insert(tokens, preToken)
	end
	return tokens
end

function Lexer:New(str)
	self.Tokens = Tokenizing(str)
	self.index = 1
	return self
end

function Lexer:Next()
	if self.index >= #self.Tokens then
		return nil
	end
	self.index = self.index + 1
	return self.Tokens[self.index]
end

function Lexer:Increment()
	self.index = self.index + 1
end

function Lexer:PrePeek()
	if self.index <= 1 then
		return nil
	end
	return self.Tokens[self.index - 1]
end

function Lexer:Peek()
	if self.index >= #self.Tokens then
		return nil
	end
	return self.Tokens[self.index + 1]
end
function Lexer:PeekCur()
	print(self.index)
	return self.Tokens[self.index]
end
M.Lexer = Lexer
M.Token = Token
return M
