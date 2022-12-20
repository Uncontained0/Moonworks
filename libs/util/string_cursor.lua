---@class StringCursor
---@field private str string
---@field private pos integer
---@field private len integer
local StringCursor = {}
StringCursor.__index = StringCursor

---@param str string
---@return StringCursor
function StringCursor.new(str)
	return setmetatable({
		str = str,
		pos = 1,
		len = #str,
	}, StringCursor)
end

function StringCursor:bump()
	self.pos = self.pos + 1
end

---@return string? char
function StringCursor:first()
	if self.pos > self.len then
		return nil
	end

	return self.str:sub(self.pos, self.pos)
end

---@return string? char
function StringCursor:second()
	if self.pos + 1 > self.len then
		return nil
	end

	return self.str:sub(self.pos + 1, self.pos + 1)
end

---@param predicate fun(char: string): boolean
---@return string chars
function StringCursor:eat_while(predicate)
	local start = self.pos

	while self.pos <= self.len and predicate(self:first()) do
		self:bump()
	end

	return self.str:sub(start, self.pos)
end

function StringCursor:start_range()
	return self.pos
end

---@param start integer
---@return Range
function StringCursor:end_range(start)
	return {
		start = start,
		["end"] = self.pos,
	}
end

function StringCursor:get_state()
	return self.pos
end

---@param state integer
function StringCursor:set_state(state)
	self.pos = state
end

return StringCursor