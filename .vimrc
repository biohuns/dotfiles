" ##########################
" ######### Color ##########
" ##########################

syntax enable
filetype plugin indent on
" darcula theme: https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim
colorscheme darcula

" ##########################
" ##### Character Code #####
" ##########################

" 文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
scriptencoding utf-8

set fileformat=unix     " 改行コードの自動判別
set ambiwidth=double    " □や○文字が崩れる問題を解決

" ##########################
" ######### global #########
" ##########################

set clipboard+=unnamed  " OSのクリップボードを使用する
set nobackup            " バックアップファイルを作らない
set noswapfile          " スワップファイルを作らない
set hidden              " バッファが編集中でもその他のファイルを開けるように
set ttyfast             " ターミナル接続を高速化
set smartindent         " 改行時自動インデント
set number              " 行番号を表示
set list                " 不可視文字を表示
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set incsearch           " インクリメントサーチを有効にする
set hlsearch            " ハイライトサーチを有効にする
set ignorecase          " 検索時大文字小文字を区別しない
set smartcase           " 検索時に大文字を入力した場合ignorecaseが無効になる
set cursorline          " カーソルラインを表示する
set autoread            " ファイル更新で自動で読み直す
set completeopt=menuone " 補完ウィンドウの設定
set visualbell          " ビープ音を可視化
set showmatch           " 括弧入力時の対応する括弧を表示
"set matchtime=3        " 対応括弧の表示秒数を3秒にする
set laststatus=2        " ステータスラインを常に表示
set wrapscan            " 検索時に最後まで行ったら最初に戻る
set title               " タイトルを表示
set cursorline          " カーソルの行数表示
set history=500         " 保存するコマンド履歴の数
set timeout timeoutlen=1000 ttimeoutlen=50    " タイムアウト時間設定

" wildmenuを有効にする
set wildmenu
set wildmode=full

" 1 tab == 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4


set backspace=indent,eol,start    " バックスペースキーの有効化
" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" ##########################
" ######## Key Map #########
" ##########################

" 入力モード中に素早くJJと入力した場合はESCとみなす
inoremap jj <Esc>

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

" 折り返しでも行単位で移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"インサートモードでも移動
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>

" カーソルラインの位置を保存する
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

