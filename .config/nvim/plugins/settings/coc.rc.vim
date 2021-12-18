" hiddenが設定されていない場合、TextEditが失敗する可能性があります。
set hidden

" サーバーによっては、バックアップファイルに問題がある場合があります。#649を参照してください。
set nobackup
set nowritebackup

" メッセージの表示を改善
set cmdheight=2

" デフォルトの4000では、診断メッセージの表示が悪くなります。
set updatetime=300

"|in-completion-menu｜のメッセージを出さない。
set shortmess+=c

" 常にサイン欄を表示
set signcolumn=yes

" 文字を先にしてナビゲートするトリガー補完にはタブを使用します。
" コマンド ':verbose imap <tab>' を使用して、タブが他のプラグインによってマッピングされていないことを確認します。
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <c-space>を使用して補完を行う。
inoremap <silent><expr> <c-space> coc#refresh()

" <cr>を使って完了を確認し、`<C-g>u`は現在の位置でundoの連鎖を断ち切ることを意味します。
" Cocは確認時にスニペットと追加編集しかしません。
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" または、vimが対応していれば、以下のように`complete_info`を使います。
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" `[g`と`]g`を使って診断をナビゲートする
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto用キーのリマップ
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Kを使ってプレビューウィンドウにドキュメントを表示
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
    call CocAction('doHover')
"  endif
endfunction

" CursorHoldでカーソル下のシンボルをハイライト
autocmd CursorHold * silent call CocActionAsync('highlight')

" 現在の単語の名前を変更するためのリマップ
map <leader>rn <Plug>(coc-rename)

" フォーマット選択領域のリマップ
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " 指定されたファイルタイプ（複数可）のフォーマットを設定します。
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " ジャンププレースホルダーの署名ヘルプを更新
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 選択された領域のdo codeActionに対するリマップ、例：現在の段落に対する`<leader>aap`。
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" 現在の行のdo codeActionのリマップ
nmap <leader>ac  <Plug>(coc-codeaction)
" 現行ラインのオートフィクス問題を修正
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of
" languageserver.

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
let g:coc_global_extensions = [
  \ 'coc-fzf-preview',
  \ 'coc-eslint',
  \ 'coc-explorer',
  \ 'coc-git',
  \ 'coc-go',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-markdown-preview-enhanced',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-react-refactor',
  \ 'coc-sh',
  \ 'coc-spell-checker',
  \ 'coc-sql',
  \ 'coc-tsserver',
  \ 'coc-ultisnips-select',
  \ 'coc-vimlsp',
  \ 'coc-word',
  \ 'coc-yaml',
  \ ]
" prettier起動
command! -nargs=0 Format :call CocAction('format')
" coc-pairsで{を入力した際の挙動を修正する
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

