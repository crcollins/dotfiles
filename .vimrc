filetype off                  " required
let mapleader=","       " leader is comma

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'wellle/targets.vim'
Plugin 'lervag/vimtex'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Plugin Configs ==============================

" Vimtex configuration
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


" YouCompleteMe configuration
let g:ycm_autoclose_preview_window_after_insertion = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'


" UltiSnips config
let g:UltiSnipsEditSplit="vertical"
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" General Settings ============================================

syntax enable

"set textwidth=79        " lines longer than 79 columns will be broken
set shiftwidth=4        " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4           " a hard TAB displays as 4 columns
set expandtab           " insert spaces when hitting TABs
set softtabstop=4       " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround          " round indent to multiple of 'shiftwidth'
set autoindent          " align the new line indent with the previous line
set backspace=indent,eol,start
set number              " show line numbers
set cursorline          " show cursor line
set lazyredraw          " lazy redraw screen
set wildmenu            " tab completion for filenames
set showmatch           " show matching {([])}
set incsearch           " search as chars are added
"set hlsearch            " highlight search
set relativenumber      " Display relative line numbers
set number              " display the absolute line number at the line you're on
set pastetoggle=<F2>    " Toggle paste mode
"set mouse=a             " Mouse click changes cursor location
set shortmess=atI       "Don't show intro message when starting vim
set nosmartindent       " Fix indention for comments in python
set ttyfast             " Optimize for fast terminal connections
set ruler               " Show the cursor position

" Fix splitting open directions
set splitbelow
set splitright

" Set undo file
set undodir=~/.vim/undodir
set undofile

" Fix join line
if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j
endif

" Mappings ============================================


noremap <F3> :set invnumber<CR>:set invrelativenumber<CR>
inoremap <F3> <C-O>:set invnumber<CR><C-O>:set invrelativenumber<CR>

"Clear all trailing whitespace"
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


" highlight last inserted text
noremap gV `[v`]

nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"Map up/down to be visual line rather than actual
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" autocenter the things
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" trace
nmap <leader>t oimport pdb; pdb.set_trace()<ESC>

" Alias for fixing stupid typos
command! Wq wq
command! W w
command! Q q


" This should load files to same spot I was before, but it does not work?
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
