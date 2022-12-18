let g:fzf_preview_git_files_command   = 'git ls-files --exclude-standard | while read line; do if [[ ! -L $line ]] && [[ -f $line ]]; then echo $line; fi; done'
let g:fzf_preview_grep_cmd            = 'rg --line-number --no-heading --color=never --sort=path'
let g:fzf_preview_use_dev_icons       = 1
let g:fzf_preview_default_fzf_options = {
\ '--reverse': v:true,
\ '--preview-window': 'wrap',
\ '--exact': v:true,
\ '--no-sort': v:true,
\ }
"let $FZF_PREVIEW_PREVIEW_BAT_THEME  = '$BAT_THEME'

nnoremap <silent> <Space>gs   :<C-u>FzfPreviewGitStatusRpc<CR>
nnoremap <silent> <Space>gt   :<C-u>FzfPreviewGitActionsRpc<CR>
