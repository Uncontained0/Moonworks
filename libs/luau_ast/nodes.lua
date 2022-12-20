local nodes = {}

---@alias ContainedSpan { left: Token, right: Token, type: NodeType.ContainedSpan }

---@param left Token
---@param right Token
---@return ContainedSpan
function nodes.ContainedSpan(left, right)
	return {
		left = left,
		right = right,
		type = nodes.Types.ContainedSpan,
	}
end

---@class Pair_End<T>: { value: T, type: NodeType.Pair_End }

---@param value T
---@return Pair_End<T>
function nodes.Pair_End(value)
	return {
		value = value,
		type = nodes.Types.Pair_End,
	}
end

---@class Pair_Punctuated<T>: { value: T, punctuated: Token, type: NodeType.Pair_Punctuated }

---@param value T
---@param punctuated Token
---@return Pair_Punctuated<T>
function nodes.Pair_Punctuated(value, punctuated)
	return {
		value = value,
		punctuated = punctuated,
		type = nodes.Types.Pair_Punctuated,
	}
end

---@class Punctuated<T>: { values: Pair_Punctuated<T>[], last: Pair_End<T>, type: NodeType.Punctuated }

---@param values Pair_Punctuated<T>[]
---@param last Pair_End<T>
---@return Punctuated<T>
function nodes.Punctuated(values, last)
	return {
		values = values,
		last = last,
		type = nodes.Types.Punctuated,
	}
end

---@alias Block { stmts: Stmt[], last_stmt: LastStmt?, type: NodeType.Block }

---@param stmts Stmt[]
---@param last_stmt Last_Stmt?
---@return Block
function nodes.Block(stmts, last_stmt)
	return {
		stmts = stmts,
		last_stmt = last_stmt,
		type = nodes.Types.Block,
	}
end

---@alias LastStmt_Break { break: Token, type: NodeType.LastStmt_Break }

---@param break Token
---@return LastStmt_Break
function nodes.LastStmt_Break(break)
	return {
		break = break,
		type = nodes.Types.LastStmt_Break,
	}
end

---@alias LastStmt_Continue { continue: Token, type: NodeType.LastStmt_Continue }

---@param continue Token
---@return LastStmt_Continue
function nodes.LastStmt_Continue(continue)
	return {
		continue = continue,
		type = nodes.Types.LastStmt_Continue,
	}
end

---@alias LastStmt_Return { return: Token, returns: Punctuated<Expression>, type: NodeType.LastStmt_Return }

---@param return Token
---@param returns Punctuated<Expression>
---@return LastStmt_Return

function nodes.LastStmt_Return(return, returns)
	return {
		return = return,
		returns = returns,
		type = nodes.Types.LastStmt_Return,
	}
end

---@alias LastStmt LastStmt_Break | LastStmt_Continue | LastStmt_Return

---@alias Field_ExpressionKey { brackets: ContainedSpan, key: Expression, equal: Token, value: Expression, type: NodeType.Field_ExpressionKey }

---@param brackets ContainedSpan
---@param key Expression
---@param equal Token
---@param value Expression
---@return Field_ExpressionKey
function nodes.Field_ExpressionKey(brackets, key, equal, value)
	return {
		brackets = brackets,
		key = key,
		equal = equal,
		value = value,
		type = nodes.Types.Field_ExpressionKey,
	}
end

---@alias Field_NameKey { key: Token, equal: Token, value: Expression, type: NodeType.Field_NameKey }

---@param key Token
---@param equal Token
---@param value Expression
---@return Field_NameKey
function nodes.Field_NameKey(key, equal, value)
	return {
		key = key,
		equal = equal,
		value = value,
		type = nodes.Types.Field_NameKey,
	}
end

---@alias Field_NoKey { value: Expression, type: NodeType.Field_NoKey }

---@param value Expression
---@return Field_NoKey
function nodes.Field_NoKey(value)
	return {
		value = value,
		type = nodes.Types.Field_NoKey,
	}
end

---@alias Field Field_ExpressionKey | Field_NameKey | Field_NoKey

---@alias TableConstructor { braces: ContainedSpan, fields: Punctuated<Field>, type: NodeType.TableConstructor }

---@param braces ContainedSpan
---@param fields Punctuated<Field>
---@return TableConstructor
function nodes.TableConstructor(braces, fields)
	return {
		braces = braces,
		fields = fields,
		type = nodes.Types.TableConstructor,
	}
end

---@alias Expression_BinaryOperator { left: Expression, operator: BinOp, right: Expression, type: NodeType.Expression_BinaryOperator }

---@param left Expression
---@param operator BinOp
---@param right Expression
---@return Expression_BinaryOperator
function nodes.Expression_BinaryOperator(left, operator, right)
	return {
		left = left,
		operator = operator,
		right = right,
		type = nodes.Types.Expression_BinaryOperator,
	}
end

---@alias Expression_Parentheses { parentheses: ContainedSpan, expression: Expression, type: NodeType.Expression_Parentheses }

---@param parentheses ContainedSpan
---@param expression Expression
---@return Expression_Parentheses
function nodes.Expression_Parentheses(parentheses, expression)
	return {
		parentheses = parentheses,
		expression = expression,
		type = nodes.Types.Expression_Parentheses,
	}
end

---@alias Expression_UnaryOperator { operator: UnOp, expression: Expression, type: NodeType.Expression_UnaryOperator }

---@param operator UnOp
---@param expression Expression
---@return Expression_UnaryOperator
function nodes.Expression_UnaryOperator(operator, expression)
	return {
		operator = operator,
		expression = expression,
		type = nodes.Types.Expression_UnaryOperator,
	}
end

---@alias Expression_Value { value: Value, type_assertion: TypeAssertion?, type: NodeType.Expression_Value }

---@param value Value
---@param type_assertion TypeAssertion?
---@return Expression_Value
function nodes.Expression_Value(value, type_assertion)
	return {
		value = value,
		type_assertion = type_assertion,
		type = nodes.Types.Expression_Value,
	}
end

---@alias Expression Expression_BinaryOperator | Expression_Parentheses | Expression_UnaryOperator | Expression_Value

---@alias Value_Function { function_token: Token, body: FunctionBody, type: NodeType.Value_Function }

---@param function_token Token
---@param body FunctionBody
---@return Value_Function
function nodes.Value_Function(function_token, body)
	return {
		function_token = function_token,
		body = body,
		type = nodes.Types.Value_Function,
	}
end

---@alias Value_FunctionCall { value: FunctionCall, type: NodeType.Value_FunctionCall }

