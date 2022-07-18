set nocompatible

runtime! macros/matchit.vim

" Plugins
call plug#begin('~/.vim/plugged')
    Plug '/opt/homebrew/opt/fzf/'
    Plug 'tpope/vim-fugitive'
    Plug 'nelstrom/vim-blackboard'
    Plug 'dyng/ctrlsf.vim'
    let g:ctrlsf_winsize = '99'
call plug#end()

" Color scheme
colorscheme blackboard
highlight VertSplit cterm=NONE

set path+=**

filetype on
filetype plugin on
filetype indent on
syntax on

set shiftwidth=4
set tabstop=4 softtabstop=4
set expandtab
set smartindent
set nobackup
set noswapfile

set relativenumber
set number
set scrolloff=8
" set nowrap
set incsearch
set smartcase
set showcmd
set showmode
set showmatch
set nohlsearch
set hidden
" Give more space for displaying messages.
set cmdheight=1
set noerrorbells
set history=1000

" If Vim version is equal to or greater than 7.3 enable undofile.
" " This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

set wildmenu
set wildmode=longest,list,full
set wildignore=*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.docx,*.odt,*.ods
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

let mapleader = " "
nnoremap Y y$
nnoremap ; :
nnoremap <C-p> :FZF!<CR>
nnoremap <C-f> :CtrlSF <C-r><C-w>
vnoremap <C-f> :CtrlSF <C-r><C-w>
nnoremap <leader>s :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

" Indenting with tab keys
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Reopen the last edited position in files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

