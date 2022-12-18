nnoremap <Space>ghi <Cmd>call <SID>open_project_gh('issues')<CR>
nnoremap <Space>ghni <Cmd>call <SID>open_project_gh('issues\/new')<CR>
nnoremap <Space>ghp <Cmd>call <SID>open_project_gh('pulls')<CR>

" 開いているフォルダのレポジトリのurl取得
function! s:get_url_from_remote_name(name) abort
  let cmd = 'git remote get-url '.a:name
  let url = system(cmd)->trim()->expand()
  return url
endfunction

" プロジェクトのuser/repoをurlから取得する
function! s:get_github_repo_user_and_project(url) abort
  let url=substitute(a:url, "\.git$" ,"", "")
  let url=substitute(url, "^https://github\.com/" ,"", "")
  let url=substitute(url, "^git@github\.com:'", "" ,"")
  let url=substitute(url, "^ssh://git@github\.com:'", "" ,"")

  return url
endfunction

" 指定された方式でdenops-gh.vimのバッファを開く
function! s:open_project_gh(option) abort
  let url = <SID>get_url_from_remote_name('origin')
  let repo_info = <SID>get_github_repo_user_and_project(url)
  let buffer_name = "gh:\/\/".repo_info."\/".a:option

  call execute("edit ".buffer_name)
endfunction
