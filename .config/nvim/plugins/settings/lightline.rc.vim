let g:lightline = {
  \ 'colorscheme': 'gruvbox_material',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['filepath', 'filename', 'gitbranch'],
  \    ],
  \   'right': [
  \     ['lineinfo'],
  \     ['filetype', 'fileencoding', 'fileformat'],
  \     ['lsp_status'],
  \     ['quickrun'],
  \     ['lsp_ok', 'lsp_info', 'lsp_warnings', 'lsp_errors'],
  \   ],
  \ },
  \ 'tabline': {
  \   'left':  [['buffers']], 
  \   'right': [],
  \ },
  \ 'component': {
  \   'paste': "%{&paste ? 'PASTE' : ''}",
  \  },
  \ 'component_function': {
  \   'mode':             'LightlineMode',
  \   'filepath':         'LightlineFilepath',
  \   'filename':         'LightlineFilename',
  \   'modified_buffers': 'LightlineModified_buffers',
  \   'filetype':         'LightlineFiletype',
  \   'lineinfo':         'LightlineLineinfo',
  \   'fileencoding':     'LightlineFileencoding',
  \   'fileformat':       'LightlineFileformat',
  \   'special_mode':     'LightlineSpecialmode',
  \   'lsp_status':       'lightline#lsp#status',
  \   'gitbranch':        'LightlineGitbranch',
  \   'quickrun':         'LightlineQuickrunRunning',
  \ },
  \ 'component_function_visible_condition': {
  \   'spell': '&spell',
  \   'paste': '&paste',
  \ },
  \ 'component_type': {
  \   'buffers':          'tabsel',
  \   'lsp_errors':       'error',
  \   'lsp_warnings':     'warning',
  \   'lsp_info':         'information',
  \   'lsp_ok':           'ok',
  \   'quickrun':         'quickrun',
  \ },
  \ 'component_expand': {
  \   'lsp_errors':       'lightline#lsp#errors',
  \   'lsp_warnings':     'lightline#lsp#warnings',
  \   'lsp_informations': 'lightline#lsp#infomations',
  \   'lsp_hints':        'lightline#lsp#hints',
  \   'lsp_ok':           'lightline#lsp#ok',
  \   'buffers':          'lightline#bufferline#buffers',
  \   'quickrun':         'LightlineQuickrunRunning',
  \ },
  \ 'enable': {
  \   'statusline': 1,
  \   'tabline':    1,
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }


function! Lightline_is_visible(width) abort
  return a:width < winwidth(0)
endfunction

function! LightlineMode() abort
    return lightline#mode()
endfunction

function! LightlineGitbranch() abort
  return gina#component#repo#branch() == '' ? '' : ' ' . gina#component#repo#branch()
endfunction

function! LightlineFilepath() abort
  let path = fnamemodify(expand('%'), ':p:.:h')
  return path ==# '.' ? '' : path

  let not_home_prefix = match(path, '^/') != -1 ? '/' : ''
  let dirs            = split(path, '/')
  let last_dir        = remove(dirs, -1)
  call map(dirs, 'v:val[0]')

  return len(dirs) ? not_home_prefix . join(dirs, '/') . '/' . last_dir : last_dir
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' [+]' : ''
  return filename . modified
endfunction

function! LightlineFiletype() abort
  if &filetype ==? 'qf' && getwininfo(win_getid())[0].loclist
    return 'LocationList'
  elseif &filetype ==? 'qf' && getwininfo(win_getid())[0].quickfix
    return 'QuickFix'
  else
    return &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' '
  endif
endfunction

function! LightlineLineinfo() abort
  return printf(' %3d:%2d / %d lines [%d%%]',line('.'), col('.'), line('$'), float2nr((1.0 * line('.')) / line('$') * 100.0))
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat . ' ' . WebDevIconsGetFileFormatSymbol() : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineQuickrunRunning()
  return g:quickrun_running_message
endfunction

" lightline-bufferline
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#enable_devicons = 1

" lightline_diagnostics_symbols
let g:lightline_diagnostic_symbol_warnings = ' '
let g:lightline_diagnostic_symbol_errors = ''
let g:lightline_diagnostic_symbol_ok = ' '
let g:lightline_diagnostic_symbol_hints = ' '
let g:lightline_diagnostic_symbol_info = ' '

