" Vim folding mode for UMN MapServer .map files
" Author:	Schuyler Erle <schuyler@nocat.net> 
" Last Change:	2006 May 04
" Version:	1.0
" Based on an indent folding mode by Jorrit Wiersma and Max Ischenko
"
" To use, copy to your ~/.vim directory and then add the following
" to your .vimrc:
"
" autocmd BufRead *.map source ~/.vim/map_fold.vim

setlocal foldmethod=expr
setlocal foldexpr=GetMapFileFold(v:lnum)
setlocal foldtext=MapFileFoldText()
highlight Folded term=bold ctermfg=white ctermbg=black

function! GetMapFileFold(lnum)
    " If it's a group statement, fold one level
    let line = getline(a:lnum)

    if line =~ '\c^\s*\(CLASS\|CLUSTER\|FEATURE\|JOIN\|LABEL\|LAYER\|LEGEND\|METADATA\|OUTPUTFORMAT\|PROJECTION\|QUERYMAP\|REFERENCE\|SCALEBAR\|STYLE\|SYMBOL\|VALIDATION\|WEB\)\s*\(#.*\)*$'
	return "a1"
    endif

    " if it's an END, unfold one level
    if line =~ '\c^\s*END\s*\(#.*\)*$'
	return "s1"
    endif

    " otherwise...
    return "="
endfunction

function! MapFileFoldText()
  let line = getline(v:foldstart)
  let line3 = substitute(line, '\t', '        ', 'g')
  let line2 = substitute(line3, '^\( *\)', '&+ ', '')

  let i = v:foldstart
  let name = ""
  while i < v:foldend
    let iline = getline(i)
    if iline =~ '\c^\s*\(NAME\|EXPRESSION\|GROUP\)\s\s*'
      let name = substitute(iline, '\c\s*\(NAME\|EXPRESSION\|GROUP\)\s*', '', '')
      break
    endif
    let i = i + 1
  endwhile
  if name != ""
    let line2 = line2 . " " . name
  endif
  return line2 . " "
endfunction

