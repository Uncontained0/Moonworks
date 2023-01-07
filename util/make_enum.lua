local fs = require("../deps/fs")

---@param code string
local function make_enum(code)
	local count = 0
	
	while true do
		local s, e = code:find("enum_placeholder")

		if s then
			code = code:sub(1, s - 1) .. count .. code:sub(e + 1)
			count = count + 1
		else
			break
		end
	end

	return code
end

local code_path = args[2]

local stat = fs.statSync(code_path)
local fd = fs.openSync(code_path, 'r')
local content = fs.readSync(fd, stat.size)
fs.closeSync(fd)

fd = fs.openSync(code_path, 'w')
fs.writeSync(fd, 0, make_enum(content))
fs.closeSync(fd)