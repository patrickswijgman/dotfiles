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
	local current_mode = vim.api.nvim_get_mode()
	return string.format(" %s", modes[current_mode.mode]):upper()
end

local function diagnostics()
	local error_count = #vim.diagnostic.get(0, { severity = "ERROR" })
	local warn_count = #vim.diagnostic.get(0, { severity = "WARN" })
	local info_count = #vim.diagnostic.get(0, { severity = "INFO" })
	local hint_count = #vim.diagnostic.get(0, { severity = "HINT" })

	local error = ""
	local warn = ""
	local info = ""
	local hint = ""

	if error_count ~= 0 then
		error = table.concat({ " %#DiagnosticError#", "E:", error_count })
	end
	if warn_count ~= 0 then
		warn = table.concat({ " %#DiagnosticWarn#", "W:", warn_count })
	end
	if info_count ~= 0 then
		info = table.concat({ " %#DiagnosticInfo#", "I:", info_count })
	end
	if hint_count ~= 0 then
		hint = table.concat({ " %#DiagnosticHint#", "H:", hint_count })
	end

	return table.concat({ error, warn, info, hint, "%#StatusLine#" })
end

function _G.statusline_active()
	return string.format("%s ", table.concat({ mode(), diagnostics(), " %f %m %= %y %l/%L:%c" }))
end

function _G.statusline_inactive()
	return " %f %m %= %y %l/%L:%c "
end

local group = vim.api.nvim_create_augroup("PluginStatusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	command = "setlocal statusline=%!v:lua.statusline_active()",
	group = group,
	desc = "Statusline active",
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	command = "setlocal statusline=%!v:lua.statusline_inactive()",
	group = group,
	desc = "Statusline inactive",
})

