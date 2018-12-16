if !exists(':ALEEnable')
	finish
endif

" next and previous lint error
nnoremap <leader>n :ALENextWrap<CR>
nnoremap <leader>N :ALEPreviousWrap<CR>
