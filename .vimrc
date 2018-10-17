set nocompatible

execute pathogen#infect()

syntax on
filetype plugin indent on

" *options* {{{1
set t_Co=256
colorscheme wombat256mod

set number
set ruler

set hlsearch
set incsearch

set ignorecase
set smartcase

set noerrorbells
set visualbell
set vb t_vb=

set smarttab
set autoindent
set smartindent

set mouse=a
set ttymouse=xterm2

set clipboard=unnamed

set backspace=indent,eol,start
set virtualedit=block,onemore
set scrolloff=2
set sidescrolloff=2

set listchars=tab:>-,trail:*
set list

set nowritebackup               " don't bother making backups
set nobackup                    " ...let alone saving them
set directory=$HOME/.vim/swap// " stop littering .sw*s

set undofile                  " persistent undo!
set undodir=$HOME/.vim/undo//

set wildmenu                            " get wild
set wildignorecase                      " like it sounds
set wildmode=longest:full               " prefix matching for wildmenu
set completeopt+=longest                " insert up to the matched prefix
set wildignore+=*.class,*.o,*.pyc,*.git " unlikely to want to match these
set wildignore+=*/node_modules/*        " fucking node

set history=10000
set cmdwinheight=20

set diffopt+=vertical

set tags=./tags,tags " look in the dir of the open file, then in pwd
" }}}

highlight SpellBad ctermbg=52
highlight Error ctermbg=52

" *plugin options* {{{1
" *Taglist* {{{2
let Tlist_Ctags_Cmd = '/usr/local/brew/bin/ctags'
let Tlist_Show_One_File = 1

if has('python3')
	let g:gundo_prefer_python3 = 1
endif
" }}}

" *Command-T* {{{2
let g:CommandTMaxHeight=20
let g:CommandTScanDotDirectories=1
let g:CommandTCancelMap=['<Esc>', '<C-c>']
" }}}

" *Tagbar* {{{2
let g:tagbar_left = 1
" }}}

" *NERDTree* " {{{2
let g:NERDTreeRespectWildIgnore = 1
" }}}

" *Syntastic* {{{2
let g:syntastic_python_checkers=['flake8']
" }}}

" *Grep* {{{2
let Grep_Find_Use_Xargs = 0         " because MacOS's `xargs` isn't really
let Grep_Xargs_Options = '--print0' " ...not that it matters
" }}}
" }}}

" *remaps* {{{1
" TODO: http://learnvimscriptthehardway.stevelosh.com/chapters/07.html#local-leader
let mapleader = '\'
let g:mapleader = '\'

nnoremap <silent> <Leader>t :CommandT<CR>
nnoremap <silent> <Leader><Leader>t :CommandTTag<CR>
nnoremap <silent> <Leader>b :CommandTBuffer<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader><leader><tab> :tabedit %<CR>
nnoremap <leader><tab> :tabprevious<CR>
nnoremap <silent> <Leader>c :TagbarToggle<CR>
nnoremap coy :SyntasticToggleMode<CR>

nnoremap <Leader>gdm :Gdiff master<CR>
nnoremap <Leader>gdd :Gdiff<CR>
nnoremap <Leader>gdh :Gdiff HEAD<CR>

noremap <Space> i
nnoremap zj 10<C-y>
nnoremap zk 10<C-e>

vnoremap <Leader>@ :norm @q<CR>
" }}}

" *keychords* {{{1
call arpeggio#load()
let s:UserArpeggioRemaps="$HOME/.vim/arpeggio_remaps.vim"
execute 'source'.expand(s:UserArpeggioRemaps)
" }}}


" vim:foldmethod=marker
" vim:noet:sw=2:ts=2
