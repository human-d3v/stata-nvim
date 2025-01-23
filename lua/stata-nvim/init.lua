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

local function main()
	require('lsp').setup()
end

function M.setup()
	vim.api.nvim_create_autocmd('FileType', {
		pattern = {"stata"},
		once = true,
		callback = function()
			vim.schedule(
				function ()
					main()
				end
			)
		end
	})
end

return M
