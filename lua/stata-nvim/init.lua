--
-- local function main() --opts)
-- 	-- local terminal = require("terminal")
-- 	-- local repl = require("repl")
-- 	-- local opts = opts or {stata_license_type = "stata-mp"}
-- 	require("lsp").setup()
-- end
--
-- local function setup()--opts)
-- 	vim.api.nvim_create_autocmd("VimEnter", 
-- 		{group = augroup, 
-- 		pattern = {"stata"},
-- 		desc = "Stata LSP Setup",
-- 		once = true, 
-- 		-- callback = main()--opts)})
-- 		callback = function ()
-- 			vim.api.nvim_create_autocmd('FileType', {
-- 				pattern = 'stata',
-- 				callback = function ()
-- 					print("starting LSP for Stata")
-- 				end
-- 			})
-- 		end
-- 	})
-- end
--
-- setup()

-- local M = {}
--
-- function M.setup()
-- 	print("stata-nvim loaded")
-- end
--
-- return M
local M = {}


function M.setup(opts)
	local augroup = vim.api.nvim_create_augroup("Stata", {clear = true})
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "stata",
		group = augroup,
		callback = function ()
			vim.api.nvim_set_keymap("n", "<leader>mm", print("stata-nvim loaded"), {buffer = true})
		end
	})
end

return M
