source ~/.vim/bundle/bundle.vim

set number
set showcmd
set laststatus=2
set showtabline=2
set statusline=%f%(\ [%Y%M]%)%=%-14.(%l,%c%V%)\ %P

nnoremap <leader>n :ALENextWrap<CR>
nnoremap <leader>N :ALEPreviousWrap<CR>
