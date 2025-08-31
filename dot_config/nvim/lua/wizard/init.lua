local M = {}

--- @class wizard.KeymapOpts
--- @field mode? string|string[] Modes in which the keymap is active. Defaults to "n" (normal mode).
--- @field isExpression? boolean Whether the keymap is an expression.

--- @class wizard.Keymap
--- @field [1] string Key combination to map.
--- @field [2] string|function What the keymap does. Can be a string or a function.
--- @field [3] string Description of the keymap.
--- @field [4] wizard.KeymapOpts? Additional options for the keymap.

--- @class wizard.AutoCmd
--- @field [1] string|string[] Events that trigger the autocommand.
--- @field [2] function Callback function to execute when the autocommand is triggered.
--- @field [3] string Description of the autocommand.

--- @class wizard.Lsp
--- @field [1] string LSP server name.
--- @field [2] vim.lsp.Config? Configuration for the LSP server.

--- @class wizard.Plugin
--- @field [1] string Plugin main module name.
--- @field [2] table<string, any>? Options to pass to the plugin setup function.

--- @class wizard.Opts
--- @field options? table<string, any> Neovim options.
--- @field global_options? table<string, any> Neovim global options.
--- @field leader? string Leader key to set.
--- @field keymaps? wizard.Keymap[] Keymaps to set.
--- @field autocmds? wizard.AutoCmd[] Autocommands to create.
--- @field lsp? wizard.Lsp[] LSP configurations.
--- @field colorscheme? string Colorscheme to set.
--- @field useExperimentalLoader? boolean Whether to enable the experimental Lua module loader.
--- @field plugins? wizard.Plugin[] Plugins to load and configure.

--- @param opts wizard.Opts
function M.setup(opts)
  for key, value in pairs(opts.options or {}) do
    vim.o[key] = value
  end

  for key, value in pairs(opts.global_options or {}) do
    vim.g[key] = value
  end

  local group = vim.api.nvim_create_augroup("WizardConfig", { clear = true })

  for _, autocmd in ipairs(opts.autocmds or {}) do
    vim.api.nvim_create_autocmd(autocmd[1], {
      callback = autocmd[2],
      group = group,
      desc = autocmd[3],
    })
  end

  for _, lsp in ipairs(opts.lsp or {}) do
    if lsp[2] then
      vim.lsp.config(lsp[1], lsp[2])
    end
    vim.lsp.enable(lsp[1])
  end

  if opts.colorscheme then
    vim.cmd.colorscheme(opts.colorscheme)
  end

  if opts.useExperimentalLoader then
    vim.loader.enable()
  end

  for _, plugin in ipairs(opts.plugins or {}) do
    require(plugin[1]).setup(plugin[2] or {})
  end

  if opts.leader then
    vim.g.mapleader = opts.leader
  end

  for _, keymap in ipairs(opts.keymaps or {}) do
    local keymap_opts = keymap[4] or {}
    local keymap_mode = keymap_opts.mode or "n"
    vim.keymap.set(keymap_mode, keymap[1], keymap[2], { desc = keymap[3], silent = true, noremap = true, expr = keymap_opts.isExpression })
  end
end

return M
