# Create and Run <span style="color:#F87060">*Stata*</span> Files in NeoVim. 
This repository contains everything needed to configure NeoVim to handle and
run *.do*, and *.ado* files; including sending lines/visual blocks to a Stata
terminal buffer in NeoVim,  a simple LSP implementation for autocompletion, and
syntax highlighting. I haven't tested this on Gnu/Linux yet, as I did this for
my work machine (on MacOS).

![stata_term](./assets/terminal_spawn.gif) 


This effort wouldn't be possible without the following:
- [Jeffery Chupp's enlightening YT tutorial on LSPs](https://youtu.be/Xo5VXTRoL6Q?si=6c0lw8UDtL-iELL9)
- [poliquin's stata-vim package for highlighting](https://github.com/poliquin/stata-vim)
- [HankBo's commands.json file from stata-language-server](https://github.com/HankBO/stata-language-server)


## <span style="color:#F87060">Dependencies</span>
- [NeoVim](https://github.com/neovim/neovim/tree/master) >= v0.9.0
- [npx](https://www.npmjs.com/package/npx)
- [ts-node](https://www.npmjs.com/package/ts-node)
- [Licensed version of Stata](https://www.stata.com/products/)


## <span style="color:#F87060">Spawning a *Stata* terminal</span>
1) Add `stata-mp` or `stata-se` terminal to your `$PATH`. This can be
accomplished by adding the following to your `.zshrc`:
```bash
export PATH="$PATH:/Applications/Stata/StataMP.app/Contents/MacOS/"/

## You can also use the following from any zsh terminal to append the command to your .zshrc

echo 'export PATH="$PATH:/Applications/Stata/StataMP.app/Contents/MacOS/"' >> ~/.zshrc
```
<small><i>change this to reflect your App, such as the case with
<span style="color:#1dd3b0">StataSE</span></i></small>

2) Create the functionality in your `~/.config/nvim/after/plugin/` directory to
spawn the terminal. In my [config](https://github.com/human-d3v/neovimConfig)
the file is called [stataHandler.lua](https://github.com/human-d3v/neovimConfig/blob/main/lazy/nvim/after/plugin/stataHandler.lua) in a subdirectory called `stata_lsp/`

```lua
function OpenBufferTerminalInStata()
	vim.api.nvim_exec('new | term', false)
	local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(bufnr, 'channel'), 'stata-mp' .. "\r")
end
```
This snippet spawns a new terminal buffer and populates the first command with
'stata-mp' to open a <span style="color:#1dd3b0"><i>Stata</i> Multi-Processor REPL</span>.

3) Map the above function to a keymap. I chose `<leader>mp`:

```lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"stata"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminalInStata()<CR>]], {noremap=true, buffer=true})
        end)
    end,
})
```
## <span style="color:#F87060">Sending *.do/.ado* snippets/files to *Stata* terminal</span> 
We need to account for 3 different cases when interacting with the newly
spawned <span style="color:#1dd3b0"><i>Stata</i> terminal</span>. 

1) Sending a newly written line of code to the terminal. 
2) Sending a visual block of code to the terminal. (i.e. a full function, `for` loop, etc).
3) Sending the entire *.do* file **up to and including** the text of the
current line to the terminal. 

The resulting function looks like this: 

```lua
function SendToStata(opt)
	--0: send the current line to Stata
	--1: send the visual selection to Stata
	--2: send the entire file up to and including the current line to Stata
	local txt = ''
	if opt == 1 then
		vim.cmd('normal! gv"xy') --captures vis selection
		txt = vim.fn.getreg('x')
	elseif opt == 2 then
		local ln, _  = unpack(vim.api.nvim_win_get_cursor(0))
		local lnTxts = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, ln, false)
		txt = table.concat(lnTxts, "\n")
	else
		txt = vim.api.nvim_get_current_line()
	end

	local term_buf = nil
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[bufnr].buftype == 'terminal' then
			term_buf = bufnr
			break
		end
	end
	if term_buf == nil then
		print("No terminal found.")
		return
	end

	vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(term_buf, 'channel'), txt .. '\r')
end
```
The above function accepts an `opt` argument (integer) which is used to decide
which of the above cases to implement. 

From there, the updated filetype autocmd looks like this: 
```lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"stata"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminalInStata()<CR>]], {noremap=true, buffer=true})
			vim.keymap.set({"v","x"}, "<BSlash>d", [[:lua SendToStata(1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<BSlash>d", [[:lua SendToStata(0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<BSlash>aa", [[:lua SendToStata(2)<CR>]], {noremap=true, buffer=true})
		end)
	end,
})
```
An explanation of the keymaps;
- `leader + mp` -> spawns a <span style="color:#1dd3b0">stata-mp</span> terminal in a new buffer
- `\ + d` -> sends either a visual selection or the current line to
  the <span style="color:#1dd3b0">stata-mp</span> terminal buffer. 
- `\ + aa` -> sends all of the contents of the current buffer
  up to and including the current line to the <span style="color:#1dd3b0">stata-mp</span> terminal buffer.

<small>I have mapped my `leader` key to the space " " bar.</small>


## <span style="color:#F87060">Running the Lanugage Server</span>
Clone this repository into a local directory, for example `~/.lsp`.
```bash
#clone repo
git clone https://github.com/human-d3v/stata-nvim
# lsp directory
mkdir ~/.lsp
# copy contents from this directory to that directory
cp -r ./stata-nvim/lsp-server ~/.lsp
# navigate to the directory 
cd ~/.lsp/lsp-server
# install the necessary dependencies
npm i
```

## <span style="color:#F87060">Attaching the LSP to the Current Buffer</span>
Attaching the lsp to the current buffer is as simple as attaching the server to
the filetype and appending the configuration to
[lspconfig](https://github.com/neovim/nvim-lspconfig).configs file:

```lua
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")


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
```
Then, to ensure that the buffer identifies the filetypes ending in *.do/.ado*
as the stata filetype, I explicitly expressed this in my
`~/.config/nvim/lua/btconfig/set.lua` file as the following:
```lua
vim.cmd [[
	autocmd BufRead,BufNewFile *.do set filetype=stata
	autocmd BufRead,BufNewFile *.ado set filetype=stata
	autocmd BufRead,BufNewFile *.dct set filetype=stata
]]
```

### TODO
- [ ] snippet support 
- [ ] complete lsp support for help docs 
- [ ] complete command.json type tagging
- [ ] implement lazy.nvim compatibility for easy install and updates
