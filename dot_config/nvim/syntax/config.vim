" Syntax for config files.
" - keys are normal
" - equal sign is optional and highlighted
" - comments start with '#' and only at the start of a line, so values may contain '#'
" - values may contain variables starting with '$'
" - curly braces are highlighted
if exists("b:current_syntax")
  finish
endif

syn match configKeyword "^\s*\zs[^[:space:]{}=]\+" skipwhite nextgroup=configEquals,configValue
syn match configEquals  "=" skipwhite contained nextgroup=configValue
syn match configValue   "[^=[:space:]].*$" contained contains=configBrace,configVar
syn match configVar     "\$\w\+" contained
syn match configBrace   "[{}]"
syn match configComment "^\s*#.*$" contains=@Spell

hi def link configComment Comment
hi def link configValue   String
hi def link configBrace   Delimiter
hi def link configEquals  Operator
hi def link configVar     Keyword

let b:current_syntax = "config"
