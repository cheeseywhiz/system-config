" include plugins
source ~/.vim/bundle/bundle.vim

set number
set showcmd
set laststatus=2
set statusline=%f%(\ [%Y%M]%)%=%-14.(%l,%c%V%)\ %P

" easier ex input
nnoremap ; :

" scroll up and down
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" list buffers when changing buffer
nnoremap <leader>b :ls<CR>:b<space>

" search and delete trailing whitespace
nnoremap <leader>w /\s\+$<CR>
nnoremap <leader>dw :s/\s\+$//e<CR>

" plugins

" ale
" next and previous lint error
nnoremap <leader>n :ALENextWrap<CR>
nnoremap <leader>N :ALEPreviousWrap<CR>

" vim-signify
let g:signify_vcs_list = ['git']
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
