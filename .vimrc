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
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

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

let mapleader=","       " leader is comma
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

"Mouse click changes cursor location
set mouse=a

"Don't show intro message when starting vim
set shortmess=atI

"Map up/down to be visual line rather than actual
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
