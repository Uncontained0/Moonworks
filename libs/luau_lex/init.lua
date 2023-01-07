local lexer_state = require("libs/luau_lex/lexer_state")
local lexer = require("libs/luau_lex/lexer")

---@param code string
local function lex(string)
	local state = lexer_state.new(code)

	return lexer(state)
end

return lex