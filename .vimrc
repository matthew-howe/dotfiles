" MINIVIMRC

" filetype support
filetype plugin indent on
syntax on
if has("gui_macvim")
    set background=light
	set number
    set guioptions=
    au GUIEnter * set vb t_vb=
else 
    set background=dark
	colorscheme sourcerer
endif
runtime macros/matchit.vim

" various settings
set autoindent
set backspace=indent,eol,start
set complete+=d
set foldlevelstart=999
set foldmethod=indent
set grepprg=LC_ALL=C\ grep\ -nrsH
set guifont=Iosevka:h13
set hidden
set incsearch
set mouse=a
set noswapfile
set path& | let &path .= "**"
set ruler
set shiftround
set shiftwidth=4
set expandtab
set tabstop=4
let &softtabstop = &tabstop
set tags=./tags;,tags;
set wildcharm=<C-z>
set wildmenu
set wildmode=full
set clipboard=unnamed
set splitbelow
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set noeb vb t_vb=

" plugins
call plug#begin()
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/deoplete-clangx'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'deoplete-plugins/deoplete-jedi'
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
Plug 'scrooloose/nerdtree'
call plug#end()
packloadall
silent! helptags ALL


" various autocommands
let g:deoplete#enable_at_startup = 1
augroup minivimrc
    autocmd!
    " automatic location/quickfix window
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
    autocmd VimEnter            * cwindow
    " various adjustments of the default colorscheme
    " autocmd ColorScheme * hi ModeMsg      cterm=NONE ctermbg=green    ctermfg=black
    "             \ hi Search       cterm=NONE ctermbg=yellow   ctermfg=black
    "             \ hi StatusLineNC cterm=bold ctermbg=darkgrey
    "             \ hi Visual       cterm=NONE ctermbg=white    ctermfg=darkblue
    " Git-specific settings
    autocmd FileType gitcommit nnoremap <buffer> { ?^@@<CR>|nnoremap <buffer> } /^@@<CR>|setlocal iskeyword+=-
augroup END

" commands for adjusting indentation rules manually
command! -nargs=1 Spaces let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " expandtab"   | silent execute "%!expand -it "  . <args> . "" | call winrestview(b:wv) | setlocal ts? sw? sts? et?
command! -nargs=1 Tabs   let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " noexpandtab" | silent execute "%!unexpand -t " . <args> . "" | call winrestview(b:wv) | setlocal ts? sw? sts? et?

" compiling 
nnoremap ; :
nnoremap ÷ :w<CR>:!node %<CR>
nnoremap ≥ :w<CR>:!python3 %<CR>
nnoremap « :w<CR>:!g++ -std=c++17 %<CR>:!./a.out<CR>

" juggling with jumps
nnoremap ' `

" juggling with files
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path="0;33"', <bang>0)
nnoremap = :Ag<CR>

" juggling with buffers
nnoremap gb :Buffers<CR>
tnoremap `` <C-\><C-n><C-w><C-w>
nnoremap `` <C-w><C-w>

" juggling with git
nnoremap gs :Gstatus<CR>

" juggling with tags
nnoremap ,j :tjump /
nnoremap ,p :ptjump /

" juggling with definitions
nnoremap ,d :dlist /
nnoremap [D [D:djump<Space><Space><Space><C-r><C-w><S-Left><Left>
nnoremap ]D ]D:djump<Space><Space><Space><C-r><C-w><S-Left><Left>

" juggling with indentation
nnoremap † :set ts=2 noet<CR> :retab!<CR> :set et ts=4<CR> :retab<CR>

" juggling with matches
nnoremap ,i :ilist /
nnoremap [I [I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>
nnoremap ]I ]I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>

" juggling with changes
nnoremap ,; *``cgn
nnoremap ,, #``cgN

" juggling with quickfix entries
nnoremap <End>  :cnext<CR>
nnoremap <Home> :cprevious<CR>

" juggling with lines of text
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" super quick search and replace
nnoremap <Space><Space> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Space>%       :%s/\<<C-r>=expand("<cword>")<CR>\>/

" better completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap        ,,      <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,:      <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,=      <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>

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

" smooth grepping
command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr system(&grepprg . ' <args>')

" smooth searching
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

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

"		git gutter

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
" color overrrides
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green ctermbg=0
highlight GitGutterChange ctermfg=yellow ctermbg=0
highlight GitGutterDelete ctermfg=red ctermbg=0
highlight GitGutterChangeDelete ctermfg=red ctermbg=0
highlight StatusLine guibg=#FFFFFF guifg=#000000

" file explorer
nnoremap - :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
highlight GitGutterAdd    guifg=#878787 guibg=#222222 ctermfg=2
highlight GitGutterChange guifg=#878787 guibg=#222222 ctermfg=3
highlight GitGutterDelete guifg=#878787 guibg=#222222 ctermfg=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
highlight Directory guifg=#7e8aa2 ctermfg=red
let g:NERDTreeHijackNetrw=1
let NERDTreeMinimalUI=1
" file highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', '#185618', '#FFFFFF')
call NERDTreeHighlightFile('ini', 'yellow', 'none', '#078193', '#FFFFFF')
call NERDTreeHighlightFile('md', 'blue', 'none', '#0040CD', '#FFFFFF')
call NERDTreeHighlightFile('yml', 'yellow', 'none', '#384D54', '#FFFFFF')
call NERDTreeHighlightFile('config', 'yellow', 'none', '#384D54', '#FFFFFF')
call NERDTreeHighlightFile('conf', 'yellow', 'none', '#384D54', '#FFFFFF')
call NERDTreeHighlightFile('cfg', 'yellow', 'none', '#384D54', '#FFFFFF')
call NERDTreeHighlightFile('json', 'yellow', 'none', '#40D47E', '#FFFFFF')
call NERDTreeHighlightFile('html', 'yellow', 'none', '#E34C26', '#FFFFFF')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#FFFFFF')
call NERDTreeHighlightFile('css', 'cyan', 'none', '#563D7C', '#FFFFFF')
call NERDTreeHighlightFile('coffee', 'Red', 'none', '#244776', '#FFFFFF')
call NERDTreeHighlightFile('js', 'Red', 'none', '#CCBD51', '#FFFFFF')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#4F5D95', '#FFFFFF')
call NERDTreeHighlightFile('h', 'Magenta', 'none', '#555555', '#FFFFFF')
call NERDTreeHighlightFile('c', 'Magenta', 'none', '#555555', '#FFFFFF')
call NERDTreeHighlightFile('cpp', 'Magenta', 'none', '#F34B7D', '#FFFFFF')
call NERDTreeHighlightFile('hpp', 'Magenta', 'none', '#F34B7D', '#FFFFFF')
call NERDTreeHighlightFile('py', 'Magenta', 'none', '#3572A5', '#FFFFFF')
call NERDTreeHighlightFile('sh', 'Magenta', 'none', '#04133B', '#FFFFFF')
call NERDTreeHighlightFile('txt', 'Magenta', 'none', '#CCCCCC', '#FFFFFF')
call NERDTreeHighlightFile('java', 'Magenta', 'none', '#B07218', '#FFFFFF')
call NERDTreeHighlightFile('vim', 'Magenta', 'none', '#199F4B', '#FFFFFF')
call NERDTreeHighlightFile('kt', 'Magenta', 'none', '#F18E33', '#FFFFFF')

