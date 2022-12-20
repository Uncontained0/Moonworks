---@class Cursor<T>
---@field private values T[]
---@field private pos integer
---@field private len integer
local Cursor = {}
Cursor.__index = Cursor

---@param values T[]
---@return Cursor<T>
function Cursor.new(values)
	return setmetatable({
		values = values,
		pos = 1,
		len = #values,
	}, Cursor)
end

function Cursor:bump()
	self.pos = self.pos + 1
end

---@return T? value
function Cursor:first()
	if self.pos > self.len then
		return nil
	end

	return self.values[self.pos]
end

---@return T? value
function Cursor:second()
	if self.pos + 1 > self.len then
		return nil
	end

	return self.values[self.pos + 1]
end

---@param predicate fun(value: T): boolean
---@return T[] values
function Cursor:eat_while(predicate)
	local start = self.pos

	while self.pos <= self.len and predicate(self:first()) do
		self:bump()
	end

	return table.pack(table.unpack(self.values, start, self.pos))
end

function Cursor:start_range()
	return self.pos
end

---@param start integer
---@return Range
function Cursor:end_range(start)
	return {
		start = start,
		["end"] = self.pos,
	}
end

function Cursor:get_state()
	return self.pos
end

---@param state integer
function Cursor:set_state(state)
	self.pos = state
end

return Cursor

