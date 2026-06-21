if exists("b:current_syntax")
  finish
endif

syn match configKey     "^\s*\zs[^[:space:]{}=]\+" skipwhite nextgroup=configEquals,configValue
syn match configEquals  "=" skipwhite contained nextgroup=configValue
syn match configValue   "[^=[:space:]].*$" contained contains=configBrace,configVar
syn match configVar     "\$\w\+" contained
syn match configBrace   "[{}]"
syn match configComment "^\s*#.*$" contains=@Spell

hi def link configKey     Normal
hi def link configEquals  Operator
hi def link configValue   String
hi def link configVar     Identifier
hi def link configBrace   Delimiter
hi def link configComment Comment

let b:current_syntax = "config"
