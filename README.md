# Create and Run <span style="color:#F87060">*Stata*</span> Files in NeoVim. 
This repository contains everything needed to configure NeoVim to handle and
run *.do*, and *.ado* files; including sending lines/visual blocks to a Stata
terminal buffer in NeoVim,  a simple LSP implementation for autocompletion, and
syntax highlighting. I haven't tested this on Gnu/Linux yet, as I did this for
my work machine (on MacOS).

![stata_term](./assets/terminal_spawn.gif) 


This effort wouldn't be possible without the following:
- [poliquin's stata-vim package for highlighting](https://github.com/poliquin/stata-vim)
- [HankBo's commands.json file from stata-language-server](https://github.com/HankBO/stata-language-server)


## <span style="color:#F87060">Dependencies</span>
- [NeoVim](https://github.com/neovim/neovim/tree/master) >= v0.9.0
- [nodejs](https://nodejs.org/en/download/)
- [bun](https://bun.sh/)
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

2) Load the plugin using Lazy.nvim.
``` lua
{
   'human-d3v/stata-nvim', branch = 'packaging', ft = {'stata'},
   build = 'git pull origin packaging && cd lsp-server && npm init -y && npm install && bun build ./server/src/server.ts --compile --outfile server_bin && cd ..',
   opts = {},
   config = function ()
   	require("stata-nvim")
   end,
   event = 'VeryLazy',
}

```

This looks a little gross, but let's break it down:
- `"human-d3v/stata-nvim", branch = 'packaging'` is just the name of the repository with its accompanying branch.
- `ft = {'stata'}` only loads the plugin if the file type is stata.
-    ```lua 
        build = 'git pull origin packaging && cd lsp-server && npm init -y && npm
        install && bun build ./server/src/server.ts --compile --outfile server_bin &&
        cd ..' 
    ```
    This compiles the language server into a binary using bun to be used by lua
    when the file type is stata. This helps speed things up. 
- `config = function () require("stata-nvim") end` loads the plugin into the vimruntime to be accessed by by the plugin configuration.
- `event = 'VeryLazy'` Puts the priority of the plugin loading to the last possible thing. So it's not messing with any other plugins.

3) Configure the plugin in in your plugins directory:
```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'stata',
  callback = function()
		local stata = require('stata-nvim')
    stata.setup({dev = false, stata_license_type = "stata-mp"})
  end,
})
```
This loads the correct license type and avoids the dev mode.


## Keybindings:
| Mode | Keybinding | Description |
| ---- | ---------- | ----------- |
| Normal | <leader>mp | Spawns a *Stata* terminal |
| Normal | \d         | sends the current line to the *Stata* terminal |
| Visual | \d         | sends the current visual line/block to the *Stata* terminal |
| Normal | \q         | closes the *Stata* terminal |

### TODO
- [ ] snippet support 
- [ ] complete lsp support for help docs 
- [ ] complete command.json type tagging
- [x] implement lazy.nvim compatibility for easy install and updates