---@param value FunctionCall
---@return Value_FunctionCall
function nodes.Value_FunctionCall(value)
	return {
		value = value,
		type = nodes.Types.Value_FunctionCall,
	}
end

---@alias Value_IfExpression { value: IfExpression, type: NodeType.Value_IfExpression }

---@param value IfExpression
---@return Value_IfExpression
function nodes.Value_IfExpression(value)
	return {
		value = value,
		type = nodes.Types.Value_IfExpression,
	}
end

---@alias Value_TableConstruct { value: TableConstructor, type: NodeType.Value_TableConstruct }

---@param value TableConstructor
---@return Value_TableConstruct
function nodes.Value_TableConstruct(value)
	return {
		value = value,
		type = nodes.Types.Value_TableConstruct,
	}
end

---@alias Value_Number { value: Token, type: NodeType.Value_Number }

---@param value Token
---@return Value_Number
function nodes.Value_Number(value)
	return {
		value = value,
		type = nodes.Types.Value_Number,
	}
end

---@alias Value_ParenthesesExpression { value: Expression_Parentheses, type: NodeType.Value_Parentheses }

---@param value Expression_Parentheses
---@return Value_ParenthesesExpression
function nodes.Value_ParenthesesExpression(value)
	return {
		value = value,
		type = nodes.Types.Value_ParenthesesExpression,
	}
end

---@alias Value_String { value: Token, type: NodeType.Value_String }

---@param value Token
---@return Value_String
function nodes.Value_String(value)
	return {
		value = value,
		type = nodes.Types.Value_String,
	}
end

---@alias Value_Symbol { value: Token, type: NodeType.Value_Symbol }

---@param value Token
---@return Value_Symbol
function nodes.Value_Symbol(value)
	return {
		value = value,
		type = nodes.Types.Value_Symbol,
	}
end

---@alias Value_Var { value: Var, type: NodeType.Value_Var }

---@param value Var
---@return Value_Var
function nodes.Value_Var(value)
	return {
		value = value,
		type = nodes.Types.Value_Var,
	}
end

---@alias Value Value_Function | Value_FunctionCall | Value_IfExpression | Value_Number | Value_ParenthesesExpression | Value_String | Value_Symbol | Value_TableConstruct | Value_Var

---@alias Stmt_Assignment { value: Assignment, type: NodeType.Stmt_Assignment }

---@param value Assignment
---@return Stmt_Assignment
function nodes.Stmt_Assignment(value)
	return {
		value = value,
		type = nodes.Types.Stmt_Assignment,
	}
end

---@alias Stmt_Do { value: Do, type: NodeType.Stmt_Do }

---@param value Do
---@return Stmt_Do
function nodes.Stmt_Do(value)
	return {
		value = value,
		type = nodes.Types.Stmt_Do,
	}
end

---@alias Stmt_FunctionCall { value: FunctionCall, type: NodeType.Stmt_FunctionCall }

---@param value FunctionCall
---@return Stmt_FunctionCall
function nodes.Stmt_FunctionCall(value)
	return {
		value = value,
		type = nodes.Types.Stmt_FunctionCall,
	}
end

---@alias Stmt_FunctionDeclaration { value: FunctionDeclaration, type: NodeType.Stmt_FunctionDeclaration }

---@param value FunctionDeclaration
---@return Stmt_FunctionDeclaration
function nodes.Stmt_FunctionDeclaration(value)
	return {
		value = value,
		type = nodes.Types.Stmt_FunctionDeclaration,
	}
end

---@alias Stmt_GenericFor { value: GenericFor, type: NodeType.Stmt_GenericFor }

---@param value GenericFor
---@return Stmt_GenericFor
function nodes.Stmt_GenericFor(value)
	return {
		value = value,
		type = nodes.Types.Stmt_GenericFor,
	}
end

---@alias Stmt_If { value: If, type: NodeType.Stmt_If }

---@param value If
---@return Stmt_If
function nodes.Stmt_If(value)
	return {
		value = value,
		type = nodes.Types.Stmt_If,
	}
end

---@alias Stmt_LocalAssignment { value: LocalAssignment, type: NodeType.Stmt_LocalAssignment }

---@param value LocalAssignment
---@return Stmt_LocalAssignment
function nodes.Stmt_LocalAssignment(value)
	return {
		value = value,
		type = nodes.Types.Stmt_LocalAssignment,
	}
end

---@alias Stmt_LocalFunction { value: LocalFunction, type: NodeType.Stmt_LocalFunction }

---@param value LocalFunction
---@return Stmt_LocalFunction
function nodes.Stmt_LocalFunction(value)
	return {
		value = value,
		type = nodes.Types.Stmt_LocalFunction,
	}
end

---@alias Stmt_NumericFor { value: NumericFor, type: NodeType.Stmt_NumericFor }

---@param value NumericFor
---@return Stmt_NumericFor
function nodes.Stmt_NumericFor(value)
	return {
		value = value,
		type = nodes.Types.Stmt_NumericFor,
	}
end

---@alias Stmt_Repeat { value: Repeat, type: NodeType.Stmt_Repeat }

---@param value Repeat
---@return Stmt_Repeat
function nodes.Stmt_Repeat(value)
	return {
		value = value,
		type = nodes.Types.Stmt_Repeat,
	}
end

---@alias Stmt_While { value: While, type: NodeType.Stmt_While }

---@param value While
---@return Stmt_While
function nodes.Stmt_While(value)
	return {
		value = value,
		type = nodes.Types.Stmt_While,
	}
end

---@alias Stmt_CompoundAssignment { value: CompoundAssignment, type: NodeType.Stmt_CompoundAssignment }

---@param value CompoundAssignment
---@return Stmt_CompoundAssignment
function nodes.Stmt_CompoundAssignment(value)
	return {
		value = value,
		type = nodes.Types.Stmt_CompoundAssignment,
	}
end

---@alias Stmt_ExportedTypeDeclaration { value: ExportedTypeDeclaration, type: NodeType.Stmt_ExportedTypeDeclaration }

---@param value ExportedTypeDeclaration
---@return Stmt_ExportedTypeDeclaration
function nodes.Stmt_ExportedTypeDeclaration(value)
	return {
		value = value,
		type = nodes.Types.Stmt_ExportedTypeDeclaration,
	}
end

---@alias Stmt_TypeDeclaration { value: TypeDeclaration, type: NodeType.Stmt_TypeDeclaration }

