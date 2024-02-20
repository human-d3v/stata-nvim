local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local custom_attach = function (client) print("Stata LSP started"); end


vim.cmd [[autocmd BufRead,BufNewFile *.do set filetype=stata]]

if not configs.stata then
	configs.stata = {
		default_config = {
			cmd = {
				"npx", "ts-node",
				vim.fn.expand("~/.lsp/stata/server/src/server.ts")
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

