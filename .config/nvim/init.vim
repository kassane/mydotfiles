set spell spelllang=en_us
set undofile
set encoding=utf-8
filetype plugin indent on

if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

autocmd BufEnter * lcd %:p:h

"Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'afshinm/neovim-config'
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'ajh17/VimCompletesMe'
Plug 'ncm2/ncm2'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'luzhlon/xmake.vim'
Plug 'vhdirk/vim-cmake'
Plug 'skywind3000/asyncrun.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/Vimball'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-markdown'
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/neocomplcache.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'tmhedberg/SimpylFold'
Plug 'mhinz/vim-startify'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim'
call plug#end()

"Plugins configs

"gruvbox theme=======
colorscheme gruvbox
set termguicolors
set background=dark

"LSP
"=============================================================================
"C++ (clang)
if executable('clangd')
    augroup lsp_clangd
	autocmd!
	au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
	autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif
"----------------------------------------------------------------------------
"Rust
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif
"-----------------------------------------------------------------------------
"Lua
if executable('lua-lsp')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'lua-lsp',
                \ 'cmd': {server_info->[&shell, &shellcmdflag, 'lua-lsp']},
                \ 'whitelist': ['lua'],
                \ })
endif
"-----------------------------------------------------------------------------
"Zig
if executable('zls')
    au User lsp_setup call lsp#register_server({
        \'name': 'zls',
        \'cmd': {server_info->['zls']},
        \'allowlist': ['zig'],
        \ })
endif
"-----------------------------------------------------------------------------
let g:lsp_format_sync_timeout = 1000
autocmd! BufWritePre *.rs,*.zig,*.go call execute('LspDocumentFormatSync')
"=============================================================================

set hidden

map <C-E> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$']

let g:lsp_fold_enabled = 0
let g:lsp_auto_enabled = 0

let g:syntastic_check_on_open=0

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

autocmd FileType vim let b:vcm_tab_complete = 'vim'
set ignorecase
"===========================================

set foldmethod=indent
set foldlevel=99
"show numbers
set number
set relativenumber
set undodir=~/.config/nvim/undodir
set conceallevel=1
"mouse select support
set mouse=a
set mousehide

set inccommand=split

let mainleader="\<space>"

"Custom keywords
nnoremap <leader>; A;<esc>
"nnoremap <leader>ev :vsplit
nnoremap <c-p> :Files<cr>
nnoremap <c-f> :Ag<space>
