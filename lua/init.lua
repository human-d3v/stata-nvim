local M = {}
local augroup = vim.api.nvim_create_augroup("Stata", {clear = true})

function M.main(opts)
	local terminal = require("terminal")
	local repl = require("repl")
	local opts = opts or {stata_license_type = "stata-mp"}
	require("lsp").setup()
end

function M.setup(opts)
	vim.api.nvim_create_autocmd("VimEnter", 
		{group = augroup, 
		pattern = {"stata"},
		desc = "Stata LSP Setup",
		once = true, 
		callback = M.main(opts)})
end

return M
