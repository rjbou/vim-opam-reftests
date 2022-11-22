" Vim syntax file
" Language: opam reftests
" Maintainer: Raja Boujbel
" Latest Revision: $2022-02-03$

if exists("b:current_syntax")
  finish
endif

syn match trepohash "\%^\([0-9a-fA-F]\{6,10}\|N0REP0\)"

syn match terror "^# Return code \d\+ #$" contained
syn match tcomment "^### [#:].*$"

" regions

" older regexp: "^### <\(\(.*\.\(ml\|sh\)>\)\@![^>]\+>\)$"
" keep that generic regions at top, they are overwritten by syntax specific ones
syn region tfilecontent matchgroup=ttfile start="^### <.\+>$"    end="^###"me=s-1 transparent contains=tfc,tcomment    nextgroup=tfilecontent,tcontent,tmlcontent,tshcontent,topamcontent
syn region tcontent     matchgroup=ttcmd  start="^### [^<#:].*$" end="^###"me=s-1 transparent contains=tc,terror,tcomment  nextgroup=tfilecontent,tcontent,tmlcontent,tshcontent,topamcontent

" external syntax regions
syn include @opam syntax/opam.vim
unlet b:current_syntax
syn region topamcontent matchgroup=topamfile  start="^### <\(\(pkg:[a-zA-Z0-9-_]\+[.][a-zA-Z0-9-_~.]\+\)\|\(.\+\.opam\(\.locked\)\?\)\)>$"  end="^###"me=s-1 transparent contains=@opam   nextgroup=tfilecontent,tcontent,tmlcontent,tshcontent,topamcontent

syn include @shscript syntax/sh.vim
unlet b:current_syntax
syn region tshcontent matchgroup=tshfile  start="^### <.\+\.sh>$"  end="^###"me=s-1 transparent contains=@shscript   nextgroup=tfilecontent,tcontent,tmlcontent,tshcontent,topamcontent

syn include @ocaml syntax/ocaml.vim
unlet b:current_syntax
syn region tmlcontent matchgroup=tmlfile  start="^### <.\+\.ml>$"  end="^###"me=s-1 transparent contains=@ocaml      nextgroup=tfilecontent,tcontent,tmlcontent,tshcontent,topamcontent

" content definition
syn match tfc "^\(###\)\@!.*" contained nextgroup=tfilecontent,tcontent,tmlcontent,tshcontent,topamcontent
syn match tc  "^\(###\|# Return\)\@!.*" contained nextgroup=tfilecontent,tcontent,tmlcontent,tshcontent,topamcontent

" highlighting
hi def link tfc            Include
hi def link tc             String
hi def link trepohash      Constant
hi def link terror         Statement
hi def link tcomment       Comment

hi def link ttcmd          Keyword
hi def link tcontent       Keyword

hi def link ttfile         Directory
hi def link tfilecontent   Directory

hi def link tmlfile        Directory
hi def link tmlcontent     SpecialComment

hi def link tshfile        Directory
hi def link tshcontent     SpecialComment

hi def link topamfile      Directory
hi def link topamcontent   SpecialComment


" define current syntax at the end to permit fenced code blocks
" see https://stackoverflow.com/questions/5176972/trouble-using-vims-syn-include-and-syn-region-to-embed-syntax-highlighting
let b:current_syntax = "opam-reftest"
