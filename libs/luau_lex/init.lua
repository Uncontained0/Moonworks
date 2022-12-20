local Tokens = require("libs/luau_lex/tokens")

local Keywords = {
	"and",
	"break",
	"do",
	"else",
	"elseif",
	"end",
	"export",
	"false",
	"for",
	"function",
	"if",
	"in",
	"local",
	"nil",
	"not",
	"or",
	"repeat",
	"return",
	"then",
	"true",
	"type",
	"until",
	"while",
}

---@param code StringCursor
---@return string
local function eat_whitespace(code)
	local has_newline = false

	return code:eat_while(function(char)
		if has_newline then
			return false
		end

		if char == "\n" then
			has_newline = true
			return true
		end

		return char:match("%s")
	end)
end

---@param code StringCursor
---@return string
local function eat_decimal(code)
	local has_dot = false

	return code:eat_while(function(char)
		if char == "." and not has_dot then
			has_dot = true
			return true
		else
			return char:match("[0-9]")
		end
	end)
end

---@param code StringCursor
---@return string
local function eat_number(code)
	local first = code:first()

	if first == "0" then
		local second = code:second():lower()

		if second == "b" then
			return code:eat_while(function(char)
				return char:match("[01]")
			end)
		elseif second == "o" then
			return code:eat_while(function(char)
				return char:match("[0-7]")
			end)
		elseif second == "x" then
			return code:eat_while(function(char)
				return char:match("[0-9a-fA-F]")
			end)
		else
			return eat_decimal(code)
		end
	else
		return eat_decimal(code)
	end
end

---@param code StringCursor
---@return string
local function eat_comment(code)
	code:bump()
	code:bump()

	local first = code:first()
	local second = code:second()

	if first == "[" and second == "[" then
		code:bump()
		code:bump()

		local brackets = 0

		return code:eat_while(function(char)
			if brackets == 2 then
				return false
			end

			if char == "]" then
				brackets = brackets + 1
				return true
			else
				brackets = 0
				return true
			end
		end)
	else
		return code:eat_while(function(char)
			return char ~= "\n"
		end)
	end
end

---@param code StringCursor
---@return TokenPart?
local function next_token_part(code)
	local start = code:start_range()
	local first = code:first()

	if first == nil then
		return {
			range = code:end_range(start),
			type = Tokens.EOF,
			value = "",
		}
	end

	if first:match("%s") then
		local value = eat_whitespace(code)

		return {
			range = code:end_range(start),
			type = Tokens.Whitespace,
			value = value,
		}
	elseif first:match("[0-9]") then
		local value = eat_number(code)

		return {
			range = code:end_range(start),
			type = Tokens.Number,
			value = value,
		}
	elseif first:match("[a-zA-Z_]") then
		local value = code:eat_while(function(char)
			return char:match("[a-zA-Z0-9_]")
		end)

		if table.find(Keywords, value) then
			return {
				range = code:end_range(start),
				type = Tokens.Keyword,
				value = value,
			}
		else
			return {
				range = code:end_range(start),
				type = Tokens.Identifier,
				value = value,
			}
		end
	elseif first == "-" then
		local second = code:second()

		if second == "-" then
			local value = eat_comment(code)

			return {
				range = code:end_range(start),
				type = Tokens.Comment,
				value = value,
			}
		else
			code:bump()

			return {
				range = code:end_range(start),
				type = Tokens.Minus,
				value = "-",
			}
		end
	elseif first == "+" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Plus,
			value = "+",
		}
	elseif first == "*" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Star,
			value = "*",
		}
	elseif first == "/" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Slash,
			value = "/",
		}
	elseif first == "%" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Percent,
			value = "%",
		}
	elseif first == "#" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Hash,
			value = "#",
		}
	elseif first == "=" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Equal,
			value = "=",
		}
	elseif first == "<" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.LessThan,
			value = "<",
		}
	elseif first == ">" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.GreaterThan,
			value = ">",
		}
	elseif first == "(" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.LeftParen,
			value = "(",
		}
	elseif first == ")" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.RightParen,
			value = ")",
		}
	elseif first == "{" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.LeftBrace,
			value = "{",
		}
	elseif first == "}" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.RightBrace,
			value = "}",
		}
	elseif first == "[" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.LeftBracket,
			value = "[",
		}
	elseif first == "]" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.RightBracket,
			value = "]",
		}
	elseif first == "," then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Comma,
			value = ",",
		}
	elseif first == "." then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Dot,
			value = ".",
		}
	elseif first == ":" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Colon,
			value = ":",
		}
	elseif first == ";" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Semicolon,
			value = ";",
		}
	elseif first == "|" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Pipe,
			value = "|",
		}
	elseif first == "&" then
		code:bump()

		return {
			range = code:end_range(start),
			type = Tokens.Ampersand,
			value = "&",
		}
	end
end

---@param code StringCursor
---@return Token[]
local function lex(code)
	---@type Token[]
	local tokens = {}

	while true do
		local leading_trivia = {}
		
		local token_part
		while true do
			token_part = next_token_part(code)

			if token_part.type == Tokens.Whitespace or token_part.type == Tokens.Comment then
				table.insert(leading_trivia, token_part)
			else
				break
			end
		end

		local trailing_trivia = {}
		while true do
			local state = code:get_state()
			local next_part = next_token_part(code)

			if next_part.type == Tokens.Whitespace or next_part.type == Tokens.Comment then
				table.insert(trailing_trivia, next_part)

				if next_part.value:match("\n") then
					break
				end
			else
				code:set_state(state)
				break
			end
		end

		table.insert(tokens, {
			token = token_part,
			leading_trivia = leading_trivia,
			trailing_trivia = trailing_trivia,
		})

		if token_part.type == Tokens.EndOfFile then
			break
		end
	end

	return tokens
end

return lex