filetype off                  " required
let mapleader=","       " leader is comma

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-fugitive'
Plugin 'PeterRincker/vim-argumentative'

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

"folds?
"set foldenable
"noremap <space> za
noremap gV `[v`]        
" highlight last inserted text

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


" Display relative line numbers
set relativenumber
" display the absolute line number at the line you're on
set number

" Alias for fixing stupid typos
command! Wq wq
command! Q q

set si "smart indent

" Fix splitting open directions
set splitbelow
set splitright

" autocenter the things
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" quick pairs
imap <leader>'  ''<ESC>i
imap <leader>"  ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i
imap <leader>{ {}<ESC>i

" mute arrow keys
nnoremap <down>  <Nop>
nnoremap  <left> <Nop>
nnoremap <right> <Nop>
nnoremap  <up> <Nop>
imap <down>  <Nop>
imap  <left> <Nop>
imap <right> <Nop>
imap  <up> <Nop>
vmap <down>  <Nop>
vmap  <left> <Nop>
vmap <right> <Nop>
vmap  <up> <Nop>
