if !exists(':CtrlP')
	finish
endif

let g:ctrlp_show_hidden = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
nnoremap <leader>m :CtrlPMixed<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
