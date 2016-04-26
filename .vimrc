set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugin '2072/PHP-Indenting-for-VIm'

Bundle 'AutoTag'
Bundle 'joonty/vim-phpqa.git'
Bundle 'arnaud-lb/vim-php-namespace'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" PHPQA settings
let g:phpqa_messdetector_ruleset = "/home/rwhite/vendor/phpunit/phpunit/build/phpmd.xml"
let g:phpqa_codesniffer_args = "--standard=PSR2"

" Don't run messdetector on save (default = 1)
let g:phpqa_messdetector_autorun = 0
"
" " Don't run codesniffer on save (default = 1)
let g:phpqa_codesniffer_autorun = 0
"
" " Show code coverage on load (default = 0)
let g:phpqa_codecoverage_autorun = 1

syntax on
set hidden
set wildmenu
set showcmd
set hlsearch
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set mouse=a
set cmdheight=2
set pastetoggle=<F11>
set shiftwidth=4
set expandtab
set tabstop=4
map Y y$
" set tags=tags;/
set tags=tags;,tags.config;,tags.controllers;,tags.models;,tags.repositories;,tags.Rginternal;,tags.services;,tags.tests;,tags.utilities;,tags.views;,tags.vendor;/
set scrolloff=3
let mapleader=","
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" set foldmethod=syntax
" set foldlevelstart=1

" let javaScript_fold=1         " JavaScript
" let php_folding=1             " PHP
" let sh_fold_enabled=1         " sh
" let vimsyn_folding='af'       " Vim script
" let xml_syntax_folding=1      " XML

" hi Folded ctermbg=blue ctermfg=white

" Taglist toggle
map <F12> :TlistToggle<CR>

" NERDtree toggle
map <F10> :NERDTreeToggle<CR>

" Save a file which is read=only wihtout leaving the file you're working on
cmap w!! w !sudo tee % >/dev/null

" Syntax highlighting for pclass files
au BufNewFile,BufRead *.pclass set filetype=php

nmap ,t :!clear && phpunit %<cr>
nmap ,m yiw:!clear && phpunit --filter " %<cr>

" For commenting, use 'gc'

" adding cscope functionality (tracking calls of a particular element across
" files in a project)

" source cscope_maps.vim

" PHP namespace
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
