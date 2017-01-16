if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" プラグイン以外のその他設定が続く
" :

" colorscheme
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors

  " tmux上でのTrue Color対応
  " see http://qiita.com/yami_beta/items/ef535d3458addd2e8fbb
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" set airline theme
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tender'
"let g:airline_theme = 'oceanicnext'

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui"))
  let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
  autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No `bg` setting
end
"let g:solarized_termtrans=1

" colorscheme 設定は source 後に行う必要があるので VimEnter で行う。
" 但し Colorscheme イベントの発生が抑制されないよう nested を付ける。
"au MyAutoCmd VimEnter * nested colorscheme tender
"colorscheme tender
colorscheme OceanicNext
"colorscheme solarized8_dark_low
"colorscheme onedark
"autocmd ColorScheme * highlight Normal ctermbg=None
"autocmd ColorScheme * highlight NonText ctermbg=None
syntax enable

 
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
set clipboard&
set clipboard^=unnamedplus
filetype plugin indent on


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" 表示時間
set matchtime=1
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" 長い行の表示
set display=lastline


" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4


" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif


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
" 自動的にquickfix-windowを開く
autocmd QuickFixCmdPost *grep* cwindow

" Mouse
set mouse=a

" ESC キーを押してから挿入モードを出るまでの時間を短くする
" timeoutlen ではなく ttimeoutlen の値を小さくする
set ttimeoutlen=0

" UNDOを保存
set undofile
set undodir=~/.cache/vim-undo


""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


" Mark
"nmap <silent> <A-Left> <C-o>
"nmap <silent> <A-Right> <C-i>


" 数字のインクリメント・デクリメントのマッピングを変更
nnoremap + <C-a>
nnoremap - <C-x>

" 行末までヤンクをYに設定
nnoremap Y y$

" 行頭/行末移動
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^i
noremap <C-e> <Esc>$
noremap <C-a> <Esc>^

" 全選択
noremap <S-a> <Esc>ggVG

"nnoremap <silent> gg :call comfortable_motion#flick(-1000)<CR>
"nnoremap <silent> G :call comfortable_motion#flick(1000)<CR>
"nnoremap <silent> { :call comfortable_motion#flick(-400)<CR>
"nnoremap <silent> } :call comfortable_motion#flick(400)<CR>

" EasyMotion
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_do_mapping = 0

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


