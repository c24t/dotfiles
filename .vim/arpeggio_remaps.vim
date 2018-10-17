Arpeggio nnoremap ie :Gstatus<CR>
Arpeggio nnoremap rg /:Glgrep :lopen
Arpeggio nnoremap tr Oimport ipdb; ipdb.set_trace()<esc>

Arpeggio inoremap jk <Esc>
Arpeggio noremap jf :w<CR>"

Arpeggio noremap lkj :NERDTreeToggle<CR>
Arpeggio noremap ;lk :TagbarToggle<CR>

" *window movement* {{{1
Arpeggio noremap wj <C-w>j
Arpeggio noremap wk <C-w>k
Arpeggio noremap wl <C-w>l
Arpeggio noremap wh <C-w>h
Arpeggio noremap WJ <C-w>J
Arpeggio noremap WK <C-w>K
Arpeggio noremap WL <C-w>L
Arpeggio noremap WH <C-w>H
"}}}

" *etc* {{{1
Arpeggio noremap no :noh<CR>
Arpeggio noremap we :set filetype=
Arpeggio noremap uw viwu
Arpeggio noremap UW viwU
"}}}

" vim:foldmethod=marker
" vim:noet:sw=2 ts=2
