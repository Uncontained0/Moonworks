local Tokens = require("libs/luau_lex/tokens")

local Keywords = {
	["and"] = Tokens.And,
	["break"] = Tokens.Break,
	["continue"] = Tokens.Continue,
	["do"] = Tokens.Do,
	["else"] = Tokens.Else,
	["elseif"] = Tokens.Elseif,
	["end"] = Tokens.End,
	["false"] = Tokens.False,
	["for"] = Tokens.For,
	["function"] = Tokens.Function,
	["if"] = Tokens.If,
	["in"] = Tokens.In,
	["local"] = Tokens.Local,
	["nil"] = Tokens.Nil,
	["not"] = Tokens.Not,
	["or"] = Tokens.Or,
	["repeat"] = Tokens.Repeat,
	["return"] = Tokens.Return,
	["then"] = Tokens.Then,
	["true"] = Tokens.True,
	["until"] = Tokens.Until,
	["while"] = Tokens.While,
}

---@param type TokenType
---@param state State
---@return TokenPart
local function token_part(type, state, start)
	return {
		type = type,
		value = state:get_range(state:end_range(start)),
		range = state:end_range(start),
	}
end

---@param state LexerState
local function eat_whitespace(state)
	local has_newline = false

	state:eat_while(function(char)
		if has_newline then
			return false
		end

		if char == "\n" then
			has_newline = true
			return true
		end

		return char:find("%s")
	end)
end

---@param state LexerState
local function eat_decimal_number(state)
	local has_dot = false

	state:eat_while(function(char)
		if char == "." then
			if has_dot then
				return false
			else
				has_dot = true
				return true
			end
		end

		return char:find("[0-9]")
	end)
end

---@param state LexerState
local function eat_number(state)
	local first = state:first()

	if first == "0" then
		local second = state:peek(1):lower()

		if second == "x" then
			state:eat_while(function(char)
				return char:find("[0-9a-fA-F]")
			end)
		elseif second == "o" then
			state:eat_while(function(char)
				return char:find("[0-7]")
			end)
		elseif second == "b" then
			state:eat_while(function(char)
				return char:find("[01]")
			end)
		end
	end

	eat_decimal_number(state)
end

---@param state LexerState
local function eat_comment(state)
	state:bump()
	state:bump()

	if state:first() == "[" then
		state:bump()
		local equal_count = 0

		while state:first() == "=" do
			state:bump()
			equal_count = equal_count + 1
		end

		if state:first() == "[" then
			state:bump()

			local start_bracket = false
			local end_bracket = false
			local consecutive_equal_count = 0
			state:eat_while(function(char)
				if end_bracket then
					return false
				end

				if start_bracket then
					if char == "=" then
						consecutive_equal_count = consecutive_equal_count + 1
					else
						if char == "]" then
							if consecutive_equal_count == equal_count then
								end_bracket = true
								return true
							end
						end

						consecutive_equal_count = 0
					end
				end

				if char == "[" then
					start_bracket = true
				end

				return true
			end)
		end
	end

	state:eat_while(function(char)
		return char ~= "\n"
	end)
end

---@param state LexerState
local function eat_string(state)
	local first = state:first()

	if first == "[" then
		state:bump()
		local equal_count = 0

		while state:first() == "=" do
			state:bump()
			equal_count = equal_count + 1
		end

		if state:first() == "[" then
			state:bump()

			local start_bracket = false
			local end_bracket = false
			local consecutive_equal_count = 0
			state:eat_while(function(char)
				if end_bracket then
					return false
				end

				if start_bracket then
					if char == "=" then
						consecutive_equal_count = consecutive_equal_count + 1
					else
						if char == "]" then
							if consecutive_equal_count == equal_count then
								end_bracket = true
								return true
							end
						end

						consecutive_equal_count = 0
					end
				end

				if char == "[" then
					start_bracket = true
				end

				return true
			end)
		end
	else
		state:eat_while(function(char)
			return char ~= first and char ~= "\n"
		end)
	end
end

