execute pathogen#infect()

set term=xterm-256color
set t_Co=256

syntax enable

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indents, Tabs, and Spacing
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Misc Settings and Plugins
let mapleader = "\\"
set number
set foldlevel=100
set foldmethod=indent
set nocompatible
set backspace=indent,eol,start
set shortmess=atI
set hidden
set laststatus=2
set ruler
set scrolloff=3
set wildmenu
set t_vb=
set numberwidth=1

set ttimeout
set ttimeoutlen=20
set notimeout
set lazyredraw
set nopaste

filetype plugin on

func! IsEditCommand()
    if getcmdtype() != ":"
        return 0
    else
        return getcmdline() =~ '^e \|^edit \|^vsp \|^vsplit \|^sp \|^split \|^r \|^read \|^sav \|^saveas \|^Ag '
    endif
endfunc

" Easier window navigation
nnoremap ,h <C-W>h
nnoremap ,l <C-W>l
nnoremap ,k <C-W>k
nnoremap ,j <C-W>j
nnoremap ,H <C-W>H
nnoremap ,L <C-W>L
nnoremap ,K <C-W>K
nnoremap ,J <C-W>J
nnoremap ,x <C-W>x
nnoremap ,o <C-W>o

nnoremap ,/ 5<C-W><
nnoremap ,= 5<C-W>>
nnoremap ,] 5<C-W>+
nnoremap ,[ 5<C-W>-

nnoremap ,d :bd<CR>

nnoremap ,, ,

" Saving shortcuts
cmap w!! w !sudo tee % >/dev/null
cnoreabbrev <expr> %% IsEditCommand() ? expand('%:p:h') : '%%'
com! Wq wq
com! W w
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :wq<CR>

" Misc helpful shortcuts
map <F12> :w !diff % -<CR>
nmap <Space> <Leader>ci
nnoremap <Leader>ev :sp $MYVIMRC<cr>
nnoremap <silent> <CR> :noh<CR>
nnoremap n nzz
vmap <Space> <Leader>cc
vnoremap / <Esc>/\%V
vnoremap <silent> y y`>
vnoremap <silent> p p`]
nnoremap <silent> p p`]
nnoremap gV `[v`]

nnoremap <Leader>? :Gblame<CR>:silent !git show <C-r><C-w><CR><C-l>:q<CR>

" :Gb is ambigous: Gblame, Gbrowse.  I want it to be Gblame
com! Gb Gblame

if has("autocmd")
    aug assorted_niceness
        au!
        " Jump to last known position when reopening a file
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
            \| exe "normal! g'\"" | endif
        " Source various files on save
        au BufWritePost $MYVIMRC :so $MYVIMRC

        au WinEnter * set number
        au WinLeave * set nonumber
        au FileType ruby,html set tabstop=2 | set shiftwidth=2 | set softtabstop=2
    aug END
endif


" Plugin configuration
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='!'
let g:syntastic_style_error_symbol='S✗'
let g:syntastic_style_warning_symbol='S!'

if filereadable(expand("~/.vimrc.local"))
    so ~/.vimrc.local
endif
