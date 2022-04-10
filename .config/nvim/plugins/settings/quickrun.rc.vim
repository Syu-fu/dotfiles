let s:notify_hook = {}
let g:quickrun_running_message = ''
function! s:notify_hook.on_ready(session, context) abort
  let g:quickrun_running_message = '[Quickrun] Running ' . a:session.config.command

  call lightline#update()
endfunction

function! s:notify_hook.on_finish(session, context) abort
  let g:quickrun_running_message = ''
  
  call lightline#update()
endfunction

let g:quickrun_config = {
\ 'tsc': {
\   'command': 'tsc',
\}, 
\}
