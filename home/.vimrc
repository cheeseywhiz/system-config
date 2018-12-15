" include plugins
source ~/.vim/bundle/bundle.vim

set number
set relativenumber
set showcmd
set splitright
set splitbelow
set laststatus=2
set statusline=%f%(\ [%Y%M]%)%=%-14.(%l,%c%V%)\ %P

" toggle relativenumber
nnoremap <leader>r :set relativenumber!<CR>

" easier ex input
nnoremap ; :

" split navigation
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" search and delete trailing whitespace
nnoremap <leader>w /\s\+$<CR>
nnoremap <leader>dw :%s/\s\+$//e<CR>

" ZA = :qa! like ZZ = :wq and ZQ = :q!
nnoremap ZA :qa!<CR>
