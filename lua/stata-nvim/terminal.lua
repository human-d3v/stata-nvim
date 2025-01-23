local M = {}

function M.OpenBufferTerminal(term_type)
	-- set global variable for code_buf
	vim.g.code_buf = vim.api.nvim_get_current_buf()
	-- open term buf and move cursor there
	vim.api.nvim_exec2('belowright split | term', {output = true})
	local bufnr = vim.api.nvim_get_current_buf()
	--set glbal var for stata repl
	if term_type == 'stata-mp' or sterm_type == 'stata-se' then
		vim.g.stata_repl = bufnr
	else
		vim.g.term_buf = bufnr
	end

	vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel', {buf=bufnr}), term_type .. "\r")
	--move cursor to end of stata_repl
	vim.api.nvim_win_set_cursor(0, {vim.api.nvim_buf_line_count(bufnr),0})
	-- move cursor back to code_buf
	vim.cmd('wincmd p')
end

function M.CloseTerminal(term_type)
	if term_type == 'stata-mp' or term_type == 'stata-se' then
		if vim.g.stata_repl ~= nil then
			vim.api.nvim_buf_delete(vim.g.stata_repl, {force=true})
		end
	else
		print("No stata repl found")
	end
end

function M.VerifyCloseTerminal(term_type)
	local a = vim.fn.input('Are you sure you want to close the REPL? (y/n)')
	if a:lower() == 'y' then
		M.CloseRepl(term_type)
	else
		print('\nAction Cancelled')
	end
end

return M
