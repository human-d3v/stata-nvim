# Create and Run <span style="color:#F87060">*Stata*</span> Files in NeoVim. 
This repository contains everything needed to configure NeoVim to handle and
run *.do*, and *.ado* files; including sending lines/visual blocks to a Stata
terminal buffer in NeoVim,  a simple LSP implementation for autocompletion, and
syntax highlighting. 

This effort wouldn't be possible without the following:
- [Jeffery Chupp's enlightening YT tutorial on LSPs](https://youtu.be/Xo5VXTRoL6Q?si=6c0lw8UDtL-iELL9)
- [Zizhong Yan's Stata-Vim package for highlighting](https://github.com/zizhongyan/vim-stata)
- [HankBo's commands.json file from stata-language-server](https://github.com/HankBO/stata-language-server)

## <span style="color:#F87060">Dependencies</span>
- [NeoVim](https://github.com/neovim/neovim/tree/master) >= v0.9.0
- [npx](https://www.npmjs.com/package/npx)
- [ts-node](https://www.npmjs.com/package/ts-node)



### Future Features
- [ ] snippet support 
