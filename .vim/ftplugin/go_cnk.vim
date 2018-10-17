setlocal noexpandtab
setlocal nolist

" revisit setting these straight in wildignore instead
" but also what about just setting this for the current buffer?
let g:CommandTWildIgnore=&wildignore . ",go-build,vendor"

" " dealing with go-vim's abusive defaults
" " TODO why would this override tag jumping in help files!?
" " TODO <C-w>] mapping
" " TODO ...but vim-go can't find (at least) some defns, so maybe keep the existing mapping
" let g:go_def_mapping_enabled = 0
" nmap <buffer> <C-]> :GoDef<CR>

let g:syntastic_go_checkers = ['golint', 'gofmt']
let g:syntastic_aggregate_errors = 0

let $GOPATH = go#path#Detect()

" TODO keep these local to the buffer
noremap <silent> <leader>gf :GoFmt<CR>
noremap <silent> <leader>gb <Plug>(go-build)
noremap <silent> <leader>gi <Plug>(go-imports)
noremap <silent> <leader>gr <Plug>(go-rename)
noremap <silent> <leader>gv :GoVet<CR>
noremap <silent> <leader>ge :GoErrCheck<CR>
noremap <silent> <leader>gt <Plug>(go-test)
noremap <silent> <leader>gT <Plug>(go-test-compile)
noremap <leader>gc <Plug>(go-coverage-toggle)

" Unimpaired-style mappings
nmap cogf :GoFmtAutoSaveToggle<CR>