---@param state LexerState
---@return TokenPart
local function next_token(state)
	local start = state:start_range()
	local first = state:first()

	if first == nil then
		return {
			type = Tokens.Eof,
			value = "",
			range = state:end_range(start),
		}
	end

	if first:find("%s") then
		eat_whitespace(state)

		return token_part(Tokens.Whitespace, state, start)
	elseif first:find("[0-9]") then
		eat_number(state)

		return token_part(Tokens.Number, state, start)
	elseif first == "-" then
		local second = state:second()

		if second == "-" then
			eat_comment(state)

			return token_part(Tokens.Comment, state, start)
		elseif second == "=" then
			state:bump()
			state:bump()

			return token_part(Tokens.MinusEqual, state, start)
		elseif second == ">" then
			state:bump()
			state:bump()

			return token_part(Tokens.ThinArrow, state, start)
		else
			state:bump()

			return token_part(Tokens.Minus, state, start)
		end
	elseif first == "+" then
		local second = state:second()

		if second == "=" then
			state:bump()
			state:bump()

			return token_part(Tokens.PlusEqual, state, start)
		else
			state:bump()

			return token_part(Tokens.Plus, state, start)
		end
	elseif first == "*" then
		local second = state:second()

		if second == "=" then
			state:bump()
			state:bump()

			return token_part(Tokens.StarEqual, state, start)
		else
			state:bump()

			return token_part(Tokens.Star, state, start)
		end
	elseif first == "/" then
		local second = state:second()

		if second == "=" then
			state:bump()
			state:bump()

			return token_part(Tokens.SlashEqual, state, start)
		else
			state:bump()

			return token_part(Tokens.Slash, state, start)
		end
	elseif first == "%" then
		local second = state:second()

		if second == "=" then
			state:bump()
			state:bump()

			return token_part(Tokens.PercentEqual, state, start)
		else
			state:bump()

			return token_part(Tokens.Percent, state, start)
		end
	elseif first == "^" then
		local second = state:second()

		if second == "=" then
			state:bump()
			state:bump()

			return token_part(Tokens.CaretEqual, state, start)
		else
			state:bump()

			return token_part(Tokens.Caret, state, start)
		end
	elseif first == "." then
		local second = state:second()

		if second == "." then
			state:bump()
			state:bump()

			if state:first() == "=" then
				state:bump()

				return token_part(Tokens.DotDotEqual, state, start)
			elseif state:first() == "." then
				state:bump()

				return token_part(Tokens.DotDotDot, state, start)
			else
				return token_part(Tokens.DotDot, state, start)
			end
		else
			state:bump()

			return token_part(Tokens.Dot, state, start)
		end
	elseif first == "=" then
		local second = state:second()

		if second == "=" then
			state:bump()
			state:bump()

			return token_part(Tokens.EqualEqual, state, start)
		else
			state:bump()

			return token_part(Tokens.Equal, state, start)
		end
	elseif first == "&" then
		state:bump()

		return token_part(Tokens.Ampersand, state, start)
	elseif first == "|" then
		state:bump()

		return token_part(Tokens.Pipe, state, start)
	elseif first == "~" and state:second() == "=" then
		state:bump()
		state:bump()

		return token_part(Tokens.TildeEqual, state, start)
	elseif first == "<" then
		local second = state:second()

		if second == "=" then
			state:bump()
			state:bump()

			return token_part(Tokens.LessThenEqual, state, start)
		else
			state:bump()

			return token_part(Tokens.LessThen, state, start)
		end
	elseif first == ">" then
		local second = state:second()

		if second == "=" then
			state:bump()
			state:bump()

			return token_part(Tokens.GreaterThenEqual, state, start)
		else
			state:bump()

			return token_part(Tokens.GreaterThen, state, start)
		end
	elseif first == ":" then
		local second = state:second()

		if second == ":" then
			state:bump()
			state:bump()

			return token_part(Tokens.ColonColon, state, start)
		else
			state:bump()

			return token_part(Tokens.Colon, state, start)
		end
	elseif first == "," then
		state:bump()

		return token_part(Tokens.Comma, state, start)
	elseif first == ";" then
		state:bump()

		return token_part(Tokens.Semicolon, state, start)
	elseif first == "(" then
		state:bump()

		return token_part(Tokens.LeftParen, state, start)
	elseif first == ")" then
		state:bump()

		return token_part(Tokens.RightParen, state, start)
	elseif first == "{" then
		state:bump()

		return token_part(Tokens.LeftBrace, state, start)
	elseif first == "}" then
		state:bump()

		return token_part(Tokens.RightBrace, state, start)
	elseif first == "[" then
		local second = state:second()

		if second == "[" or second == "=" then
			eat_string(state)

			return token_part(Tokens.String, state, start)
		else
			state:bump()

			return token_part(Tokens.LeftBracket, state, start)
		end
	elseif first == "]" then
		state:bump()

		return token_part(Tokens.RightBracket, state, start)
	elseif first == "#" then
		state:bump()

		return token_part(Tokens.Hash, state, start)
	elseif first == "?" then
		state:bump()

		return token_part(Tokens.QuestionMark, state, start)
	elseif first == "\"" or first == "'" then
		eat_string(state)

		return token_part(Tokens.String, state, start)
	elseif first:find("[a-zA-Z_]") then
		state:eat_while(function(char)
			return char:find("[a-zA-Z0-9_]")
		end)

		local name = state:get_range(state:end_range(start))

		if Keywords[Name] then
			return token_part(Keywords[Name], state, start)
		else
			return token_part(Tokens.Identifier, state, start)
		end
	end
end

---@param state LexerState
---@return Token[]
local function lex(state)
	---@type Token[]
	local tokens = {}

	-- parse shebang
	if state:first() == "#" and state:second() == "!" then
		local start = state:start_range()

		state:eat_while(function(char)
			return char ~= "\n"
		end)

		state:bump()
		table.insert(tokens, {
			token = token_part(Tokens.Shebang, state, start),
			leading = {},
			trailing = {},
		})
	end

	while true do
		local token, leading_trivia, trailing_trivia = nil, {}, {}

		while true do
			token = next_token(state)

			if token.type == Tokens.Whitespace or token.type == Tokens.Comment then
				table.insert(leading_trivia, token)
			elseif token.type == Tokens.Eof then
				break
			else
				break
			end
		end

		while true do
			local start = state:start_range()
			local trailing_token = next_token(state)

			if trailing_token.type == Tokens.Whitespace or trailing_token.type == Tokens.Comment then
				table.insert(trailing_trivia, trailing_token)

				if trailing_token.value:find('\n') then
					break
				end
			else
				state:goto_start(start)
				break
			end
		end

		table.insert(tokens, {
			token = token,
			leading = leading_trivia,
			trailing = trailing_trivia,
		})

		if token.type == Tokens.Eof then
			break
		end
	end

	return tokens
end

return lex