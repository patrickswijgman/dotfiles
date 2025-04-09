local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]:upper())
end

local function filepath()
	return " %f "
end

local function lsp()
	local num_error = #vim.diagnostic.get(0, { severity = "ERROR" })
	local num_warn = #vim.diagnostic.get(0, { severity = "WARN" })
	local num_info = #vim.diagnostic.get(0, { severity = "INFO" })
	local num_hint = #vim.diagnostic.get(0, { severity = "HINT" })

	local num_total = num_error + num_warn + num_info + num_hint
	if num_total == 0 then
		return ""
	end

	local error = ""
	local warning = ""
	local info = ""
	local hint = ""

	if num_error ~= 0 then
		error = "%#LspDiagnosticsSignError#E " .. num_error
	end
	if num_warn ~= 0 then
		warning = "%#LspDiagnosticsSignWarning#W " .. num_warn
	end
	if num_info ~= 0 then
		info = "%#LspDiagnosticsSignInformation#I " .. num_info
	end
	if num_hint ~= 0 then
		hint = "%#LspDiagnosticsSignHint#H " .. num_hint
	end

	return " " .. error .. warning .. info .. hint .. "%#StatusLine# "
end

local function filetype()
	return " %y "
end

local function lineinfo()
	return " %l/%L:%c "
end

function StatuslineActive()
	return table.concat({
		mode(),
		lsp(),
		filepath(),
		"%=",
		filetype(),
		lineinfo(),
	})
end

function StatuslineInactive()
	return table.concat({
		filepath(),
		"%=",
		filetype(),
		lineinfo(),
	})
end

local group = vim.api.nvim_create_augroup("UserStatusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	command = "setlocal statusline=%!v:lua.StatuslineActive()",
	group = group,
	desc = "Statusline active",
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	command = "setlocal statusline=%!v:lua.StatuslineInactive()",
	group = group,
	desc = "Statusline inactive",
})
