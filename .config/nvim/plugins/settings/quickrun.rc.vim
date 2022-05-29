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

nnoremap <silent> <Leader>r :<C-u>QuickRun<CR>
nnoremap <silent><expr> <C-c> quickrun#session#exists() ? '<Cmd>call quickrun#session#sweep()' : '<C-c>'

let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright",
\       "outputter/buffer/opener" : "new",
\       "outputter/buffer/close_on_empty" : v:true,
\       "outputter/buffer/into" : v:true,
\   },
\}
let s:config = {
\ 'tsc': {
\   'command': 'tsc',
\   },
\ 'go/test': {
\   'command': 'go',
\   'exec': '%c test %o',
\   'hook/output_encode/encoding':'utf-8',
\   'hook/cd/directory': '%S:p:h',
\   },
\}

call extend(g:quickrun_config, s:config)
unlet s:config