---@param value TypeDeclaration
---@return Stmt_TypeDeclaration
function nodes.Stmt_TypeDeclaration(value)
	return {
		value = value,
		type = nodes.Types.Stmt_TypeDeclaration,
	}
end

---@alias Stmt Stmt_Assignment | Stmt_Do | Stmt_FunctionCall | Stmt_FunctionDeclaration | Stmt_GenericFor | Stmt_If | Stmt_LocalAssignment | Stmt_LocalFunction | Stmt_NumericFor | Stmt_Repeat | Stmt_While | Stmt_CompoundAssignment | Stmt_ExportedTypeDeclaration | Stmt_TypeDeclaration

---@alias Prefix_Expression { value: Expression, type: NodeType.Prefix_Expression }

---@param value Expression
---@return Prefix_Expression
function nodes.Prefix_Expression(value)
	return {
		value = value,
		type = nodes.Types.Prefix_Expression,
	}
end

---@alias Prefix_Name { value: Token, type: NodeType.Prefix_Name }

---@param value Token
---@return Prefix_Name
function nodes.Prefix_Name(value)
	return {
		value = value,
		type = nodes.Types.Prefix_Name,
	}
end

---@alias Prefix Prefix_Expression | Prefix_Name

---@alias Index_Brackets { brackets: ContainedSpan, expression: Expression, type: NodeType.Index_Brackets }

---@param brackets ContainedSpan
---@param expression Expression
---@return Index_Brackets
function nodes.Index_Brackets(brackets, expression)
	return {
		brackets = brackets,
		expression = expression,
		type = nodes.Types.Index_Brackets,
	}
end

---@alias Index_Dot { dot: Token, name: Token, type: NodeType.Index_Dot }

---@param dot Token
---@param name Token
---@return Index_Dot
function nodes.Index_Dot(dot, name)
	return {
		dot = dot,
		name = name,
		type = nodes.Types.Index_Dot,
	}
end

---@alias Index Index_Brackets | Index_Dot

---@alias FunctionArgs_Parentheses { parentheses: ContainedSpan, arguments: Punctuated<Expression>, type: NodeType.FunctionArgs_Parentheses }

---@param parentheses ContainedSpan
---@param arguments Punctuated<Expression>
---@return FunctionArgs_Parentheses
function nodes.FunctionArgs_Parentheses(parentheses, arguments)
	return {
		parentheses = parentheses,
		arguments = arguments,
		type = nodes.Types.FunctionArgs_Parentheses,
	}
end

---@alias FunctionArgs_TableConstructor { value: TableConstructor, type: NodeType.FunctionArgs_TableConstructor }

---@param value TableConstructor
---@return FunctionArgs_TableConstructor
function nodes.FunctionArgs_TableConstructor(value)
	return {
		value = value,
		type = nodes.Types.FunctionArgs_TableConstructor,
	}
end

---@alias FunctionArgs_String { value: Token, type: NodeType.FunctionArgs_String }

---@param value Token
---@return FunctionArgs_String
function nodes.FunctionArgs_String(value)
	return {
		value = value,
		type = nodes.Types.FunctionArgs_String,
	}
end

---@alias FunctionArgs FunctionArgs_Parentheses | FunctionArgs_TableConstructor | FunctionArgs_String

---@alias NumericFor { for_token: Token, index_variable: Token, equal_token: Token, start: Expression, start_end_comma: Token, end_expression: Expression, end_step_comma: Token?, step: Expression?, do_token: Token, block: Block, end_token: Token, type_specifier: TypeSpecifier?, type: NodeType.NumericFor }

---@param for_token Token
---@param index_variable Token
---@param equal_token Token
---@param start Expression
---@param start_end_comma Token
---@param end_expression Expression
---@param end_step_comma Token?
---@param step Expression?
---@param do_token Token
---@param block Block
---@param end_token Token
---@param type_specifier TypeSpecifier?
---@return NumericFor
function nodes.NumericFor(for_token, index_variable, equal_token, start, start_end_comma, end_expression, end_step_comma, step, do_token, block, end_token, type_specifier)
	return {
		for_token = for_token,
		index_variable = index_variable,
		equal_token = equal_token,
		start = start,
		start_end_comma = start_end_comma,
		end_expression = end_expression,
		end_step_comma = end_step_comma,
		step = step,
		do_token = do_token,
		block = block,
		end_token = end_token,
		type_specifier = type_specifier,
		type = nodes.Types.NumericFor,
	}
end

---@alias GenericFor { for_token: Token, names: Punctuated<Token>, in_token: Token, expr_list: Punctuated<Expression>, do_token: Token, block: Block, end_token: Token, type_specifiers: (TypeSpecifier?)[], type: NodeType.GenericFor }

---@param for_token Token
---@param names Punctuated<Token>
---@param in_token Token
---@param expr_list Punctuated<Expression>
---@param do_token Token
---@param block Block
---@param end_token Token
---@param type_specifiers (TypeSpecifier?)[]
---@return GenericFor
function nodes.GenericFor(for_token, names, in_token, expr_list, do_token, block, end_token, type_specifiers)
	return {
		for_token = for_token,
		names = names,
		in_token = in_token,
		expr_list = expr_list,
		do_token = do_token,
		block = block,
		end_token = end_token,
		type_specifiers = type_specifiers,
		type = nodes.Types.GenericFor,
	}
end

---@alias If { if_token: Token, condition: Expression, then_token: Token, block: Block, else_if: (ElseIf[])?, else_token: Token?, else_block: Block?, end_token: Token, type: NodeType.If }

---@param if_token Token
---@param condition Expression
---@param then_token Token
---@param block Block
---@param else_if (ElseIf[])?
---@param else_token Token?
---@param else_block Block?
---@param end_token Token
---@return If
function nodes.If(if_token, condition, then_token, block, else_if, else_token, else_block, end_token)
	return {
		if_token = if_token,
		condition = condition,
		then_token = then_token,
		block = block,
		else_if = else_if,
		else_token = else_token,
		else_block = else_block,
		end_token = end_token,
		type = nodes.Types.If,
	}
end

---@alias ElseIf { else_if_token: Token, condition: Expression, then_token: Token, block: Block, type: NodeType.ElseIf }

---@param else_if_token Token
---@param condition Expression
---@param then_token Token
---@param block Block
---@return ElseIf
function nodes.ElseIf(else_if_token, condition, then_token, block)
	return {
		else_if_token = else_if_token,
		condition = condition,
		then_token = then_token,
		block = block,
		type = nodes.Types.ElseIf,
	}
end

