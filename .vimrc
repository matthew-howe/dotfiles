" general settings
filetype plugin indent on
syntax on
set background=dark
set autoindent
set backspace=indent,eol,start
set complete+=d
set foldlevelstart=999
set foldmethod=indent
set grepprg=LC_ALL=C\ grep\ -nrsH
set hidden
set incsearch
set mouse=a
set noswapfile
set path& | let &path .= "**"
set ruler
set number
set shiftround
set shiftwidth=2
set expandtab
set tabstop=2
let &softtabstop = &tabstop
set tags=./tags;,tags;
set wildcharm=<C-z>
set wildmenu
set wildmode=full
set clipboard=unnamed
set splitbelow
set laststatus=2
set wrap linebreak nolist
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set noeb vb t_vb=
set guioptions=

au GUIEnter * set vb t_vb=
runtime macros/matchit.vim
set guifont=consolas

map - :Ex<CR>

" file compiling and execution 
nnoremap ; :
nnoremap ÷ :w<CR>:!node %<CR>
nnoremap ≥ :w<CR>:!python3 %<CR>
nnoremap « :w<CR>:!g++ -std=c++17 %<CR>:!./a.out<CR>

" juggling with jumps
nnoremap ' `
tnoremap `` <C-\><C-n><C-w><C-w>
nnoremap `` <C-w><C-w>

" pair expansion on the cheap
inoremap (<CR> (<CR>)<Esc>O
inoremap (;    (<CR>);<Esc>O
inoremap (,    (<CR>),<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {;    {<CR>};<Esc>O
inoremap {,    {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [;    [<CR>];<Esc>O
inoremap [,    [<CR>],<Esc>O
