local M = {}

function M.get_help_response(stata_license_type, keyword)
	local cmd = stata_license_type .. ' help ' .. keyword
	local handle = io.popen(cmd)
	if handle == nil then
		print("error in getting help response")
		return 
	end
	local result = handle:read("*a")
	if result == nil then
		print("No response from stata")
	end
	handle:close()
	return result -- should return a big output with the help docs of a function
end
