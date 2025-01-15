local M = {}

function M.setup(opts)
	local terminal = require("terminal")
	local repl = require("repl")
	local opts = opts or {stata_license_type = "stata-mp"}
end

return M
