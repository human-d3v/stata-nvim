vim.api.nvim_create_autocmd("FileType", {
	pattern = {"stata"},
	callback = function ()
		vim.schedule(function ()
			function OpenBufferTerminalRepl(term_type)
				--set gloabl variable for code buffer 
				vim.g.code_buf = vim.api.nvim_get_current_buf()

				--open term buf and move cursor there	
				vim.api.nvim_exec2('belowright split | term', {output = true})
				local bufnr = vim.api.nvim_get_current_buf()

				--set gloabl variable for stata buf
				if term_type == 'stata-mp' then
					vim.g.stata_repl = bufnr
				else
					vim.g.term_buf = bufnr
				end

			  vim.api.nvim_chan_send(vim.api.nvim_get_option_value( 'channel',{buf = bufnr}), term_type .. "\r")

				--move cursor to the end of the stata repl
				vim.api.nvim_win_set_cursor(0, {vim.api.nvim_buf_line_count(bufnr),0})
				--move cursor back to code_buf
				vim.cmd('wincmd p')
			end


			function CloseRepl(term_type)
				if term_type == 'stata-mp' then
					if vim.g.stata_repl ~= nil then
						vim.api.nvim_buf_delete(vim.g.stata_repl, {force = true})
					end
				else
					print("No terminal found.")
				end
			end


			function VerifyCloseRepl(term)
				local answer = vim.fn.input('Are you sure you want to close the REPL? (y/n)')
				if answer:lower() == 'y' then
					CloseRepl(term)
				else
					print("\nAction Cancelled")
				end
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


			function SendToRepl(repl_type, input_type, ...)
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

				nextLine() -- move to next non-comment, non-whitespace line

				local term_buf = nil
				if repl_type == 'stata' then
					if vim.g.stata_repl ~= nil then
						term_buf = vim.g.stata_repl
					end
				else
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[bufnr].buftype == 'terminal' then
							term_buf = bufnr
							break
						end
					end
				end

				if term_buf == nil then
					local answer = vim.fn.input('No terminal found. Do you want to open one? [y/n]\n')
					if answer:lower() == 'y' then
						OpenBufferTerminalRepl('stata-mp')
						term_buf = vim.g.stata_repl --set variable since it didn't get set above
					else
						print('\nAction Cancelled')
						return
					end
				end

				vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel', {buf = term_buf}), txt .. '\r')
			end

			local opts = {noremap = true, buffer = true}
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminalRepl('stata-mp')<CR>]], opts) -- open terminal
			vim.keymap.set({"v","x"}, "<Bslash>d", [[:lua SendToRepl('stata', 1)<CR>]], opts) -- send visual selection to REPL
			vim.keymap.set("n", "<Bslash>d", [[:lua SendToRepl('stata', 0)<CR>]], opts) -- send current line to REPL
			vim.keymap.set("n", "<Bslash>aa", [[:lua SendToRepl('stata', 2)<CR>]], opts) -- send entire file to REPL
			vim.keymap.set("n", "<Bslash>rm", [[:lua SendToRepl('stata', 3, 'exit']], opts) -- End the Stata instance in the REPL, helpful for clearing the memory and restarting
			vim.keymap.set("n", "<Bslash>q", [[:lua VerifyCloseRepl('stata-mp')<CR>]], opts) -- close terminal with verify step
			-- vim.keymap.set("n", "<Bslash>q", [[:lua CloseRepl('stata-mp')<CR>]], opts) -- close terminal without verify step
		end)
	end,
})

