vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
})

vim.lsp.config("vtsls", {
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      preferences = {
        importModuleSpecifier = "non-relative",
        importModuleSpecifierEnding = "auto",
      },
      updateImportsOnFileMove = {
        enabled = "always",
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
  },
})

vim.lsp.enable("nixd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("vtsls")
-- vim.lsp.enable("codebook")
vim.lsp.enable("taplo")
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")
