function OpenBufferTerminalRepl(term_type)
	-- vim.api.nvim_exec('new | term', false)
	vim.api.nvim_exec2('belowright split | term', {output = true})
	local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_chan_send(vim.api.nvim_get_option_value( 'channel',{buf = bufnr}), term_type .. "\r")
end

local function nextLine()
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

function SendToRepl(opt)
	--0: send the current line to Repl 
	--1: send the visual selection to Repl
	--2: send the entire file up to and including the current line to Repl 
	local txt = ''
	if opt == 1 then
		vim.cmd('normal! gv"xy') --captures vis selection
		txt = vim.fn.getreg('x')
		vim.api.nvim_exec2(":'>", {})
	elseif opt == 2 then
		local ln, _  = unpack(vim.api.nvim_win_get_cursor(0))
		local lnTxts = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, ln, false)
		txt = table.concat(lnTxts, "\n")
	else
		txt = vim.api.nvim_get_current_line()
	end

	nextLine() -- move to next non-whitespace line

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

	vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel', {buf = term_buf}), txt .. '\r')
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"stata"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminalRepl('stata-mp')<CR>]], {noremap=true, buffer=true})
			vim.keymap.set({"v","x"}, "<leader><leader>t", [[:lua SendToRepl(1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<leader><leader>t", [[:lua SendToRepl(0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<leader><leader>at", [[:lua SendToRepl(2)<CR>]], {noremap=true, buffer=true})
		end)
	end,
})

