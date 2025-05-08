if exists("b:current_syntax")
  finish
endif

" Define the main regions
syn region jjDescription start=/^/ end=/^JJ: ignore-rest$/ contains=jjTitle,jjBody,jjChanges fold

" Title line (first line)
syn match jjTitle "^.*$" contained nextgroup=jjBody

" Body text (between title and JJ: lines)
syn region jjBody contained start=/^/ end=/^JJ:.*$/ contains=jjTitle

" Changes section (lines starting with JJ: before ignore-rest)
syn region jjChanges contained start=/^JJ: This commit contains the following changes:/ end=/^JJ: ignore-rest$/ contains=jjChangeLine

" Individual change lines
syn match jjChangeLine "^JJ:.*$" contained

" Git diff section
syn region jjDiff start=/^JJ: ignore-rest$/ end=/^JJ: Lines starting with "JJ:" (like this one) will be removed\.$/ contains=@gitDiff fold

" Include git diff syntax
syn include @gitDiff syntax/diff.vim

" Define highlighting
hi def link jjTitle Title
hi def link jjBody Normal
hi def link jjChangeLine Comment
hi def link jjDiff Region

let b:current_syntax = "jjdescription"