---@alias While { while_token: Token, condition: Expression, do_token: Token, block: Block, end_token: Token, type: NodeType.While }

---@param while_token Token
---@param condition Expression
---@param do_token Token
---@param block Block
---@param end_token Token
---@return While
function nodes.While(while_token, condition, do_token, block, end_token)
	return {
		while_token = while_token,
		condition = condition,
		do_token = do_token,
		block = block,
		end_token = end_token,
		type = nodes.Types.While,
	}
end

---@alias Repeat { repeat_token: Token, block: Block, until_token: Token, condition: Expression, type: NodeType.Repeat }

---@param repeat_token Token
---@param block Block
---@param until_token Token
---@param condition Expression
---@return Repeat
function nodes.Repeat(repeat_token, block, until_token, condition)
	return {
		repeat_token = repeat_token,
		block = block,
		until_token = until_token,
		condition = condition,
		type = nodes.Types.Repeat,
	}
end

---@alias MethodCall { colon_token: Token, name: Token, args: FunctionArgs, type: NodeType.MethodCall }

---@param colon_token Token
---@param name Token
---@param args FunctionArgs
---@return MethodCall
function nodes.MethodCall(colon_token, name, args)
	return {
		colon_token = colon_token,
		name = name,
		args = args,
		type = nodes.Types.MethodCall,
	}
end

---@alias Call_Anonymous { value: FunctionArgs, type: NodeType.Call_Anonymous }

---@param value FunctionArgs
---@return Call_Anonymous
function nodes.Call_Anonymous(value)
	return {
		value = value,
		type = nodes.Types.Call_Anonymous,
	}
end

---@alias Call_Method { value: MethodCall, type: NodeType.Call_Method }

---@param value MethodCall
---@return Call_Method
function nodes.Call_Method(value)
	return {
		value = value,
		type = nodes.Types.Call_Method,
	}
end

---@alias FunctionBody { generics: GenericDeclaration?, parameters_parentheses: ContainedSpan, parameters: Punctuated<Token>, type_specifiers: (TypeSpecifier?)[], return_type: TypeSpecifier?, block: Block, end_token: Token, type: NodeType.FunctionBody }

---@param generics GenericDeclaration?
---@param parameters_parentheses ContainedSpan
---@param parameters Punctuated<Parameter>
---@param type_specifiers (TypeSpecifier?)[]
---@param return_type TypeSpecifier?
---@param block Block
---@param end_token Token
---@return FunctionBody
function nodes.FunctionBody(generics, parameters_parentheses, parameters, type_specifiers, return_type, block, end_token)
	return {
		generics = generics,
		parameters_parentheses = parameters_parentheses,
		parameters = parameters,
		type_specifiers = type_specifiers,
		return_type = return_type,
		block = block,
		end_token = end_token,
		type = nodes.Types.FunctionBody,
	}
end

---@alias Suffix_Call { value: Call, type: NodeType.Suffix_Call }

---@param value Call
---@return Suffix_Call
function nodes.Suffix_Call(value)
	return {
		value = value,
		type = nodes.Types.Suffix_Call,
	}
end

---@alias Suffix_Index { value: Index, type: NodeType.Suffix_Index }

---@param value Index
---@return Suffix_Index
function nodes.Suffix_Index(value)
	return {
		value = value,
		type = nodes.Types.Suffix_Index,
	}
end

---@alias Suffix Suffix_Call | Suffix_Index

---@alias VarExpression { prefix: Prefix, suffixes: Suffix[], type: NodeType.VarExpression }

---@param prefix Prefix
---@param suffixes Suffix[]
---@return VarExpression
function nodes.VarExpression(prefix, suffixes)
	return {
		prefix = prefix,
		suffixes = suffixes,
		type = nodes.Types.VarExpression,
	}
end

---@alias Var_Expression { value: VarExpression, type: NodeType.Var }

---@param value VarExpression
---@return Var_Expression
function nodes.Var(value)
	return {
		value = value,
		type = nodes.Types.Var,
	}
end

---@alias Var_Name { value: Token, type: NodeType.Var_Name }

---@param value Token
---@return Var_Name
function nodes.Var_Name(value)
	return {
		value = value,
		type = nodes.Types.Var_Name,
	}
end

---@alias Var Var_Expression | Var_Name

---@alias Assignment { var_list: Punctuated<Var>, equal_token: Token, expr_list: Punctuated<Expression>, type: NodeType.Assignment }

---@param var_list Punctuated<Var>
---@param equal_token Token
---@param expr_list Punctuated<Expression>
---@return Assignment
function nodes.Assignment(var_list, equal_token, expr_list)
	return {
		var_list = var_list,
		equal_token = equal_token,
		expr_list = expr_list,
		type = nodes.Types.Assignment,
	}
end

---@alias LocalFunction { local_token: Token, function_token: Token, name: Token, body: FunctionBody, type: NodeType.LocalFunction }

---@param local_token Token
---@param function_token Token
---@param name Token
---@param body FunctionBody
---@return LocalFunction
function nodes.LocalFunction(local_token, function_token, name, body)
	return {
		local_token = local_token,
		function_token = function_token,
		name = name,
		body = body,
		type = nodes.Types.LocalFunction,
	}
end

---@alias LocalAssignment { local_token: Token, type_specifiers: (TypeSpecifier?)[], name_list: Punctuated<Token>, equal_token: Token, expr_list: Punctuated<Expression>, type: NodeType.LocalAssignment }

---@param local_token Token
---@param type_specifiers (TypeSpecifier?)[]
---@param name_list Punctuated<Token>
---@param equal_token Token
---@param expr_list Punctuated<Expression>
---@return LocalAssignment
function nodes.LocalAssignment(local_token, type_specifiers, name_list, equal_token, expr_list)
	return {
		local_token = local_token,
		type_specifiers = type_specifiers,
		name_list = name_list,
		equal_token = equal_token,
		expr_list = expr_list,
		type = nodes.Types.LocalAssignment,
	}
end

---@alias Do { do_token: Token, block: Block, end_token: Token, type: NodeType.Do }

---@param do_token Token
---@param block Block
---@param end_token Token
---@return Do
function nodes.Do(do_token, block, end_token)
	return {
		do_token = do_token,
		block = block,
		end_token = end_token,
		type = nodes.Types.Do,
	}
end

---@alias FunctionCall { prefix: Prefix, suffixes: Suffix[], type: NodeType.FunctionCall }

