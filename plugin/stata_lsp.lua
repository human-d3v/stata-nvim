local Job = require('plenary.job')

local compile = function()
  Job:new({
    command = "bun",
    args = {"build", "./server/src/server.ts", "--compile", "--outfile", "server_bin"},
  })
end

local install = function ()
	Job:new({
		command = "npm",
    args = {"install"},
		on_exit = function() compile() end
	})
end

local init = function ()
	Job:new({
		command = "npm",
		args = {"init", "-y"},
		on_exit = function() install() end
	})
end

local build_binary_server = function()
	Job:new({
		command = "cd",
		args = {"lsp-server"},
		on_exit = function() init() end
	})
end

build_binary_server()
