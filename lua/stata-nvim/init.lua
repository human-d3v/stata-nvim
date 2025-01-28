local M = {}

local function main(opts)
	local opts = opts or {dev = false, stata_license_type = "stata-mp"}
	require('stata-nvim.lsp').setup(opts)
end

-- so far, opts has two values: 
---- `dev` which is defaulted to false this allows me to test the local repo 
----			 without having to push to origin and pull every time
---- `stata_license_type` which is the type of stata license to use.
-- e.g. {dev = false, stata_license_type = "stata-mp"}

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
