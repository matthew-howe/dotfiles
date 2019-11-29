" general settings
filetype plugin indent on
syntax on
set autoindent
set backspace=indent,eol,start
set complete+=d
set foldlevelstart=999
set foldmethod=indent
set grepprg=LC_ALL=C\ grep\ -nrsH
set guifont=SF\ Mono:h13
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
set guifont=sf\ mono
colorscheme xcode-low-key
map - :Ex<CR>

" plugins
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-rooter'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'cakebaker/scss-syntax.vim'
Plug 'isRuslan/vim-es6'
call plug#end()
packloadall
silent! helptags ALLall plug#end()

" various autocommands
let g:rooter_silent_chdir = 1
let g:deoplete#enable_at_startup = 1
augroup minivimrc
    autocmd!
    " automatic location/quickfix window
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
    autocmd VimEnter            * cwindow
    " Git-specific settings
    autocmd FileType gitcommit nnoremap <buffer> { ?^@@<CR>|nnoremap <buffer> } /^@@<CR>|setlocal iskeyword+=-
    autocmd FileType java setlocal omnifunc=javacomplete#Complete 
    " highlight colors
augroup END

" commands for adjusting indentation rules manually
command! -nargs=1 Spaces let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " expandtab"   | silent execute "%!expand -it "  . <args> . "" | call winrestview(b:wv) | setlocal ts? sw? sts? et?
command! -nargs=1 Tabs   let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " noexpandtab" | silent execute "%!unexpand -t " . <args> . "" | call winrestview(b:wv) | setlocal ts? sw? sts? et?

" file compiling and execution 
nnoremap ; :
nnoremap ÷ :w<CR>:!node %<CR>
nnoremap ≥ :w<CR>:!python3 %<CR>
nnoremap « :w<CR>:!g++ -std=c++17 %<CR>:!./a.out<CR>

" juggling with jumps
nnoremap ' `

" juggling with files
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path="0;33"', <bang>0)
nnoremap = :Ag<CR>
nnoremap - :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let g:NERDTreeShowLineNumbers=1

" juggling with buffers
nnoremap gb :Buffers<CR>
tnoremap `` <C-\><C-n><C-w><C-w>
nnoremap `` <C-w><C-w>

" juggling with lines of text
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

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

" smooth listing
cnoremap <expr> <CR> <SID>CCR()
function! s:CCR()
    command! -bar Z silent set more|delcommand Z
    if getcmdtype() == ":"
        let cmdline = getcmdline()
            if cmdline =~ '\v\C^(dli|il)' | return "\<CR>:" . cmdline[0] . "jump   " . split(cmdline, " ")[1] . "\<S-Left>\<Left>\<Left>"
        elseif cmdline =~ '\v\C^(cli|lli)' | return "\<CR>:silent " . repeat(cmdline[0], 2) . "\<Space>"
        elseif cmdline =~ '\C^changes' | set nomore | return "\<CR>:Z|norm! g;\<S-Left>"
        elseif cmdline =~ '\C^ju' | set nomore | return "\<CR>:Z|norm! \<C-o>\<S-Left>"
        elseif cmdline =~ '\v\C(#|nu|num|numb|numbe|number)$' | return "\<CR>:"
        elseif cmdline =~ '\C^ol' | set nomore | return "\<CR>:Z|e #<"
        elseif cmdline =~ '\v\C^(ls|files|buffers)' | return "\<CR>:b"
        elseif cmdline =~ '\C^marks' | return "\<CR>:norm! `"
        elseif cmdline =~ '\C^undol' | return "\<CR>:u "
        else | return "\<CR>" | endif
    else | return "\<CR>" | endif
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\%{LinterStatus()}\ %P
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" juggling with git
nnoremap gs :Gstatus<CR>
nnoremap g9 :Gpush origin master<CR>

" speed optimizations
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_max_signs = 1500
let g:gitgutter_diff_args = '-w'

" custom symbols
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = ':'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = "◉"

" color overrrides
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green ctermbg=0
highlight GitGutterChange ctermfg=yellow ctermbg=0
highlight GitGutterDelete ctermfg=red ctermbg=0
highlight GitGutterChangeDelete ctermfg=red ctermbg=0

let g:python3_host_prog = '/usr/bin/python3'

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
