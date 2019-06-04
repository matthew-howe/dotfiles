"GENERAL
filetype indent on
filetype plugin on
syntax on
set background=dark
colorscheme apprentice
set autoindent
set backspace=indent,eol,start
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorcolumn
set cursorline
set complete+=d
set foldmethod=indent
set guifont=iosevka\ extralight:h13
set noshowcmd
set regexpengine=1
set ignorecase
set incsearch
set magic
set grepprg=LC_ALL=C\ grep\ -nrsH
set guioptions-=r
set guioptions-=L
set hidden
set laststatus=0
set incsearch
set mouse=a
set number
set expandtab
set noshowmode
set noswapfile
set path& | let &path .= "**"
set ruler
set shiftround
set showmatch
set autochdir
set shiftwidth=0
set textwidth=80
set tabstop=2
set encoding=utf-8
set softtabstop=0
set shiftwidth=2
set splitright
set splitbelow
set tags=./tags;,tags;
set wildcharm=<C-z>
set wildmenu
set wildmode=full
set rtp+=/usr/local/opt/fzf
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=
set statusline=
set columns=124
set colorcolumn=80
set clipboard=unnamed

"KEYMAPS
nnoremap gb :Buffers<CR>
nnoremap ; :
map \] <C-W>w
map æ :terminal node<CR>
map ÷ :w<CR>:!node  %<CR>
noremap j gj
noremap k gk
nnoremap - :NERDTreeToggle<CR>
nnoremap = :Files<CR>
nmap /  <Plug>(incsearch-forward)
nmap ?  <Plug>(incsearch-backward)
nmap g/ <Plug>(incsearch-stay)
nnoremap “ <C-W><C-J>
nnoremap ‘ <C-W><C-K>
nnoremap <D-]> <C-W><C-L>
nnoremap <D-[> <C-W><C-H
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O
nnoremap <C-H> <C-W>h
nnoremap J <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap H ^
nnoremap L $
nnoremap ^ H
nnoremap $ L
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>
nnoremap ¡ :set invnumber<CR>
map <F1> :mksession! ~/current.vim<CR>
map <F2> :source ~/current.vim<CR>
map <F4> :Restart<CR>
nnoremap gs :Gstatus<CR>
nnoremap g/s /\s\+$<CR>
nnoremap g/t /\t<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
map \1 :set columns=80<CR>
map \2 :set columns=160<CR>
map \p :PymodeRun<CR>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"LINTING
let g:ale_sign_error = '✘'
let g:ale_sign_warning = "◉"
highlight ALEErrorSign ctermfg=9 ctermbg=NONE guifg=#C30500 guibg=#222222
highlight ALEWarningSign ctermfg=11 ctermbg=NONE guifg=#ED6237 guibg=#222222

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

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_enabled = 1

if argv(0) ==# '.'
    let g:netrw_browse_split = 0
else
    let g:netrw_browse_split = 4
  endif

"TREE
let NERDTreeQuitOnOpen=1
highlight GitGutterAdd    guifg=#878787 guibg=#222222 ctermfg=2
highlight GitGutterChange guifg=#878787 guibg=#222222 ctermfg=3
highlight GitGutterDelete guifg=#878787 guibg=#222222 ctermfg=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
highlight Directory guifg=#7e8aa2 ctermfg=red

"MISC
tnoremap <silent> ` <c-w>:ToggleTerminal<CR>
nnoremap <silent> ` :ToggleTerminal<CR>
let g:toggle_terminal#command = 'zsh'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
"
"PLUGINS
call plug#begin()
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'hail2u/vim-css3-syntax'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-fugitive'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'haya14busa/incsearch.vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-dadbod'
Plug 'pakutoma/toggle-terminal'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'airblade/vim-gitgutter'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'leafgarland/typescript-vim'
Plug 'ldelossa/vimdark'
Plug 'soywod/kronos.vim'
call plug#end()
packloadall
silent! helptags ALL

let g:pymode_python = 'python3'
let python_highlight_all=1
let g:deoplete#enable_at_startup = 1
let g:ackprg = 'ag --vimgrep'

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path="0;33"', <bang>0)
nnoremap 0 :Ag<CR>
setlocal suffixesadd+=.js
autocmd BufRead scp://* :set bt=acwrite
