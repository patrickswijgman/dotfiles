" Syntax for 'config': first word = key (normal), rest of line = String.
" '#' comments at line-start only, braces highlighted, values may contain '#'.
if exists("b:current_syntax")
  finish
endif

" First word on the line is the key — left as normal text.
" Hands off to an optional '=' separator, otherwise straight to the value.
syn match configKeyword "^\s*\zs[^[:space:]{}=]\+" skipwhite nextgroup=configEquals,configValue

" Optional '=' separator after the key (handles `key = v` and `key=v`).
syn match configEquals "=" skipwhite contained nextgroup=configValue

" The value: the whole rest of the line, regardless of contents
" (quoted, numbers, words, $vars). Braces inside still highlight.
" The first char excludes '=' (and whitespace) so that at a '=' position
" only configEquals can match — no nextgroup tie to resolve.
syn match configValue "[^=[:space:]].*$" contained contains=configBrace,configVar

" A '$'-prefixed word inside a value is a variable.
syn match configVar "\$\w\+" contained

" Curly braces, anywhere (including a brace-only line).
syn match configBrace "[{}]"

" Comment ONLY when '#' is the first non-blank char on the line.
" Defined last so it wins over configKeyword at the same position.
syn match configComment "^\s*#.*$" contains=@Spell

hi def link configComment Comment
hi def link configValue   String
hi def link configBrace   Delimiter
hi def link configEquals  Operator
hi def link configVar     Identifier

let b:current_syntax = "config"
