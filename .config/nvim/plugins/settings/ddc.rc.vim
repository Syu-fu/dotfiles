call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('sources', ['nvim-lsp', 'buffer', 'vsnip', 'around', 'file', 'nextword'])
call ddc#custom#patch_global('cmdlineSources', ['cmdline-history', 'cmdline', 'file', 'around'])
call ddc#custom#patch_global('sourceOptions', {
     \ '_': {
     \   'matchers': ['matcher_fuzzy', 'matcher_head'],
     \   'sorters': ['sorter_fuzzy', 'sorter_rank'],
     \   'converters': ['converter_remove_overlap', 'converter_truncate_abbr'],
     \ },
     \ 'around': {
     \   'mark': '[around]',
     \   'matchers': ['matcher_head', 'matcher_length'],
     \ },
     \ 'buffer': {
     \   'mark': '[buffer]',
     \   'matchers': ['matcher_head', 'matcher_length'],
     \   'minAutoCompleteLength': 1,
     \ },
     \ 'cmdline': {
     \   'mark': '[cmdline]',
     \   'forceCompletoinPattern': '\S/\S*',
     \ },
     \ 'cmdline-history': {
     \   'mark': '[history]',
     \   'sorters': [],
     \ },
     \ 'nextword': {
     \   'mark': '[nextword]',
     \   'minAutoCompleteLength': 1,
     \   'maxItems': 10,
     \   'isVolatile': v:true,
     \ }, 
     \ 'nvim-lsp': {
     \   'mark': '[LSP]',
     \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
     \ },
     \ 'file': {
     \   'mark': '[File]',
     \   'isVolatile': v:true,
     \   'minAutoCompleteLength': 1,
     \   'forceCompletionPattern': '\S/\S*',
     \   'sorters': [],
     \ },
     \ 'rg': {
     \   'mark': '[rg]',
     \   'matchers': ['matcher_head', 'matcher_length'],
     \   'minAutoCompleteLength': 1,
     \ },
     \ 'vsnip': {
     \   'mark': 'snippet',
     \   'dup': v:true
     \ },
     \ })

call ddc#custom#patch_global('sourceParams', {
     \ 'around': {'maxSize': 500},
     \ 'limitBytes': 5000000,
     \ 'fromAltBuf': v:false,
     \ 'forceCollect': v:false,
     \ 'nvim-lsp': {'kindLabels': {
     \    "Text": " Text",
     \    "Method": " Method",
     \    "Function": " Function",
     \    "Constructor": " Constructor",
     \    "Field": "ﰠ Field",
     \    "Variable": " Variable",
     \    "Class": "ﴯ Class",
     \    "Interface": " Interface",
     \    "Module": " Module",
     \    "Property": "ﰠ Property",
     \    "Unit": "塞 Unit",
     \    "Value": " Value",
     \    "Enum": " Enum",
     \    "Keyword": " Keyword",
     \    "Snippet": " Snippet",
     \    "Color": " Color",
     \    "File": " File",
     \    "Reference": " Reference",
     \    "Folder": " Folder",
     \    "EnumMember": " EnumMember",
     \    "Constant": " Constant",
     \    "Struct": "פּ Struct",
     \    "Event": " Event",
     \    "Operator": " Operator",
     \    "TypeParameter": "TypeParameter"
     \ }},
     \ })

call ddc#enable()


call ddc#custom#patch_global('autoCompleteEvents', [
    \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
    \ 'CmdlineEnter', 'CmdlineChanged',
    \ ])
" {{{
cnoremap <expr> <Tab>
  \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
  \ ddc#manual_complete()
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
cnoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

augroup MyAutoCmd
  autocmd!
  autocmd CmdlineEnter * call CommandlinePre()
  autocmd CmdlineLeave * call CommandlinePost()
  autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
augroup End


function! CommandlinePre() abort
  call denops#plugin#wait('ddc')

  " Overwrite sources
  let current = ddc#custom#get_current()
  if exists('s:in_cmdline') && s:in_cmdline
    return
  endif

  let s:prev_buffer_sources = current
  if getcmdtype() == '/'
    call ddc#custom#patch_buffer('sources', ['buffer', 'cmdline-history'])
  elseif getcmdtype() == '@'
    call ddc#custom#patch_buffer('sources', ['buffer'])
  else
    call ddc#custom#patch_buffer('sources', ['cmdline','cmdline-history', 'buffer'])
  endif
  let s:in_cmdline = v:true

  " Enable command line completion
  call ddc#enable_cmdline_completion()
endfunction

function! CommandlinePost() abort
  " Restore sources
  call ddc#custom#set_buffer(s:prev_buffer_sources)
  let s:in_cmdline = v:false
endfunction

" Filetype
call ddc#custom#patch_filetype(['help', 'markdown', 'gitcommit', 'text'],
  \ 'sources', ['around', 'buffer', 'rg', 'nextword']
  \ )

"call ddc#custom#patch_filetype(['typescript'],
"  \ 'sources', ['nvim-lsp', 'around']
"  \ )
"
"call ddc#custom#set_context(['typescript', 'vim', 'zsh'],
"  \ { -> s:context_syntax() }
"  \ )
"
"function! s:context_syntax() abort
"  if ddc#syntax#in(['Comment', 'TSComment'])
"    return { 'source': ['around', 'nextword'] }
"  elseif ddc#syntax#in(['String', 'TSString', 'zshComment', 'vimComment', 'vimLineComment'])
"    return { 'source': ['file', 'around', 'nextword'] }
"  else
"    return {}
"  endif
"endfunction

