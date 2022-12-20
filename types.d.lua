---@meta

---@alias Position { line: integer, character: integer }
---@alias Range { start: Position, end: Position }
---@alias TokenPart { range: Range, type: Tokens, value: string }
---@alias Token { token: TokenPart, leading: TokenPart[], trailing: TokenPart[] }