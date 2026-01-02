if exists("b:current_syntax")
  finish
endif

syn keyword magolorKeyword fn let return if else while for match class new this using pub priv static mut cimport
syn keyword magolorType int float string bool void
syn keyword magolorBoolean true false
syn keyword magolorConstant None Some

syn region magolorComment start="//" end="$"
syn region magolorString start='"' end='"' skip='\\"'
syn region magolorInterpolatedString start='\$"' end='"'

syn match magolorNumber /\<\d\+\>/
syn match magolorFloat /\<\d\+\.\d\+\>/
syn match magolorFunction /\w\+\s*(/me=e-1

hi def link magolorKeyword Keyword
hi def link magolorType Type
hi def link magolorBoolean Boolean
hi def link magolorConstant Constant
hi def link magolorComment Comment
hi def link magolorString String
hi def link magolorInterpolatedString String
hi def link magolorNumber Number
hi def link magolorFloat Float
hi def link magolorFunction Function

let b:current_syntax = "magolor"
