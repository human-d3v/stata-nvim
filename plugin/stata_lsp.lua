local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")


local function check_necessary_packages()
	local npx_result = vim.fn.system("npx --version")
	local ts_node_result = vim.fn.system("ts-node --version")
	return {npx =  (npx_result == 0), ts_node = (ts_node_result==0)}
end

local function check_necessary_env_vars()
	local path = vim.fn.getenv("PATH")
	local paths = vim.split(path, ";")
	
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

local function main()
	local lsp_path = vim.fn.expand(
		vim.fn.fnamemodify(vim.fn.getcwd(), ":h") .. "/lsp-server/server/src/server.ts"
	)

	vim.cmd [[autocmd BufRead,BufNewFile *.do set filetype=stata]]

	local custom_attach = function (client)
		print("Stata LSP started");
	end

	local pkgs = check_necessary_packages()
	local env = check_necessary_env_vars()

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
					"npx", "ts-node",
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

return main()
