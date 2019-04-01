filetype off                  " required
let mapleader=","       " leader is comma

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'wellle/targets.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line

"Clear all trailing whitespace"
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

set pastetoggle=<F2>    " Toggle paste mode
noremap <F3> :set invnumber<CR>:set invrelativenumber<CR>
inoremap <F3> <C-O>:set invnumber<CR><C-O>:set invrelativenumber<CR>

syntax enable
set number             " show line numbers

set cursorline          " show cursor line
set lazyredraw          " lazy redraw screen
set wildmenu            " tab completion for filenames
set showmatch           " show matching {([])}
set incsearch           " search as chars are added
"set hlsearch            " highlight search

" highlight last inserted text
noremap gV `[v`]


nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

"Mouse click changes cursor location
"set mouse=a

"Don't show intro message when starting vim
set shortmess=atI

"Map up/down to be visual line rather than actual
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Display relative line numbers
set relativenumber
" display the absolute line number at the line you're on
set number

" Alias for fixing stupid typos
command! Wq wq
command! W w
command! Q q

" Fix splitting open directions
set splitbelow
set splitright

set undodir=~/.vim/undodir
set undofile

" autocenter the things
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" quick pairs
"imap <leader>'  ''<ESC>i
"imap <leader>"  ""<ESC>i
"imap <leader>( ()<ESC>i
"imap <leader>[ []<ESC>i
"imap <leader>{ {}<ESC>i

" trace
nmap <leader>t oimport pdb; pdb.set_trace()<ESC>

" Fix indention for comments in python
set nosmartindent

" Fix join line
if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j
endif

""""""""""""""""""""""
" Multipurpose tab key: Indent at begining, else complete
"""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" This should load files to same spot I was before, but it does not work?
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
