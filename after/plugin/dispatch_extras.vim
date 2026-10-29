" dispatch-extras.vim - Extra strategies for dispatch.vim
" Maintainer:   Gergő Sulymosi
"
" Registers the kitty and rex handlers with dispatch.vim.  This lives in
" after/plugin so it runs once dispatch.vim has defined its default
" g:dispatch_handlers; defining the list earlier would discard those defaults.

if exists('g:loaded_dispatch_extras') || !exists('g:dispatch_handlers')
  finish
endif
let g:loaded_dispatch_extras = 1

if get(g:, 'dispatch_extras_no_register')
  finish
endif

" Rank right after tmux, so they win over job and terminal when Vim runs
" inside kitty or rex.  Each handler declines when its terminal isn't present.
let s:position = index(g:dispatch_handlers, 'tmux') + 1
for s:handler in reverse(['kitty', 'rex'])
  if index(g:dispatch_handlers, s:handler) < 0
    call insert(g:dispatch_handlers, s:handler, s:position)
  endif
endfor
unlet s:position s:handler
