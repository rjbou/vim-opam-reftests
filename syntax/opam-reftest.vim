" Vim syntax file
" Language: opam reftests
" Maintainer: Raja Boujbel
" Latest Revision: $2021-07-01$

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "opam-reftest"

syn match trepohash "\%^[0-9a-fA-F]\{6,10}"

syn match terror "^# Return code \d\+ #$" contained
syn match tcomment "^### [#:].*$"
syn region tfilecontent matchgroup=ttfile start="^### <.*>$"     end="^###"me=s-1 transparent contains=tfc,tcomment    nextgroup=tfilecontent,tcontent
syn region tcontent     matchgroup=ttcmd  start="^### [^<#:].*$" end="^###"me=s-1 transparent contains=tc,terror,tcomment  nextgroup=tfilecontent,tcontent

syn match tfc "^\(###\)\@!.*" contained nextgroup=tfilecontent,tcontent
syn match tc  "^\(###\|# Return\)\@!.*" contained nextgroup=tfilecontent,tcontent


hi def link  tfc Include
hi def link  tc String
hi def link ttcmd          Keyword
hi def link tcontent       Keyword
hi def link ttfile        Directory
hi def link tfilecontent  Directory
hi def link trepohash Constant
hi def link terror    Statement
hi def link tcomment  Comment