---@param prefix Prefix
---@param suffixes Suffix[]
---@return FunctionCall
function nodes.FunctionCall(prefix, suffixes)
	return {
		prefix = prefix,
		suffixes = suffixes,
		type = nodes.Types.FunctionCall,
	}
end

---@alias FunctionName { names: Punctuated<Token>, colon: Token, colon_name: Token }

---@param names Punctuated<Token>
---@param colon Token
---@param colon_name Token
---@return FunctionName
function nodes.FunctionName(names, colon, colon_name)
	return {
		names = names,
		colon = colon,
		colon_name = colon_name,
	}
end

---@alias FunctionDeclaration { function_token: Token, name: FunctionName, body: FunctionBody, type: NodeType.FunctionDeclaration }

---@param function_token Token
---@param name FunctionName
---@param body FunctionBody
---@return FunctionDeclaration
function nodes.FunctionDeclaration(function_token, name, body)
	return {
		function_token = function_token,
		name = name,
		body = body,
		type = nodes.Types.FunctionDeclaration,
	}
end

---@alias BinOp_And { value: Token, type: NodeType.BinOp_And }
---@alias BinOp_Caret { value: Token, type: NodeType.BinOp_Caret }
---@alias BinOp_GreaterThan { value: Token, type: NodeType.BinOp_GreaterThan }
---@alias BinOp_GreaterThanEqual { value: Token, type: NodeType.BinOp_GreaterThanEqual }
---@alias BinOp_LessThan { value: Token, type: NodeType.BinOp_LessThan }
---@alias BinOp_LessThanEqual { value: Token, type: NodeType.BinOp_LessThanEqual }
---@alias BinOp_Minus { value: Token, type: NodeType.BinOp_Minus }
---@alias BinOp_Or { value: Token, type: NodeType.BinOp_Or }
---@alias BinOp_Percent { value: Token, type: NodeType.BinOp_Percent }
---@alias BinOp_Plus { value: Token, type: NodeType.BinOp_Plus }
---@alias BinOp_Slash { value: Token, type: NodeType.BinOp_Slash }
---@alias BinOp_Star { value: Token, type: NodeType.BinOp_Star }
---@alias BinOp_TildeEqual { value: Token, type: NodeType.BinOp_TildeEqual }
---@alias BinOp_TwoDots { value: Token, type: NodeType.BinOp_TwoDots }
---@alias BinOp_TwoEqual { value: Token, type: NodeType.BinOp_TwoEqual }

---@alias BinOp BinOp_And | BinOp_Caret | BinOp_GreaterThan | BinOp_GreaterThanEqual | BinOp_LessThan | BinOp_LessThanEqual | BinOp_Minus | BinOp_Or | BinOp_Percent | BinOp_Plus | BinOp_Slash | BinOp_Star | BinOp_TildeEqual | BinOp_TwoDots | BinOp_TwoEqual

---@param value Token
---@param type NodeType.BinOp_And | NodeType.BinOp_Caret | NodeType.BinOp_GreaterThan | NodeType.BinOp_GreaterThanEqual | NodeType.BinOp_LessThan | NodeType.BinOp_LessThanEqual | NodeType.BinOp_Minus | NodeType.BinOp_Or | NodeType.BinOp_Percent | NodeType.BinOp_Plus | NodeType.BinOp_Slash | NodeType.BinOp_Star | NodeType.BinOp_TildeEqual | NodeType.BinOp_TwoDots | NodeType.BinOp_TwoEqual
---@return BinOp
function nodes.BinOp(value, type)
	return {
		value = value,
		type = type,
	}
end

---@alias UnOp_Minus { value: Token, type: NodeType.UnOp_Minus }
---@alias UnOp_Not { value: Token, type: NodeType.UnOp_Not }
---@alias UnOp_Hash { value: Token, type: NodeType.UnOp_Hash }

---@alias UnOp UnOp_Minus | UnOp_Not | UnOp_Hash

---@param value Token
---@param type NodeType.UnOp_Minus | NodeType.UnOp_Not | NodeType.UnOp_Hash
---@return UnOp
function nodes.UnOp(value, type)
	return {
		value = value,
		type = type,
	}
end

---@alias TypeInfo_Array { braces: ContainedSpan, type_info: TypeInfo, type: NodeType.TypeInfo_Array }

---@param braces ContainedSpan
---@param type_info TypeInfo
---@return TypeInfo_Array
function nodes.TypeInfo_Array(braces, type_info)
	return {
		braces = braces,
		type_info = type_info,
		type = nodes.Types.TypeInfo_Array,
	}
end

---@alias TypeInfo_Basic { value: Token, type: NodeType.TypeInfo_Basic }

---@param value Token
---@return TypeInfo_Basic
function nodes.TypeInfo_Basic(value)
	return {
		value = value,
		type = nodes.Types.TypeInfo_Basic,
	}
end

---@alias TypeInfo_String { value: Token, type: NodeType.TypeInfo_String }

---@param value Token
---@return TypeInfo_String
function nodes.TypeInfo_String(value)
	return {
		value = value,
		type = nodes.Types.TypeInfo_String,
	}
end

---@alias TypeInfo_Boolean { value: Token, type: NodeType.TypeInfo_Boolean }

---@param value Token
---@return TypeInfo_Boolean
function nodes.TypeInfo_Boolean(value)
	return {
		value = value,
		type = nodes.Types.TypeInfo_Boolean,
	}
end

---@alias TypeInfo_Callback { generics: GenericDeclaration?, parentheses: ContainedSpan, arguments: Punctuated<TypeArgument>, arrow: Token, return_type: TypeInfo, type: NodeType.TypeInfo_Callback }

---@param generics GenericDeclaration?
---@param parentheses ContainedSpan
---@param arguments Punctuated<TypeArgument>
---@param arrow Token
---@param return_type TypeInfo
---@return TypeInfo_Callback
function nodes.TypeInfo_Callback(generics, parentheses, arguments, arrow, return_type)
	return {
		generics = generics,
		parentheses = parentheses,
		arguments = arguments,
		arrow = arrow,
		return_type = return_type,
		type = nodes.Types.TypeInfo_Callback,
	}
end

---@alias TypeInfo_Generic { base: Token, arrows: ContainedSpan, generics: Punctuated<TypeInfo>, type: NodeType.TypeInfo_Generic }

---@param base Token
---@param arrows ContainedSpan
---@param generics Punctuated<TypeInfo>
---@return TypeInfo_Generic
function nodes.TypeInfo_Generic(base, arrows, generics)
	return {
		base = base,
		arrows = arrows,
		generics = generics,
		type = nodes.Types.TypeInfo_Generic,
	}
