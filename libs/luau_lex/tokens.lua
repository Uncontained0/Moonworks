-- TODO: REDO LEXER

---@enum Tokens
return {
	EOF = 0,
	Whitespace = 1,
	Comment = 2,

	Identifier = 3,
	Keyword = 4,

	NumberLiteral = 5,
	StringLiteral = 6,

	OpenParen = 7,
	CloseParen = 8,
	OpenBrace = 9,
	CloseBrace = 10,
	OpenBracket = 11,
	CloseBracket = 12,

	Comma = 13,
	Dot = 14,
	Colon = 15,
	Semicolon = 16,

	Plus = 17,
	Minus = 18,
	Star = 19,
	Slash = 20,
	Percent = 21,
	Hash = 22,
	Caret = 23,

	Equals = 24,
	GreaterThan = 25,
	LessThan = 26,
	Tilde = 27,

	Ampersand = 28,
	Pipe = 29,
}