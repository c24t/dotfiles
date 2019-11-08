set nocompatible

execute pathogen#infect()

syntax on
filetype plugin indent on

" https://github.com/junegunn/fzf.vim/issues/60#issuecomment-168103057
execute 'set rtp+='.fnamemodify(systemlist('greadlink -f $(which fzf)')[0], ':h:h')

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
set wildignore+=*/__pycache__/

set history=10000
set cmdwinheight=20

set diffopt+=vertical

set switchbuf= " keep focus in same window on e.g. :lnext

set tags=./tags,tags " look in the dir of the open file, then in pwd

set ts=4 " preferred ts/sw for text files
set sw=4
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
let g:CommandTFileScanner='git'
let g:CommandTGitScanSubmodules=1
let g:CommandTGitIncludeUntracked=1
" }}}

" *Tagbar* {{{2
let g:tagbar_left = 1
" }}}

" *NERDTree* " {{{2
let g:NERDTreeIgnore=['__pycache__']
let g:NERDTreeRespectWildIgnore = 1
" }}}

" *Syntastic* {{{2
let g:syntastic_python_checkers=['flake8']
" }}}

" *Grep* {{{2
let Grep_Find_Use_Xargs = 0         " because MacOS's `xargs` isn't really
let Grep_Xargs_Options = '--print0' " ...not that it matters
" }}}

" *ALE* {{{2
let g:ale_set_loclist = 0
let g:ale_linters = { 'python': ['flake8', 'pylint'], }
let g:ale_pattern_options = {'_pb2\(_grpc\)\?\.py$': {'ale_enabled': 0}}
" }}}

" *YouCompleteMe* {{{2
let g:ycm_auto_trigger = 0
let g:ycm_filetype_specific_completion_to_disable = {'gitcommit': 1}
" }}}

" *Black* {{{2
let g:black_linelength = 79
" }}}
" }}}

" *remaps* {{{1
" TODO: http://learnvimscriptthehardway.stevelosh.com/chapters/07.html#local-leader
let mapleader = '\'
let g:mapleader = '\'

" https://vim.fandom.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Trying out FZF instead
" nnoremap <silent> <Leader>t :CommandT<CR>
" nnoremap <silent> <Leader><Leader>t :CommandTTag<CR>
nnoremap <silent> <Leader>b :CommandTMRU<CR>
nnoremap <Leader>cc :CommandTCommand<CR>
nnoremap <Leader>cl :CommandTLine<CR>
nnoremap <Leader>ch :CommandTHistory<CR>
nnoremap <Leader>c? :CommandTHelp<CR>
nnoremap <Leader>cj :CommandTJump<CR>
nnoremap <Leader>c/ :CommandTSearch<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader><leader><tab> :tabedit %<CR>
nnoremap <leader><tab> :tabprevious<CR>

nnoremap <leader>s :sp ~/.vim/snips/python.snippets<CR>

nnoremap yoa :ALEToggleBuffer<CR>
nnoremap yoA :ALEToggle<CR>
nmap coA yoA
nmap coa yoa
" undoing unimpaired maps following the word of god
" https://github.com/tpope/vim-unimpaired/issues/154
" https://github.com/tpope/vim-unimpaired/issues/145
let g:nremap = {"[yy": "", "]yy": "", "[y": "", "]y": ""}
let g:xremap = {"[yy": "", "]yy": "", "[y": "", "]y": ""}
" TODO: get ale plug mappings to accept a count
" see http://vimcasts.org/episodes/creating-mappings-that-accept-a-count/
nmap <silent> ]y <Plug>(ale_next)
nmap <silent> [r <Plug>(ale_previous)

nnoremap <Leader>gdm :Gdiff master<CR>
nnoremap <Leader>gdd :Gdiff<CR>
nnoremap <Leader>gdh :Gdiff HEAD<CR>
nnoremap <Leader>gd1h :Gdiff HEAD^<CR>
nnoremap <Leader>gd2h :Gdiff HEAD^^<CR>
nnoremap <Leader>gd3h :Gdiff HEAD^^^<CR>
nnoremap <Leader>gds :Gdiff stash<CR>
nnoremap <Leader>gdu :Gdiff upstream/master<CR>

nnoremap <Leader>gb :Black<CR>

noremap <Space> i
nnoremap zj 10<C-y>
nnoremap zk 10<C-e>

vnoremap <Leader>@ :norm @q<CR>

" *fzf remaps* {{{2
" Cribbed from https://github.com/junegunn/fzf.vim
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* FZFGgrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
nmap <leader>ff :FZFGgrep<CR>
nnoremap <silent> <Leader>t :Files<CR>
nmap <leader>fa :Ag<CR>
nmap <leader>fi :Lines<CR>
nmap <leader>fl :BLines<CR>
nmap <leader>ft :BTags<CR>
" Let's see if it's better than command-T
nmap <leader><leader>t :Tags<CR>
nmap <leader>fb :BCommits<CR>
nmap <leader>fc :Commits<CR>
nmap <leader>fh <plug>(fzf-maps-n)
nmap <leader>x :Isort<CR>:Black<CR>
" }}}
" }}}

" *keychords* {{{1
call arpeggio#load()
let s:UserArpeggioRemaps="$HOME/.vim/arpeggio_remaps.vim"
execute 'source'.expand(s:UserArpeggioRemaps)
" }}}

" vim:foldmethod=marker
" vim:noet:sw=2:ts=2
