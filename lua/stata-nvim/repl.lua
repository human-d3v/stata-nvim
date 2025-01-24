local M = {}

function M.NextLine()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local total_lines = vim.api.nvim_buf_line_count(0)

	for i = current_line+1, total_lines do
    local line_content = vim.api.nvim_buf_get_lines(0, i-1, i, false)[1]
    if line_content:match('^%S') then
      vim.api.nvim_win_set_cursor(0, {i,0})
      break
    end
  end
end

function M.LastChanceReplSpawn(term_type)
	term = require('terminal')
	local answer = vim.fn.input('No terminal found. Do you want to open one? [y/n]\n')
	if answer:lower() == 'y' then
		term.OpenBufferTerminal(term_type)
		term_buf = vim.g.term_buf --set variable since it didn't get set above
	else
		print("\nAction Cancelled")
	end
end

function M.SendToRepl(repl_type, input_type, ...)
  -- repl_type <- right now it's only stata, but the same functionality could
  --- work for a regular terminal or python files
  -- 'stata'
	
	-- input_type
	--0: send the current line to Repl 
	--1: send the visual selection to Repl
	--2: send the entire file up to and including the current line to Repl 
	--3: send an optional string to the Repl
	local txt = ''
	
	if input_type == 1 then -- visual selection
		vim.cmd('normal! gv"xy') --captures vis selection
		txt = vim.fn.getreg('x')
		vim.api.nvim_exec2(":'>", {})
	elseif input_type == 2 then -- normal mode entire file 
		local ln, _  = unpack(vim.api.nvim_win_get_cursor(0))
		local lnTxts = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, ln, false)
		txt = table.concat(lnTxts, "\n")
	elseif input_type == 3 then -- send text explicitly
		if ... then
			for i, v in ipairs({...}) do
				txt = txt .. v
			end
		end
	else
		txt = vim.api.nvim_get_current_line()
	end

	M.NextLine() -- move to next non-comment, non-whitespace line

	local term_buf = nil
  if repl_type == 'stata-mp' or repl_type == 'stata-se' then
    term_buf = vim.g.stata_repl
  else
    term_buf = vim.g.term_buf
  end
	if term_buf == nil then
    M.LastChanceReplSpawn(repl_type)
  end

	vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel', {buf=term_buf}), txt .. '\r')
end

function M.SendVisualSelection(repl_type)
	M.SendToRepl(repl_type, 1)
end

function M.SendCurrentLine(repl_type)
  M.SendToRepl(repl_type, 0)
end

function M.SendFileFromStartToCursor(repl_type)
  M.SendToRepl(repl_type, 2)
end

function M.EndReplInstance(repl_type)
	M.SendToRepl(repl_type, 3, 'exit')
end
return M
