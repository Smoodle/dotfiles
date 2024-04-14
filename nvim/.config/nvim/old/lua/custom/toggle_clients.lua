local M = {}

function M.toggleClients()
	local disabledClientNumber = vim.fn.search([[^\/\/\*beginClient]], "n")
	local enabledClientNumber = vim.fn.search([[^\/\*beginClient]], "n")

	if enabledClientNumber == 0 and disabledClientNumber ~= 0 then
		vim.print("Disabled")
		vim.fn.setline(
			disabledClientNumber,
			vim.fn.substitute(
				vim.fn.getline(disabledClientNumber),
				[[^\/\/\*beginClient]],
				[[\/\*beginClient]],
				"g"
			)
		)
	elseif enabledClientNumber ~= 0 and disabledClientNumber == 0 then
		vim.print("Enabled")
		vim.fn.setline(
			enabledClientNumber,
			vim.fn.substitute(
				vim.fn.getline(enabledClientNumber),
				[[^\/\*beginClient]],
				[[\/\/\*beginClient]],
				"g"
			)
		)
	end
end

return M
