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

local function main(opts)
	local terminal = require('stata-nvim.terminal')
	local repl = require('stata-nvim.repl')
	local opts = opts or {dev = false, stata_license_type = "stata-mp"}
	require('stata-nvim.lsp').setup(opts)
	--set keymaps
	local keymap_opts = {silent = true, noremap = true, buffer = true}
	local license 
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {"stata"},
		callback = function()
			vim.schedule(function ()
				vim.keymap.set("n", "<leader>mp", function ()
					terminal.OpenBufferTerminal(opts.stata_license_type)
					end, 
					keymap_opts
				)
				vim.keymap.set({"x", "v"} , "<Bslash>d", function ()
						repl.SendVisualSelection(opts.stata_license_type)
					end,
					keymap_opts
				)
				vim.keymap.set("n", "<Bslash>d", function ()
						repl.SendCurrentLine(opts.stata_license_type)
					end,
					keymap_opts
				)
				vim.keymap.set("n", "<Bslash>aa", function ()
						repl.SendFileFromStartToCursor(opts.stata_license_type)
					end,
					keymap_opts
				)
				vim.keymap.set("n", "<Bslash>q", function ()
						repl.EndReplInstance(opts.stata_license_type)
					end,
					keymap_opts
				)
			end)
    end
	})

end

-- so far, opts has one value: dev which is defaulted to false
-- this allows me to test the local repo without having to push to origin and pull every time

function M.setup(opts)
	vim.api.nvim_create_autocmd('FileType', {
		pattern = {"stata"},
		once = true,
		callback = function()
			vim.schedule(
				function ()
					main(opts)
				end
			)
		end
	})
end

return M
