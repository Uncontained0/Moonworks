local nodes = require("libs/luau_ast/nodes")

---@class ParserState
local ParserState = {}
ParserState.__index = ParserState

---@param tokens Token[]
---@return ParserState
function ParserState.new(tokens)
	return setmetatable({
		tokens = tokens,
		pos = 1,
		loop_stack = {},
		function_stack = {},
	}, ParserState)
end

---@return Token
function ParserState:first()
	return self.tokens[self.pos]
end

---@return Token
function ParserState:second()
	return self.tokens[self.pos + 1]
end

function ParserState:bump()
	self.pos = self.pos + 1
end

---@param loop Repeat | While
function ParserState:push_loop(loop)
	table.insert(self.loop_stack, loop)
end

---@param func Function
function ParserState:push_function(func)
	table.insert(self.function_stack, func)
end

return ParserState