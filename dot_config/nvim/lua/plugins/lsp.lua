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
        importModuleSpecifierEnding = "js",
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

vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://www.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig.json" },
          url = "https://www.schemastore.org/tsconfig.json",
        },
      },
    },
  },
})

vim.lsp.enable("nixd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("vtsls")
vim.lsp.enable("biome")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("codebook")
vim.lsp.enable("taplo")
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("gopls")
