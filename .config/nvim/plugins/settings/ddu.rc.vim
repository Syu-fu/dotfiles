call ddu#custom#patch_global({
    \   'ui': 'ff',
    \   'sourceOptions': {
    \     '_': {
    \       'ignoreCase': v:true,
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'sourceParams': {
    \     'file_external': {
    \       'cmd': ['git', 'ls-files', '-co', '--exclude-standard'],
    \     },
    \   },
    \   'uiParams': {
    \     'ff': {
    \       'filterSplitDirection': 'floating',
    \       'split': has('nvim') ? 'floating' : 'horizontal',
    \       'filterFloatingPosition': 'top',
    \       'autoAction': {'name': 'preview'},
    \       'autoResize': v:false,
    \       'winCol': &columns / 2 - min([&columns / 2 - 5, 80]),
    \       'winRow': (&lines - min([&lines - 10, 45])) / 2,
    \       'winWidth': min([&columns / 2 - 5, 80]),
    \       'winHeight': min([&lines - 10, 45]),
    \       'previewFloating': v:true,
    \       'previewVertical': v:true,
    \       'previewHeight': min([&lines - 10, 45]),
    \       'previewWidth': min([&columns / 2 - 5, 80]),
    \     }
    \   },
    \   'kindOptions': {
    \     'file': {
    \       'defaultAction': 'open',
    \     },
    \     'action': {
    \       'defaultAction': 'do',
    \     },
    \   },
    \ })

call ddu#custom#patch_local('preview', {
    \   'uiParams': {
    \     'ff': {
    \       'split': has('nvim') ? 'floating' : 'horizontal',
    \       'ignoreEmpty': v:false,
    \       'startFilter': v:true,
    \       'autoAction': {'name': 'preview'},
    \       'filterSplitDirection': 'floating',
    \       'filterFloatingPosition': 'top',
    \     }
    \   },
    \ })

call ddu#custom#patch_global({
    \   'filterParams': {
    \     'matcher_substring': {
    \       'highlightMatched': 'Search',
    \     },
    \     'matcher_fzf': {
    \       'highlightMatched': 'Search',
    \     },
    \   }
    \ })

command! DduProjectFile call <SID>ddu_project_file()
function! s:ddu_project_file() abort
  call ddu#start({
        \   'volatile': v:true,
        \   'sources': [{
        \     'name': 'file_external',
        \   }],
        \   'matchers': [
        \     'matcher_fzf', 'matcher_substring'
        \   ],
        \   'uiParams': {'ff': {
        \     'ignoreEmpty': v:true,
        \     'startFilter': v:true,
        \   }},
        \ })
endfunction

command! DduBuffer call <SID>ddu_buffer()
function! s:ddu_buffer() abort
  call ddu#start({
        \   'volatile': v:true,
        \   'sources': [{
        \     'name': 'buffer',
        \   }],
        \   'matchers': [
        \     'matcher_fzf', 'matcher_substring'
        \   ],
        \   'uiParams': {'ff': {
        \     'ignoreEmpty': v:false,
        \     'startFilter': v:true,
        \     }
        \   },
        \ })
endfunction

command! DduRgLive call <SID>ddu_rg_live()
function! s:ddu_rg_live() abort
  call ddu#start({
        \   'volatile': v:true,
        \   'sources': [{
        \     'name': 'rg', 
        \   }],
        \   'uiParams': {'ff': {
        \     'ignoreEmpty': v:false,
        \     'startFilter': v:true,
        \   }},
        \ })
endfunction

command! DduMemoGrep call <SID>ddu_rg_live_memo()
function! s:ddu_rg_live_memo() abort
  let memolist_path = $HOME.'/Documents/Projects/github.com/Syu-fu/memo'
  call ddu#start({
        \   'volatile': v:true,
        \   'sources': [{
        \     'name': 'rg',
        \     'params': {
        \         'path': memolist_path,
        \       },
        \   }],
        \   'uiParams': {'ff': {
        \     'ignoreEmpty': v:false,
        \     'startFilter': v:true,
        \   }},
        \ })
endfunction

command! DduMemoList call <SID>ddu_memo_list()
function! s:ddu_memo_list() abort
  let memolist_path = $HOME.'/Documents/Projects/github.com/Syu-fu/memo'
  call ddu#start({
        \   'volatile': v:true,
        \   'sources': [{
        \     'name': 'file_rec',
        \     'options': {
        \       'path': memolist_path,
        \     },
        \   }],
        \   'uiParams': {'ff': {
        \     'ignoreEmpty': v:true,
        \     'startFilter': v:true,
        \   }},
        \ })
endfunction
