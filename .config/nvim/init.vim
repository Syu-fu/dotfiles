" ステータスラインを常に表示
set laststatus=2
" LeaderをSpaceに
let mapleader = "\<Space>"
" プラグイン関係
if &compatible
    set nocompatible
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
    let s:toml_dir = '$XDG_CONFIG_HOME/nvim/dein'

    call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})
    call dein#load_toml(s:toml_dir . '/ddc.toml', {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif
if dein#check_install()
    call dein#install()
endif
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
    call map(s:removed_plugins,"delete(v:val,'rf')")
    call dein#recache_runtimepath()
endif
filetype plugin indent on

:set t_Co=256
" setting
"jj=escape
inoremap <silent> jj <ESC>
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" クリップボードの共有
set clipboard+=unnamedplus

" rename tmux window
if $TMUX != ""
  augroup titlesettings
    autocmd!
    autocmd BufEnter * call system("tmux rename-window " . "'[vim] " . expand("%:t") . "'")
    autocmd VimLeave * call system("tmux rename-window zsh")
    autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
  augroup END
endif

" 見た目系
" 行番号を表示
set number
" エラー表示列を常に表示
set signcolumn=yes
" 現在の行を強調表示
"set cursorline
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
" set showmatch
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable
" tmuxでもdark-themeに
" set background=dark

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" キー関連
" Qでexモードに入らない
nnoremap Q <Nop>
" ZZではなく:wqを使う
nnoremap ZZ <Nop>
" ZQではなく:q!を使う
nnoremap ZQ <Nop>
" spaceでカーソルを動かさない
nnoremap <space> <Nop>
  
colorscheme gruvbox-material

" Indent {{{
autocmd FileType javascript      setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType typescript      setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType typescriptreact setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType vue             setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType python          setlocal expandtab   shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType go              setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType json            setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType markdown        setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType html            setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType css             setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType vim             setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType sh              setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType zsh             setlocal expandtab   shiftwidth=2 softtabstop=2 tabstop=2
" }}}3

" HTML {{{
function! s:map_html_keys() abort
  inoremap <silent> <buffer> \\ \
  inoremap <silent> <buffer> \& &amp;
  inoremap <silent> <buffer> \< &lt;
  inoremap <silent> <buffer> \> &gt;
  inoremap <silent> <buffer> \- &#8212;
  inoremap <silent> <buffer> \<Space> &nbsp;
  inoremap <silent> <buffer> \` &#8216;
  inoremap <silent> <buffer> \' &#8217;
  inoremap <silent> <buffer> \" &#8221;
endfunction
autocmd FileType html call <SID>map_html_keys()
" }}}

" リソース関連
let g:loaded_python_provider=0
let g:python3_host_prog='/usr/bin/python3'
let g:loaded_perl_provider=0

