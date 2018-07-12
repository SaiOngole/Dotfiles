" don't bother with vi compatibility
set nocompatible
execute pathogen#infect()
" enable syntax highlighting
syntax enable
set background=dark
colorscheme solarized

" Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

call vundle#end()

" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

set autoindent
set autoread
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set listchars=tab:▸\ ,trail:▫
set number                                                   " show line numbers
set ruler                                                    " show where you are
set showcmd
set smartcase                                                " case-sensitive search if any caps
set tabstop=4                                                " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc,*.pyc
set wildmenu                                                 " show a navigable menu for tab completion
set hlsearch
set laststatus=2 											" always display status line in all windows
set showtabline=2 											" always display tab line
" Enable basic mouse behavior such as resizing buffers.
set mouse=a

set splitbelow
set splitright

" keyboard shortcuts
let mapleader = ','
noremap <leader>l :Align
nnoremap <leader>a :Ag<space>
nnoremap <leader>t :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>c :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>
set pastetoggle=<leader>z
" better navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" in case you forgot to sudo

" plugin settings
" let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
"
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" use chrome for previews
let vim_markdown_preview_browser='Google Chrome'
let vim_mardown_preview_toggle=3 " disregard images and auto preview on buffer write
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre     *.py :call TrimWhiteSpace()
