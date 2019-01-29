" ####################
" #### Vundle.vim ####
" ####################
"
" Vundle, the plug-in manager for Vim
" http://github.com/VundleVim/Vundle.Vim
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'blueshirts/darcula'
Plugin 'dag/vim-fish'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

call vundle#end()            " required
filetype plugin indent on    " required

" Colorscheme Settings
"autocmd ColorScheme * highlight Normal ctermbg=none
"autocmd ColorScheme * highlight LineNr ctermbg=none

"For those using the fish shell: add set shell=/bin/bash to your .vimrc
set shell=/bin/bash

syntax on
filetype plugin indent on
colorscheme darcula

" General Settings
"set fenc=utf-8
"set nobackup
"set noswapfile
"set autoread
"set hidden
"set showcmd
"set backspace=indent,eol,start

" Visual Settings
set number
"set cursorline
"set virtualedit=onemore
"set smartindent
"set showmatch
"set laststatus=2
"set wildmode=list:longest

" Tab Settings
set list listchars=tab:\▸\-
set expandtab
set tabstop=4
set shiftwidth=4

" Search Settings
"set ignorecase
"set smartcase
"set incsearch
"set wrapscan
"set hlsearch
"nmap <Esc><Esc> :nohlsearch<CR><Esc>