end

---@alias TypeInfo_GenericPack { name: Token, ellipse: Token, type: NodeType.TypeInfo_GenericPack }

---@param name Token
---@param ellipse Token
---@return TypeInfo_GenericPack
function nodes.TypeInfo_GenericPack(name, ellipse)
	return {
		name = name,
		ellipse = ellipse,
		type = nodes.Types.TypeInfo_GenericPack,
	}
end

---@alias TypeInfo_Intersection { left: TypeInfo, ampersand: Token, right: TypeInfo, type: NodeType.TypeInfo_Intersection }

---@param left TypeInfo
---@param ampersand Token
---@param right TypeInfo
---@return TypeInfo_Intersection
function nodes.TypeInfo_Intersection(left, ampersand, right)
	return {
		left = left,
		ampersand = ampersand,
		right = right,
		type = nodes.Types.TypeInfo_Intersection,
	}
end

---@alias TypeInfo_Module { module: Token, punctuation: Token, type_info: IndexedTypeInfo, type: NodeType.TypeInfo_Module }

---@param module Token
---@param punctuation Token
---@param type_info IndexedTypeInfo
---@return TypeInfo_Module
function nodes.TypeInfo_Module(module, punctuation, type_info)
	return {
		module = module,
		punctuation = punctuation,
		type_info = type_info,
		type = nodes.Types.TypeInfo_Module,
	}
end

---@alias TypeInfo_Optional { base: TypeInfo, question_mark: Token, type: NodeType.TypeInfo_Optional }

---@param base TypeInfo
---@param question_mark Token
---@return TypeInfo_Optional
function nodes.TypeInfo_Optional(base, question_mark)
	return {
		base = base,
		question_mark = question_mark,
		type = nodes.Types.TypeInfo_Optional,
	}
end

---@alias TypeInfo_Table { braces: ContainedSpan, fields: Punctuated<TypeField>, type: NodeType.TypeInfo_Table }

---@param braces ContainedSpan
---@param fields Punctuated<TypeField>
---@return TypeInfo_Table
function nodes.TypeInfo_Table(braces, fields)
	return {
		braces = braces,
		fields = fields,
		type = nodes.Types.TypeInfo_Table,
	}
end

---@alias TypeInfo_Typeof { typeof_token: Token, parentheses: ContainedSpan, inner: Expression, type: NodeType.TypeInfo_Typeof }

---@param typeof_token Token
---@param parentheses ContainedSpan
---@param inner Expression
---@return TypeInfo_Typeof
function nodes.TypeInfo_Typeof(typeof_token, parentheses, inner)
	return {
		typeof_token = typeof_token,
		parentheses = parentheses,
		inner = inner,
		type = nodes.Types.TypeInfo_Typeof,
	}
end

---@alias TypeInfo_Tuple { parentheses: ContainedSpan, types: Punctuated<TypeInfo>, type: NodeType.TypeInfo_Tuple }

---@param parentheses ContainedSpan
---@param types Punctuated<TypeInfo>
---@return TypeInfo_Tuple
function nodes.TypeInfo_Tuple(parentheses, types)
	return {
		parentheses = parentheses,
		types = types,
		type = nodes.Types.TypeInfo_Tuple,
	}
end

---@alias TypeInfo_Union { left: TypeInfo, pipe: Token, right: TypeInfo, type: NodeType.TypeInfo_Union }

---@param left TypeInfo
---@param pipe Token
---@param right TypeInfo
---@return TypeInfo_Union
function nodes.TypeInfo_Union(left, pipe, right)
	return {
		left = left,
		pipe = pipe,
		right = right,
		type = nodes.Types.TypeInfo_Union,
	}
end

---@alias TypeInfo_Variadic { ellipse: Token, type_info: TypeInfo, type: NodeType.TypeInfo_Variadic }

---@param ellipse Token
---@param type_info TypeInfo
---@return TypeInfo_Variadic
function nodes.TypeInfo_Variadic(ellipse, type_info)
	return {
		ellipse = ellipse,
		type_info = type_info,
		type = nodes.Types.TypeInfo_Variadic,
	}
end

---@alias TypeInfo_VariadicPack { ellipse: Token, name: Token, type: NodeType.TypeInfo_VariadicPack }

---@param ellipse Token
---@param name Token
---@return TypeInfo_VariadicPack
function nodes.TypeInfo_VariadicPack(ellipse, name)
	return {
		ellipse = ellipse,
		name = name,
		type = nodes.Types.TypeInfo_VariadicPack,
	}
end

---@alias TypeInfo TypeInfo_Array | TypeInfo_Basic | TypeInfo_Function | TypeInfo_Generic | TypeInfo_GenericPack | TypeInfo_Intersection | TypeInfo_Module | TypeInfo_Optional | TypeInfo_Table | TypeInfo_Typeof | TypeInfo_Tuple | TypeInfo_Union | TypeInfo_Variadic | TypeInfo_VariadicPack

---@alias IndexedTypeInfo_Basic { value: Token, type: NodeType.IndexedTypeInfo_Basic }

---@param value Token
---@return IndexedTypeInfo_Basic
function nodes.IndexedTypeInfo_Basic(value)
	return {
		value = value,
		type = nodes.Types.IndexedTypeInfo_Basic,
	}
end

---@alias IndexedTypeInfo_Generic { base: Token, arrow_line: Token, arrow_head: Token, generics: Punctuated<TypeInfo>, type: NodeType.IndexedTypeInfo_Generic }

---@param base Token
---@param arrow_line Token
---@param arrow_head Token
---@param generics Punctuated<TypeInfo>
---@return IndexedTypeInfo_Generic
function nodes.IndexedTypeInfo_Generic(base, arrow_line, arrow_head, generics)
	return {
		base = base,
		arrow_line = arrow_line,
		arrow_head = arrow_head,
		generics = generics,
		type = nodes.Types.IndexedTypeInfo_Generic,
	}
end

---@alias IndexedTypeInfo IndexedTypeInfo_Basic | IndexedTypeInfo_Generic

---@alias TypeField { key: TypeFieldKey, colon: Token, value: TypeInfo, type: NodeType.TypeField }

---@param key TypeFieldKey
---@param colon Token
---@param value TypeInfo
---@return TypeField
function nodes.TypeField(key, colon, value)
	return {
		key = key,
		colon = colon,
		value = value,
		type = nodes.Types.TypeField,
	}
end

---@alias TypeFieldKey_Name { value: Token, type: NodeType.TypeFieldKey_Name }

