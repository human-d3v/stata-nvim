local M = {}

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")


function M.CheckNecessaryPackages()
	local function check_command (cmd)
		local success, _ = pcall(function()
			return vim.fn.system("which " .. cmd)
		end)
		return success and vim.v.shell_error == 0
	end
	return {
		npx = check_command("npx"),
		ts_node = check_command("ts-node")
	}
end

function M.CheckNecessaryEnvVars()
	local path = vim.fn.getenv("PATH")
	local paths = vim.split(path, ":")
  
	local mp = "StataMP.app"
	local se = "StataSE.app"
	local stata_version = {mp = false, se = false}
	for _, p in ipairs(paths) do
    if p:find(mp) then
      stata_version.mp = true
		elseif p:find(se) then
			stata_version.se = true
    end
  end
  return stata_version
end

function M.setup(opts)
	local lsp_path
	if opts.dev == false then
		lsp_path = vim.fn.expand(
			vim.fn.stdpath('data') .. "/lazy/stata-nvim/lsp-server/server_bin"
		)
	else
		lsp_path = vim.fn.expand(
			"~/Documents/plugins/stata-nvim/lsp-server/server_bin"
		)
	end

	vim.cmd [[autocmd BufRead,BufNewFile *.do set filetype=stata]]

	local custom_attach = function (client)
		print("Stata LSP started");
	end

	local pkgs = M.CheckNecessaryPackages()
	local env = M.CheckNecessaryEnvVars()

	if not pkgs.npx or not pkgs.ts_node then
		vim.notify("stata-nvim: npx and ts-node are required before running this lsp", vim.log.levels.ERROR)
	end

	if not env.mp and not env.se then
    vim.notify("stata-nvim: StataMP or StataSE is required in PATH", vim.log.levels.ERROR)
  end

	if not configs.stata then
		configs.stata = {
			default_config = {
				cmd = {
					-- "npx", "ts-node",
					lsp_path
				},
				filetypes = {"stata"},
        root_dir = lspconfig.util.root_pattern('.git','stata'),
        settings = {}
			}
		}
	end
	lspconfig.stata.setup {
		capabilities = vim.lsp.protocol.make_client_capabilities(),
		on_attach = custom_attach
	}
end

return M
