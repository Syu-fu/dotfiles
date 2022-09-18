call ddu#custom#patch_global({
    \   'ui': 'ff',
    \   'sourceOptions': {
    \     '_': {
    \       'ignoreCase': v:true,
    \       'matchers': ['matcher_substring'],
    \     },
    \     'file_external': {
    \       'matchers': [
    \         'matcher_substring', 'matcher_hidden',
    \       ],
    \     },
    \     'buffer': {
    \       'matchers': [
    \         'matcher_fzf', 'matcher_substring'
    \       ],
    \     },
    \   },
    \   'sourceParams': {
    \     'file_external': {
    \       'cmd': ['git', 'ls-files', '-co', '--exclude-standard'],
    \     },
    \   },
    \   'uiParams': {
    \     'ff': {
    \       'floatingBorder': ['╭','─','╮','│','╯','─','╰','│']->map('[v:val, "Comment"]'),
    \       'split': has('nvim') ? 'floating' : 'horizontal',
    \       'ignoreEmpty': v:false,
    \       'filterSplitDirection': 'floating',
    \       'filterFloatingPosition': 'top',
    \       'autoResize': v:false,
    \       'winCol': &columns / 2 - min([&columns / 2 - 5, 80]),
    \       'winRow': (&lines - min([&lines - 10, 45])) / 2,
    \       'winWidth': min([&columns - 5, 160]),
    \       'winHeight': min([&lines - 10, 45]),
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

"call ddu#custom#patch_local('preview', {
"    \   'uiParams': {
"    \     'ff': {
"    \       'split': has('nvim') ? 'floating' : 'horizontal',
"    \       'ignoreEmpty': v:false,
"    \       'startFilter': v:true,
"    \       'autoAction': {'name': 'preview'},
"    \       'filterSplitDirection': 'floating',
"    \       'filterFloatingPosition': 'top',
"    \       'previewFloating': v:true,
"    \       'previewHeight': min([&lines - 10, 45]),
"    \       'previewVertical': v:true,
"    \       'previewWidth': min([&columns / 2 - 5, 80]),
"    \       'autoResize': v:false,
"    \       'winCol': &columns / 2 - min([&columns / 2 - 5, 80]),
"    \       'winRow': (&lines - min([&lines - 10, 45])) / 2,
"    \       'winWidth': min([&columns / 2 - 5, 80]),
"    \       'winHeight': min([&lines - 10, 45]),
"    \     }
"    \   },
"    \ })

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

command! DduRgLive call <SID>ddu_rg_live()
function! s:ddu_rg_live() abort
  call ddu#start({
        \   'volatile': v:true,
        \   'sources': [{
        \     'name': 'rg', 
        \     'options': {'matchers': []},
        \   }],
        \   'uiParams': {'ff': {
        \     'split': has('nvim') ? 'floating' : 'horizontal',
        \     'ignoreEmpty': v:false,
        \     'startFilter': v:true,
        \     'autoAction': {'name': 'preview'},
        \     'filterSplitDirection': 'floating',
        \     'filterFloatingPosition': 'top',
        \     'previewFloating': v:true,
        \     'previewHeight': min([&lines - 10, 45]),
        \     'previewVertical': v:true,
        \     'previewWidth': min([&columns / 2 - 5, 80]),
        \     'autoResize': v:false,
        \     'winCol': &columns / 2 - min([&columns / 2 - 5, 80]),
        \     'winRow': (&lines - min([&lines - 10, 45])) / 2,
        \     'winWidth': min([&columns / 2 - 5, 80]),
        \     'winHeight': min([&lines - 10, 45]),
        \   }},
        \ })
endfunction
