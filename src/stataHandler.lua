function OpenBufferTerminalInStata()
	-- vim.api.nvim_exec('new | term', false)
	vim.api.nvim_exec('belowright split | term', false)
	local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(bufnr, 'channel'), 'stata-mp' .. "\r")
end


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
		-- txt = lnTxts
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

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"stata"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminalInStata()<CR>]], {noremap=true, buffer=true})
			vim.keymap.set({"v","x"}, "<leader><leader>t", [[:lua SendToStata(1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<leader><leader>t", [[:lua SendToStata(0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<leader><leader>at", [[:lua SendToStata(2)<CR>]], {noremap=true, buffer=true})
		end)
	end,
})