---@param value Token
---@return TypeFieldKey_Name
function nodes.TypeFieldKey_Name(value)
	return {
		value = value,
		type = nodes.Types.TypeFieldKey_Name,
	}
end

---@alias TypeFieldKey_IndexSignature { brackets: ContainedSpan, inner: TypeInfo, type: NodeType.TypeFieldKey_IndexSignature }

---@param brackets ContainedSpan
---@param inner TypeInfo
---@return TypeFieldKey_IndexSignature
function nodes.TypeFieldKey_IndexSignature(brackets, inner)
	return {
		brackets = brackets,
		inner = inner,
		type = nodes.Types.TypeFieldKey_IndexSignature,
	}
end

---@alias TypeFieldKey TypeFieldKey_Name | TypeFieldKey_IndexSignature

---@alias TypeAssertion { assertion_op: Token, cast_to: TypeInfo, type: NodeType.TypeAssertion }

---@param assertion_op Token
---@param cast_to TypeInfo
---@return TypeAssertion
function nodes.TypeAssertion(assertion_op, cast_to)
	return {
		assertion_op = assertion_op,
		cast_to = cast_to,
		type = nodes.Types.TypeAssertion,
	}
end

---@alias TypeDeclaration { type_token: Token, base: Token, generics: GenericDeclaration?, equal_token: Token, declare_as: TypeInfo, type: NodeType.TypeDeclaration }

---@param type_token Token
---@param base Token
---@param generics GenericDeclaration?
---@param equal_token Token
---@param declare_as TypeInfo
---@return TypeDeclaration
function nodes.TypeDeclaration(type_token, base, generics, equal_token, declare_as)
	return {
		type_token = type_token,
		base = base,
		generics = generics,
		equal_token = equal_token,
		declare_as = declare_as,
		type = nodes.Types.TypeDeclaration,
	}
end

---@alias GenericParameterInfo_Name { value: Token, type: NodeType.GenericParameterInfo_Name }

---@param value Token
---@return GenericParameterInfo_Name
function nodes.GenericParameterInfo_Name(value)
	return {
		value = value,
		type = nodes.Types.GenericParameterInfo_Name,
	}
end

---@alias GenericParameterInfo_Variadic { name: Token, ellipse: Token, type: NodeType.GenericParameterInfo_Variadic }

---@param name Token
---@param ellipse Token
---@return GenericParameterInfo_Variadic
function nodes.GenericParameterInfo_Variadic(name, ellipse)
	return {
		name = name,
		ellipse = ellipse,
		type = nodes.Types.GenericParameterInfo_Variadic,
	}
end

---@alias GenericParameterInfo GenericParameterInfo_Name | GenericParameterInfo_Variadic

---@alias GenericDeclarationParameter { parameter: GenericParameterInfo, default_colon: Token?, default: TypeInfo?, type: NodeType.GenericDeclarationParameter }

---@param parameter GenericParameterInfo
---@param default_colon Token?
---@param default TypeInfo?
---@return GenericDeclarationParameter
function nodes.GenericDeclarationParameter(parameter, default_colon, default)
	return {
		parameter = parameter,
		default_colon = default_colon,
		default = default,
		type = nodes.Types.GenericDeclarationParameter,
	}
end

---@alias GenericDeclaration { arrows: ContainedSpan, generics: Punctuated<GenericDeclarationParameter>, type: NodeType.GenericDeclaration }

---@param arrows ContainedSpan
---@param generics Punctuated<GenericDeclarationParameter>
---@return GenericDeclaration
function nodes.GenericDeclaration(arrows, generics)
	return {
		arrows = arrows,
		generics = generics,
		type = nodes.Types.GenericDeclaration,
	}
end

---@alias TypeSpecifier { punctuation: Token, type_info: TypeInfo, type: NodeType.TypeSpecifier }

---@param punctuation Token
---@param type_info TypeInfo
---@return TypeSpecifier
function nodes.TypeSpecifier(punctuation, type_info)
	return {
		punctuation = punctuation,
		type_info = type_info,
		type = nodes.Types.TypeSpecifier,
	}
end

---@alias TypeArgument { name: Token?, colon: Token?, type_info: TypeInfo, type: NodeType.TypeArgument }

---@param name Token?
---@param colon Token?
---@param type_info TypeInfo
---@return TypeArgument
function nodes.TypeArgument(name, colon, type_info)
	return {
		name = name,
		colon = colon,
		type_info = type_info,
		type = nodes.Types.TypeArgument,
	}
end

---@alias ExportedTypeDeclaration { export_token: Token, type_declaration: TypeDeclaration, type: NodeType.ExportedTypeDeclaration }

---@param export_token Token
---@param type_declaration TypeDeclaration
---@return ExportedTypeDeclaration
function nodes.ExportedTypeDeclaration(export_token, type_declaration)
	return {
		export_token = export_token,
		type_declaration = type_declaration,
		type = nodes.Types.ExportedTypeDeclaration,
	}
end

---@alias CompoundOp_PlusEqual { value: Token, type: NodeType.CompoundOp_PlusEqual }
---@alias CompoundOp_MinusEqual { value: Token, type: NodeType.CompoundOp_MinusEqual }
---@alias CompoundOp_StarEqual { value: Token, type: NodeType.CompoundOp_StarEqual }
---@alias CompoundOp_SlashEqual { value: Token, type: NodeType.CompoundOp_SlashEqual }
---@alias CompoundOp_PercentEqual { value: Token, type: NodeType.CompoundOp_PercentEqual }
---@alias CompoundOp_CaretEqual { value: Token, type: NodeType.CompoundOp_CaretEqual }
---@alias CompoundOp_TwoDotsEqual { value: Token, type: NodeType.CompoundOp_TwoDotsEqual }

---@alias CompoundOp CompoundOp_PlusEqual | CompoundOp_MinusEqual | CompoundOp_StarEqual | CompoundOp_SlashEqual | CompoundOp_PercentEqual | CompoundOp_CaretEqual | CompoundOp_TwoDotsEqual

---@param value Token
---@param type NodeType.CompoundOp_PlusEqual | NodeType.CompoundOp_MinusEqual | NodeType.CompoundOp_StarEqual | NodeType.CompoundOp_SlashEqual | NodeType.CompoundOp_PercentEqual | NodeType.CompoundOp_CaretEqual | NodeType.CompoundOp_TwoDotsEqual
---@return CompoundOp
function nodes.CompoundOp(value, type)
	return {
		value = value,
		type = type,
	}
