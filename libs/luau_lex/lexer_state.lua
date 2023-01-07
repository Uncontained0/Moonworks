---@class LexerState
local LexerState = {}
LexerState.__index = LexerState

---@param code string
---@return LexerState
function LexerState.new(code)
	return setmetatable({
		code = code,
		pos = 1,
		line = 0,
	}, LexerState)
end

---@return string
function LexerState:first()
	return self.code:sub(self.pos, self.pos)
end

---@return string
function LexerState:second()
	return self.code:sub(self.pos + 1, self.pos + 1)
end

function LexerState:bump()
	if self:peek() == "\n" then
		self.line = self.line + 1
	end

	self.pos = self.pos + 1
end

---@param predicate fun(char: string): boolean
---@return string
function LexerState:eat_while(predicate)
	local start = self.pos

	while predicate(self:peek()) do
		self:bump()
	end

	return self.code:sub(start, self.pos - 1)
end

---@return Position
function LexerState:start_range()
	return { line = self.line, character = self.pos }
end

---@param start Position
---@return Range
function LexerState:end_range(start)
	return {
		start = start,
		["end"] = {
			line = self.line,
			character = self.pos,
		},
	}
end

---@param start Position
function LexerState:goto_start(start)
	self.line = start.line
	self.pos = start.character
end

---@param range Range
---@return string
function LexerState:get_range(range)
	return self.code:sub(range.start.character, range["end"].character)
end

return LexerState
