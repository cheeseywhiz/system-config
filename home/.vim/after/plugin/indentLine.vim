if !exists(':IndentLinesToggle')
	finish
endif

let g:indentLine_color_term = 9
let g:indentLine_char = '|'
let g:indentLine_fileTypeExclude = ['tex', 'json']