end

---@alias CompoundAssignment { left: Var, compound_operator: CompoundOp, right: Expression, type: NodeType.CompoundAssignment }

---@param left Var
---@param compound_operator CompoundOp
---@param right Expression
---@return CompoundAssignment
function nodes.CompoundAssignment(left, compound_operator, right)
	return {
		left = left,
		compound_operator = compound_operator,
		right = right,
		type = nodes.Types.CompoundAssignment,
	}
end

---@alias IfExpression { if_token: Token, condition: Expression, then_token: Token, if_expression: Expression, else_if_expressions: (ElseIfExpression[])?, else_token: Token, else_expression: Expression, type: NodeType.IfExpression }

---@param if_token Token
---@param condition Expression
---@param then_token Token
---@param if_expression Expression
---@param else_if_expressions (ElseIfExpression[])?
---@param else_token Token
---@param else_expression Expression
---@return IfExpression
function nodes.IfExpression(if_token, condition, then_token, if_expression, else_if_expressions, else_token, else_expression)
	return {
		if_token = if_token,
		condition = condition,
		then_token = then_token,
		if_expression = if_expression,
		else_if_expressions = else_if_expressions,
		else_token = else_token,
		else_expression = else_expression,
		type = nodes.Types.IfExpression,
	}
end

---@alias ElseIfExpression { else_if_token: Token, condition: Expression, then_token: Token, expression: Expression, type: NodeType.ElseIfExpression }

---@param else_if_token Token
---@param condition Expression
---@param then_token Token
---@param expression Expression
---@return ElseIfExpression
function nodes.ElseIfExpression(else_if_token, condition, then_token, expression)
	return {
		else_if_token = else_if_token,
		condition = condition,
		then_token = then_token,
		expression = expression,
		type = nodes.Types.ElseIfExpression,
	}
end

---@enum NodeType
nodes.Types = {
	ContainedSpan = 0,

	Pair_End = 1,
	Pair_Punctuated = 2,

	Punctuated = 3,

	Block = 4,

	LastStmt_Break = 5,
	LastStmt_Continue = 6,
	LastStmt_Return = 7,

	Field_ExpressionKey = 8,
	Field_NameKey = 9,
	Field_NoKey = 10,

	TableConstructor = 11,

	Expression_BinaryOperator = 12,
	Expression_Parentheses = 13,
	Expression_UnaryOperator = 14,
	Expression_Value = 15,

	Value_Function = 16,
	Value_FunctionCall = 17,
	Value_IfExpression = 18,
	Value_TableConstructor = 19,
	Value_Number = 20,
	Value_ParenthesesExpression = 21,
	Value_String = 22,
	Value_Symbol = 23,
	Value_Var = 24,

	Stmt_Assignment = 25,
	Stmt_Do = 26,
	Stmt_FunctionCall = 27,
	Stmt_FunctionDeclaration = 28,
	Stmt_GenericFor = 29,
	Stmt_If = 30,
	Stmt_LocalAssignment = 31,
	Stmt_LocalFunction = 32,
	Stmt_NumericFor = 33,
	Stmt_Repeat = 34,
	Stmt_While = 35,
	Stmt_CompoundAssignment = 36,
	Stmt_ExportedTypeDeclaration = 37,
	Stmt_TypeDeclaration = 38,

	Prefix_Expression = 39,
	Prefix_Name = 40,

	Index_Brackets = 41,
	Index_Dot = 42,

	FunctionArgs_Parentheses = 43,
	FunctionArgs_String = 44,
	FunctionArgs_TableConstructor = 45,

	NumericFor = 46,

	GenericFor = 47,

	If = 48,

	ElseIf = 49,

	While = 50,

	Repeat = 51,

	MethodCall = 52,

	Call_Anonymous = 53,
	Call_Method = 54,

	FunctionBody = 55,

	Suffix_Call = 56,
	Suffix_Index = 57,

	VarExpression = 58,

	Var_Expression = 59,
	Var_Name = 60,

	Assignment = 61,

	LocalFunction = 62,

	LocalAssignment = 63,

	Do = 64,

	FunctionCall = 65,

	FunctionName = 66,

	FunctionDeclaration = 67,

	BinOp_And = 68,
	BinOp_Caret = 69,
	BinOp_GreaterThan = 70,
	BinOp_GreaterThanEqual = 71,
	BinOp_LessThan = 72,
	BinOp_LessThanEqual = 73,
	BinOp_Minus = 74,
	BinOp_Or = 75,
	BinOp_Percent = 76,
	BinOp_Plus = 77,
	BinOp_Slash = 78,
	BinOp_Star = 79,
	BinOp_TildeEqual = 80,
	BinOp_TwoDots = 81,
	BinOp_TwoEqual = 82,

	UnOp_Minus = 83,
	UnOp_Not = 84,
	UnOp_Hash = 85,

	TypeInfo_Array = 86,
	TypeInfo_Basic = 87,
	TypeInfo_String = 88,
	TypeInfo_Boolean = 89,
	TypeInfo_Callback = 90,
	TypeInfo_Generic = 91,
	TypeInfo_GenericPack = 92,
	TypeInfo_Intersection = 93,
	TypeInfo_Module = 94,
	TypeInfo_Optional = 95,
	TypeInfo_Table = 96,
	TypeInfo_Typeof = 97,
	TypeInfo_Tuple = 98,
	TypeInfo_Union = 99,
	TypeInfo_Variadic = 100,
	TypeInfo_VariadicPack = 101,

	IndexedTypeInfo_Basic = 102,
	IndexedTypeInfo_Generic = 103,

	TypeField = 104,

	TypeFieldKey_Name = 105,
	TypeFieldKey_IndexSignature = 106,

	TypeAssertion = 107,

	TypeDeclaration = 108,

	GenericParameterInfo_Name = 109,
	GenericParameterInfo_Variadic = 110,

	GenericDeclarationParameter = 111,

	GenericDeclaration = 112,

	TypeSpecifier = 113,

	TypeArgument = 114,

	ExportedTypeDeclaration = 115,

	CompoundOp_PlusEqual = 116,
	CompoundOp_MinusEqual = 117,
	CompoundOp_StarEqual = 118,
	CompoundOp_SlashEqual = 119,
	CompoundOp_PercentEqual = 120,
	CompoundOp_CaretEqual = 121,
	CompoundOp_TwoDotsEqual = 122,

	CompoundAssignment = 123,

	IfExpression = 124,

	ElseIfExpression = 125,
}

return nodes