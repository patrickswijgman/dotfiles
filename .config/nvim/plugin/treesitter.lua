local registrations = {
  { "angular", "htmlangular" },
  { "bash", "sh" },
  { "bibtex", "bib" },
  { "c_sharp", { "cs", "csharp" } },
  { "commonlisp", "lisp" },
  { "cooklang", "cook" },
  { "devicetree", "dts" },
  { "diff", "gitdiff" },
  { "eex", "eelixir" },
  { "elixir", "ex" },
  { "embedded_template", "eruby" },
  { "erlang", "erl" },
  { "facility", "fsd" },
  { "faust", "dsp" },
  { "gdshader", "gdshaderinc" },
  { "git_config", "gitconfig" },
  { "git_rebase", "gitrebase" },
  { "glimmer", { "handlebars", "html.handlebars" } },
  { "godot_resource", "gdresource" },
  { "haskell", "hs" },
  { "haskell_persistent", "haskellpersistent" },
  { "idris", "idris2" },
  { "ini", { "confini", "dosini" } },
  { "janet_simple", "janet" },
  { "javascript", { "javascriptreact", "ecma", "ecmascript", "jsx", "js" } },
  { "json", "jsonc" },
  { "glimmer_javascript", "javascript.glimmer" },
  { "latex", "tex" },
  { "linkerscript", "ld" },
  { "m68k", "asm68k" },
  { "make", "automake" },
  { "markdown", "pandoc" },
  { "muttrc", "neomuttrc" },
  { "ocaml_interface", "ocamlinterface" },
  { "perl", "pl" },
  { "poe_filter", "poefilter" },
  { "powershell", "ps1" },
  { "properties", "jproperties" },
  { "python", { "py", "gyp" } },
  { "qmljs", "qml" },
  { "runescript", "clientscript" },
  { "scala", "sbt" },
  { "slang", "shaderslang" },
  { "sqp", "mysqp" },
  { "ssh_config", "sshconfig" },
  { "starlark", "bzl" },
  { "surface", "sface" },
  { "systemverilog", "verilog" },
  { "t32", "trace32" },
  { "tcl", "expect" },
  { "terraform", "terraform-vars" },
  { "textproto", "pbtxt" },
  { "tlaplus", "tla" },
  { "tsx", { "typescriptreact", "typescript.tsx" } },
  { "typescript", "ts" },
  { "glimmer_typescript", "typescript.glimmer" },
  { "typst", "typ" },
  { "udev", "udevrules" },
  { "uxntal", { "tal", "uxn" } },
  { "v", "vlang" },
  { "vhs", "tape" },
  { "xml", { "xsd", "xslt", "svg" } },
  { "xresources", "xdefaults" },
}

local function start(ev)
  pcall(vim.treesitter.start, ev.buf)
end

local path = os.getenv("TREESITTER_PATH")
if path then
  vim.opt.runtimepath:append(path)
end

for _, reg in ipairs(registrations) do
  vim.treesitter.language.register(reg[1], reg[2])
end

local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  callback = start,
  desc = "Start treesitter",
  group = group,
})
