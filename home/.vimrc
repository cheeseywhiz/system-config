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

call plug#begin('~/.vim/bundle')

Plug 'vim-scripts/AnsiEsc.vim'
Plug 'w0rp/ale'
Plug 'kien/ctrlp.vim'
Plug 'mhinz/vim-signify'

call plug#end()

" finish here before doing :PlugInstall
" finish

" vim-signify
let g:signify_vcs_list = ['git']
let g:signify_sign_change = '~'
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE

" ale
" next and previous lint error
nnoremap <leader>n :ALENextWrap<CR>
nnoremap <leader>N :ALEPreviousWrap<CR>

" ctrlp.vim
let g:ctrlp_show_hidden = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['mixed']
nnoremap <leader>m :CtrlPMixed<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
