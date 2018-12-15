set runtimepath^=~/.vim/bundle/AnsiEsc.vim

set runtimepath^=~/.vim/bundle/vim-signify
let g:signify_vcs_list = ['git']
let g:signify_sign_change = '~'
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE

set runtimepath^=~/.vim/bundle/ale
" next and previous lint error
nnoremap <leader>n :ALENextWrap<CR>
nnoremap <leader>N :ALEPreviousWrap<CR>
