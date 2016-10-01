" Some stuff from http://amix.dk/vim/vimrc.html , https://github.com/mony960/dotfiles/blob/master/.vimrc , vim wiki , https://bitbucket.org/jloureiro, https://github.com/scrooloose/vimfiles/blob/master/vimrc#L78 . https://github.com/Valloric/dotfiles/blob/master/vim/vimrc.vim
set nocompatible
filetype off

" Vundle Settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-eunuch'
"Plugin 'tpope/vim-speeddating'
"Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-dispatch'
"Plugin 'tpope/vim-endwise'
"Plugin 'Raimondi/delimitMate'
Plugin 'bkad/CamelCaseMotion'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-git'
Plugin 'gregsexton/gitv'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'gregsexton/MatchTag'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tmhedberg/matchit'
Plugin 'derekwyatt/vim-fswitch'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-scripts/BufOnly.vim'
Plugin 'rking/ag.vim'
Plugin 'Chiel92/vim-autoformat'
"Plugin 'othree/eregex.vim'

"Plugin 'vim-scripts/dbext.vim'
"Plugin 'klen/python-mode'
"Plugin 'davidhalter/jedi-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
"Plugin 'git://git.code.sf.net/p/vim-latex/vim-latex'
Plugin 'elzr/vim-json'
Plugin 'marijnh/tern_for_vim'
Plugin 'pangloss/vim-javascript'
"Plugin 'groenewege/vim-less'
"Plugin 'tpope/vim-haml'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'othree/html5.vim'
"Plugin 'lotheac/pf.vim'

call vundle#end()

" Remove gui stuff
set guioptions-=m " Remove menu bar
set guioptions-=M " System menu not sourced
set guioptions-=T " Remove toolbar
set guioptions-=r " No Right-hand scrollbar
set guioptions-=R " No Right-hand scrollbar on vertial split
set guioptions-=L " No Left-hand scrollbar
set guioptions-=l " No Left-hand scrollbar on split
set guioptions-=b " No bottom scrollbar
set guicursor+=a:blinkon0 " Disable all blinking

" Load ftplugins and indent files
filetype plugin on
filetype indent on

" From here and there
set mat=2 " How many tenths of a second to blink when matching brackets
set showmatch " Show matching brackets when text indicator is over them
set showmode " Show the current mode
set showcmd " Display incomplete commands
set ruler " Show the cursor position
set title " Show title
set cmdheight=1 " Height of the command bar
set list lcs=tab:▷⋅,trail:⋅,nbsp:⋅ " Display tabs and trailing spaces
"set list lcs=trail:·,tab:»· ",eol:¶
set number " Show line numbers
set laststatus=2 " Always show the status line
set hidden  " Allows making buffers hidden even with unsaved changes
set tabpagemax=35

set incsearch " Find as entering pattern
set hlsearch " Highlight search results
set ignorecase " Case insensitive patterns,...
set smartcase " When only lowercase is case doesnt matter
set magic " For regular expressions turn magic on

"set textwidth=79 " Lines longer than x break
set tabstop=2 " No. of spaces for tab in file
set shiftwidth=2 " No. of spaces for step in autoindent
set softtabstop=2 " No. of spaces for tab when editing
set expandtab " Expand tabs into spaces
set smarttab " Smart tabulation and backspace
set autoindent " Enable auto-indentation
set shiftround " Round spaces to nearest shiftwidth multiple
set nojoinspaces " Don't convert spaces to tabs
set smartindent
set pastetoggle=<F6> " Toggles indenting when pasting
set bs=indent,eol,start " Allow backspacing over everything
set backspace=indent,eol,start " Allow backspacing over everything in insert mode, configure backspace so it acts as it should act

" Better split opening From goncalinho
set splitright
set splitbelow

set wrap " Wrap lines
set linebreak " Wrap lines at convenient points

set mouse=a " Enable mouse in all modes
set modelines=0 " Don't use modelines (for security)
set viminfo='20,\"50 " Use a viminfo file,...
set history=1000 " Remember more commands and search history
set undolevels=1000 " Use many levels of undo
set autoread " Auto read when a file is changed from the outside
set nobackup " Turn backup off
set noswapfile " Turn swap off
set nowritebackup

set wildmode=list:longest " Make cmdline tab completion similar to bash
set wildmenu " Enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~,*.pyc " Stuff to ignore when tab completing

" Folding settings
set foldmethod=indent " Fold based on indent
set foldnestmax=3 " Eeepest fold is 3 levels
set nofoldenable " Font fold by default
"set foldlevelstart=99 " All folds open by default

" Misc settings

" https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cnoremap w!! w !sudo tee % >/dev/null

" Run shell in interactive mode
"set shellcmdflag=-ic

set fileformats=unix,dos,mac " Detects unix, dos, mac file formats in that order. And first is used for new buffers.

" From valloric
augroup vimrc
" Automatically delete trailing DOS-returns and whitespace on file open and write.
  autocmd BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
augroup END

let g:EclimCompletionMethod = 'omnifunc'
setlocal ofu=syntaxcomplete#Complete " Enable syntax based omni completion

" Set the leader key
let mapleader = ","
map ç @x

" Fast escape, does not wait for a key if I press just esc;
" which happens because of alt mappings <esc>key
nnoremap <ESC>a <ESC>
vnoremap <ESC>a <ESC>
inoremap <ESC>a <ESC>

" Switch syntax highlighting on, when the terminal has colors. From Valloric
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Set a font if in gui. From vim wiki
if has('gui_running')
  set guifont=sourcecodepro\ 12
endif

" From Tobias Kieslich [tobias funnychar archlinux dot org]
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

set background=dark
colorscheme solarized

"hi MatchParen cterm=bold ctermbg=none ctermfg=208 " Little tweak with the matching parents colors From Goncalinho

" Disable highlight when <leader><CR> is pressed clear the highlight as well as redraw. From scrooloose
map <silent> <leader><CR> :nohls<CR>

" http://vim.wikia.com/wiki/Load_multiple_files_with_a_single_command
com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"

" Close all the buffers. From amix
nnoremap <leader>ba :1,1000 bd!<CR>

nnoremap <leader>bo :BufOnly<CR>

" Go to last buffer
nnoremap gl :b #<CR>
vnoremap gl <ESC>:b #<CR>
nnoremap <leader>bl :b #<CR>
vnoremap <leader>bl <ESC>:b #<CR>
inoremap <leader>bl <ESC>:b #<CR>

" Go to before current buffer
nnoremap gj :let @x="gj" <bar> bnext<CR>
vnoremap gj <ESC> :let @x="gj" <bar> bnext<CR>
nnoremap <leader>bj :bnext<CR>
vnoremap <leader>bj <ESC>:bnext<CR>
inoremap <leader>bj <ESC>:bnext<CR>

" Go to next buffer
nnoremap gk :let @x="gk" <bar> bprevious<CR>
vnoremap gk <ESC> :let @x="gk" <bar> bprevious<CR>
nnoremap <leader>bk :bprevious<CR>
vnoremap <leader>bk <ESC>:bprevious<CR>
inoremap <leader>bk <ESC>:bprevious<CR>

" Switches to the previous buffer that was shown in the current window, but also
" closes the current buffer before switching to the previous one. From valloric
nnoremap <leader>bq <c-^>:bd #<CR>
vnoremap <leader>bq <ESC><c-^>:bd #<CR>
inoremap <leader>bq <ESC><c-^>:bd #<CR>

" Go to some buffer
nnoremap gb :CtrlPBuffer<CR>
vnoremap gb <ESC>:CtrlPBuffer<CR>
nnoremap <leader>bb :CtrlPBuffer<CR>
vnoremap <leader>bb <ESC>:CtrlPBuffer<CR>
inoremap <leader>bb <ESC>:CtrlPBuffer<CR>
nnoremap gB :BufExplorer<CR>
vnoremap gB <ESC>:BufExplorer<CR>
nnoremap <leader>\ :BufExplorer<CR>
vnoremap <leader>\ <ESC>:BufExplorer<CR>
inoremap <leader>\ <ESC>:BufExplorer<CR>
nnoremap <leader>be :BufExplorer<CR>
vnoremap <leader>be <ESC>:BufExplorer<CR>
inoremap <leader>be <ESC>:BufExplorer<CR>
nnoremap <leader>bs :BufExplorerHorizontalSplit<CR>
nnoremap <leader>bp :BufExplorerVerticalSplit<CR>

nmap + <C-W>>
nmap - <C-W><
nmap º <C-W>+
nmap ª <C-W>-

nnoremap <C-W>N :vnew<CR>

nnoremap <leader>wn :new<space>
vnoremap <leader>wn <ESC>:new<space>
inoremap <leader>wn <ESC>:new<space>

nnoremap <leader>wN :vnew<space>
vnoremap <leader>wN <ESC>:vnew<space>
inoremap <leader>wN <ESC>:vnew<space>

nnoremap <leader>ws :split<space>
vnoremap <leader>ws <ESC>:split<space>
inoremap <leader>ws <ESC>:split<space>

nnoremap <leader>wS :split<space>
vnoremap <leader>wS <ESC>:split<space>
inoremap <leader>wS <ESC>:split<space>

nnoremap <leader>wv :vsplit<space>
vnoremap <leader>wv <ESC>:vsplit<space>
inoremap <leader>wv <ESC>:vsplit<space>

nnoremap <leader>wV :vsplit<space>
vnoremap <leader>wV <ESC>:vsplit<space>
inoremap <leader>wV <ESC>:vsplit<space>

nnoremap <leader>wa :sall<CR>
vnoremap <leader>wa <ESC>:sall<CR>
inoremap <leader>wa <ESC>:sall<CR>

nnoremap <leader>wo :only<CR>
vnoremap <leader>wo <ESC>:only<CR>
inoremap <leader>wo <ESC>:only<CR>

nnoremap <leader>wc :close<CR>
vnoremap <leader>wc <ESC>:close<CR>
inoremap <leader>wc <ESC>:close<CR>

" Useful mappings for managing tabs
nnoremap <leader>tn :tabnew<SPACE>
vnoremap <leader>tn <ESC>:tabnew<SPACE>
inoremap <leader>tn <ESC>:tabnew<SPACE>

nnoremap <leader>tN :tabnew<CR>
vnoremap <leader>tN <ESC>:tabnew<CR>
inoremap <leader>tN <ESC>:tabnew<CR>

nnoremap <leader>to :tabonly<CR>
vnoremap <leader>to <ESC>:tabonly<CR>
inoremap <leader>to <ESC>:tabonly<CR>

nnoremap <leader>tc :tabclose<CR>
vnoremap <leader>tc <ESC>:tabclose<CR>
inoremap <leader>tc <ESC>:tabclose<CR>

nnoremap <leader>tm :tabmove<SPACE>
vnoremap <leader>tm <ESC>:tabmove<SPACE>
inoremap <leader>tm <ESC>:tabmove<SPACE>

nnoremap <leader>ta :tab sall<CR>
vnoremap <leader>ta <ESC>:tab sall<CR>
inoremap <leader>ta <ESC>:tab sall<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory. From amix
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<CR>

vnoremap <leader>te <ESC>:tabedit <c-r>=expand("%:p:h")<CR>
inoremap <leader>te <ESC>:tabedit <c-r>=expand("%:p:h")<CR>

" https://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Shortcuts for CtrlP
nnoremap <ESC>d :CtrlPTag<CR>
vnoremap <ESC>d <ESC>:CtrlPTag<CR>
inoremap <ESC>d <ESC>:CtrlPTag<CR>
nnoremap <ESC>D :CtrlPBufTag<CR>
vnoremap <ESC>D <ESC>:CtrlPBufTag<CR>
inoremap <ESC>D <ESC>:CtrlPBufTag<CR>
nnoremap <ESC>q :CtrlPBuffer<CR>
vnoremap <ESC>q <ESC>:CtrlPBuffer<CR>
inoremap <ESC>q <ESC>:CtrlPBuffer<CR>
nnoremap <ESC>Q :CtrlP<CR>
vnoremap <ESC>Q <ESC>:CtrlP<CR>
inoremap <ESC>Q <ESC>:CtrlP<CR>

" Silver Searcher
nnoremap <ESC>r :Ag<space>
vnoremap <ESC>r <ESC>:Ag<space>
inoremap <ESC>r <ESC>:Ag<space>
nnoremap <ESC>R :Ag <C-r>=expand('<cword>')<CR>
vnoremap <ESC>R <ESC>:Ag <C-r>=expand('<cword>')<CR>
vnoremap <ESC>R y <bar> :Ag <C-R>0<CR>
inoremap <ESC>R <ESC>:Ag <C-r>=expand('<cword>')<CR>

nnoremap <leader>e :edit<space>
vnoremap <leader>e <ESC>:edit<SPACE>
inoremap <leader>e <ESC>:edit<SPACE>

nnoremap <leader>E :args<space>
vnoremap <leader>E <ESC>:args<SPACE>
inoremap <leader>E <ESC>:args<SPACE>

" Paste and copy
" Copying Shorcuts
nnoremap <ESC>c "+yy<CR>
vnoremap <ESC>c "+yy<CR>
" Pasting Shorcuts
nnoremap <ESC>v :call PasteMe()<CR>
vnoremap <ESC>v :call PasteMe()<CR>
inoremap <ESC>v <C-O>:call PasteMe()<CR>

function! PasteMe()
    execute "set paste"
    execute "normal \"+p"
    execute "set nopaste"
endfunction

" Treat file as
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.masm set filetype=masm
au BufRead,BufNewFile *.jwasm set filetype=masm
au BufRead,BufNewFile *.gasm set filetype=asm
let g:tex_flavor='latex'
augroup filetypedetect
    au BufNewFile,BufRead pf.conf   setf pf
    au BufNewFile,BufRead pf.conf.* setf pf
augroup END
" This makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts. From valloric
let g:is_posix = 1

" Spell check when writing commit logs - From scrooloose
autocmd filetype svn,*commit* setlocal spell

function! AssemblyCompileJwasm()
  execute "!" . "clear"
  execute "!" . "jwasmCompile" . " " . expand('%:p')
endfunction

function! CleanseTabsSpaces()
  retab
  %s/\s\+$//
endfunction

nnoremap <leader>cts :call CleanseTabsSpaces()<CR>
vnoremap <leader>cts <C-C>:call CleanseTabsSpaces()<CR>
inoremap <leader>cts <C-O>:call CleanseTabsSpaces()<CR>

nnoremap <leader>gst :Gstatus<CR>
inoremap <leader>gst <ESC>:Gstatus<CR>
vnoremap <leader>gst <ESC>:Gstatus<CR>
nnoremap <leader>glo :Git log<CR>
inoremap <leader>glo <ESC>:Git log<CR>
vnoremap <leader>glo <ESC>:Git log<CR>
nnoremap <leader>gdi :Gvdiff<space>
inoremap <leader>gdi <ESC>:Gvdiff<space>
vnoremap <leader>gdi <ESC>:Gvdiff<space>
nnoremap <leader>gdc :Git diff --cached<CR>
inoremap <leader>gdc <ESC>:Git diff --cached<CR>
vnoremap <leader>gdc <ESC>:Git diff --cached<CR>
nnoremap <leader>gad :Gwrite<CR>
inoremap <leader>gad <ESC>:Gwrite<CR>
vnoremap <leader>gad <ESC>:Gwrite<CR>
nnoremap <leader>gco :Gcommit -v<CR>
inoremap <leader>gco <ESC>:Gcommit -v<CR>
vnoremap <leader>gco <ESC>:Gcommit -v<CR>
nnoremap <leader>gca :Gcommit -a -v<CR>
inoremap <leader>gca <ESC>:Gcommit -a -v<CR>
vnoremap <leader>gca <ESC>:Gcommit -a -v<CR>
nnoremap <leader>gpu :Gpush<CR>
inoremap <leader>gpu <ESC>:Gpush<CR>
vnoremap <leader>gpu <ESC>:Gpush<CR>
nnoremap <leader>gpl :Gpull<CR>
inoremap <leader>gpl <ESC>:Gpull<CR>
vnoremap <leader>gpl <ESC>:Gpull<CR>
nnoremap <leader>gcb :Git checkout -b<space>
inoremap <leader>gcb <ESC>:Git checkout -b<space>
vnoremap <leader>gcb <ESC>:Git checkout -b<space>
nnoremap <leader>gch :Git checkout<space>
inoremap <leader>gch <ESC>:Git checkout<space>
vnoremap <leader>gch <ESC>:Git checkout<space>
nnoremap <leader>gre :Gread<space>
inoremap <leader>gre <ESC>:Gread<space>
vnoremap <leader>gre <ESC>:Gread<space>
nnoremap <leader>gme :Gmerge<space>
inoremap <leader>gme <ESC>:Gmerge<space>
vnoremap <leader>gme <ESC>:Gmerge<space>
nnoremap <leader>grh :Git reset HEAD --hard<space>
inoremap <leader>grh <ESC>:Git reset HEAD --hard<space>
vnoremap <leader>grh <ESC>:Git reset HEAD --hard<space>
nnoremap <leader>gfe :Gfetch<space>
inoremap <leader>gfe <ESC>:Gfetch<space>
vnoremap <leader>gfe <ESC>:Gfetch<space>
nnoremap <leader>grm :Gremove<space>
inoremap <leader>grm <ESC>:Gremove<space>
vnoremap <leader>grm <ESC>:Gremove<space>
nnoremap <leader>gmv :Gmove<space>
inoremap <leader>gmv <ESC>:Gmove<space>
vnoremap <leader>gmv <ESC>:Gmove<space>
nnoremap <leader>gbl :Gblame<CR>
inoremap <leader>gbl <ESC>:Gblame<CR>
vnoremap <leader>gbl <ESC>:Gblame<CR>

nnoremap <leader>s :update<CR>
vnoremap <leader>s <C-C>:update<CR>
inoremap <leader>s <C-O>:update<CR>

" Write all changed files, all buffers.
nnoremap <leader>S :wa<CR>
vnoremap <leader>S <C-C>:wa<CR>
inoremap <leader>S <C-O>:wa<CR>

" ZZ for saving an closing
" Quit working buffer if file is unmodified
nnoremap <leader>q :bd<CR>
" Save all buffers and quit
nnoremap <leader>Q :xa<CR>
" Quit current window if file is unmodified. And quit vim if there is just one.
nnoremap <leader>x :q<CR>
" Quit all buffers without saving, there is no prompt!
nnoremap <leader>X :qa!<CR>

" http://vim.wikia.com/wiki/Shifting_blocks_visually
vnoremap < <gv
vnoremap > >gv

" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
nnoremap <Leader>\ :%s/\<<C-r><C-w>\>//gcI<Left><Left><Left><Left>

" From http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Extend path so I can find default compiler headers and other useful stuff
" gf to go to file under curser
" <C-i> , <C-o> for jumps
set path=.,/usr/include/**,,

" Quick
nnoremap <leader>wrc :vsplit $MYVIMRC<CR>
inoremap <leader>wrc <ESC>:vsplit $MYVIMRC<CR>
vnoremap <leader>wrc <ESC>:vsplit $MYVIMRC<CR>
nnoremap <leader>mkf :vsplit %:p:h/../makefile<CR>
inoremap <leader>mkf <ESC>:vsplit %:p:h/../makefile<CR>
vnoremap <leader>mkf <ESC>:vsplit %:p:h/../makefile<CR>
nnoremap <leader>mkc :Make clean -C %:p:h/../<CR>
vnoremap <leader>mkc <ESC>:Make clean -C %:p:h/../<CR>
inoremap <leader>mkc <ESC>:Make clean -C %:p:h/../<CR>
nnoremap <leader>mkd :wa<CR>:Make debug -C %:p:h/../<CR>
vnoremap <leader>mkd <ESC>:wa<CR>:Make debug -C %:p:h/../<CR>
inoremap <leader>mkd <ESC>:wa<CR>:Make debug -C %:p:h/../<CR>
nnoremap <leader>mka :wa<CR>:Make all -C %:p:h/../<CR>
vnoremap <leader>mka <ESC>:wa<CR>:Make all -C %:p:h/../<CR>
inoremap <leader>mka <ESC>:wa<CR>:Make all -C %:p:h/../<CR>
nnoremap <leader>mke :!<C-R>=expand("%:p:h")<CR>/../bin/
vnoremap <leader>mke <ESC>:!<C-R>=expand("%:p:h")<CR>/../bin/
inoremap <leader>mke <ESC>:!<C-R>=expand("%:p:h")<CR>/../bin/

nnoremap <leader>p :cn<CR>
vnoremap <leader>p <ESC>:cn<CR>
inoremap <leader>p <ESC>:cn<CR>
nnoremap <leader>+ :cp<CR>
vnoremap <leader>+ <ESC>:cp<CR>
inoremap <leader>+ <ESC>:cp<CR>
nnoremap <leader>~ :clist<CR>
vnoremap <leader>~ <ESC>:clist<CR>
inoremap <leader>~ <ESC>:clist<CR>

nnoremap <leader>l :lnext<CR>
vnoremap <leader>l <ESC>:lnext<CR>
inoremap <leader>l <ESC>:lnext<CR>
nnoremap <leader>ç :lprevious<CR>
vnoremap <leader>ç <ESC>:lprevious<CR>
inoremap <leader>ç <ESC>:lprevious<CR>
nnoremap <leader>º :llist<CR>
vnoremap <leader>º <ESC>:llist<CR>
inoremap <leader>º <ESC>:llist<CR>

nnoremap <leader>cta :! ctagsGeneric<CR>

" Specify the behavior when switching between buffers. From amix
set switchbuf=useopen,usetab,newtab
set stal=2

" Last position jump
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Spelling from vim wiki
let g:myLang = 0
let g:myLangList = ['pt', 'en', 'nospell']
function! MySpellLang()
" Loop through languages - nospell always at last place
    if g:myLang == 0 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
    if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
    if g:myLang == ( len(g:myLangList) - 1) | setlocal nospell | endif
    echomsg 'language:' g:myLangList[g:myLang]
    let g:myLang = g:myLang + 1
    if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction

function! MyFastTagBarToggle()
  execute "TagbarToggle"
  execute "wincmd l"
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                 "
"            Start of plugin tweaks               "
"                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Other shorcuts
nnoremap <F2> :call MyFastTagBarToggle()<CR>
vnoremap <F2> <ESC>:call MyFastTagBarToggle()<CR>
inoremap <F2> <ESC>:call MyFastTagBarToggle()<CR>

"nnoremap <F3> :NERDTreeTabsToggle<CR>
"vnoremap <F3> <ESC>:NERDTreeTabsToggle<CR>
"inoremap <F3> <ESC>:NERDTreeTabsToggle<CR>
nnoremap <F3> :SyntasticToggleMode<CR>
vnoremap <F3> <ESC>:SyntasticToggleMode<CR>
inoremap <F3> <ESC>:SyntasticToggleMode<CR>

nnoremap <F4> :SyntasticCheck<CR>
vnoremap <F4> <ESC>:SyntasticCheck<CR>
inoremap <F4> <ESC>:SyntasticCheck<CR>

nnoremap <F5> :Autoformat<CR>
vnoremap <F5> <ESC>:Autoformat<CR>
inoremap <F5> <ESC>:Autoformat<CR>

nnoremap <F6> :so $MYVIMRC<CR>
vnoremap <F6> <ESC>:so $MYVIMRC<CR>
inoremap <F6> <ESC>:so $MYVIMRC<CR>

nnoremap <F7> :call MySpellLang()<CR>
vnoremap <F7> <ESC>:call MySpellLang()<CR>
inoremap <F7> <ESC>:call MySpellLang()<CR>

" Vim-json
let g:vim_json_syntax_conceal = 0

" UltiSnips keybindings
let g:UltiSnipsExpandTrigger='<c-e>'
let g:UltiSnipsJumpForwardTrigger='<TAB>'
let g:UltiSnipsJumpBackwardTrigger='<s-TAB>'

" YCM
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚠'
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_echo_current_diagnostic = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_max_diagnostics_to_display = 30
let g:ycm_show_diagnostics_ui = 1

let g:ycm_complete_in_comments = 0
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_key_list_select_completion = ['<TAB>', '<DOWN>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<UP>']
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_detailed_diagnostics = '<leader>o'
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 1

let g:ycm_confirm_extra_conf = 0
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
let g:ycm_use_ultisnips_completer = 1

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_style_warning_symbol='⚠'

let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
let g:syntastic_echo_current_error = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5

let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_aggregate_errors = 1
let g:syntastic_sort_aggregated_errors = 0
let g:syntastic_id_checkers = 1

"let g:syntastic_cpp_checkers=[]
let g:syntastic_c_checkers=['splint']
"let g:syntastic_c_checkers=['gcc', 'splint']
"let g:syntastic_c_check_header = 1
"let g:syntastic_c_no_include_search = 0
"let g:syntastic_c_no_default_include_dirs = 0
"let g:syntastic_c_auto_refresh_includes = 1
"let g:syntastic_c_remove_include_errors = 0
"let g:syntastic_c_errorformat = '%f:%l:%c: %trror: %m'
"let g:syntastic_c_compiler = 'gcc'
"let g:syntastic_c_compiler_options = '-std=c11 -0g -Wall -Wextra -pedantic -Wdouble-promotion -Wshadow -Wfloat-equal'
"let g:syntastic_c_include_dirs = ['includes', 'headers', 'lib', 'include']

"let g:syntastic_cpp_checkers=[]
let g:syntastic_cpp_checkers=['cppcheck', 'cpplint']
"let g:syntastic_cpp_checkers=['cppcheck', 'cpplint', 'gcc']
"let g:syntastic_cppcheck_config_file = ''
let g:syntastic_cpp_cpplint_thres = 5
let g:syntastic_cpp_cpplint_args = '--verbose=3'
"let g:syntastic_cpp_check_header = 1
"let g:syntastic_cpp_no_include_search = 0
"let g:syntastic_cpp_no_default_include_dirs = 0
"let g:syntastic_cpp_auto_refresh_includes = 1
"let g:syntastic_cpp_remove_include_errors = 0
"let g:syntastic_cpp_errorformat = '%f:%l:%c: %trror: %m'
"let g:syntastic_cpp_compiler = 'g++'
"let g:syntastic_cpp_compiler_options = '-std=c++11 -0g -Wall -Wextra -pedantic -Wdouble-promotion -Wshadow -Wfloat-equal'
"let g:syntastic_cpp_include_dirs = ['includes', 'headers', 'lib', 'include']

let g:syntastic_erlang_checkers = ['escript']
let g:syntastic_lua_checkers = ['luac']
let g:synastic_nasm_checkers = ['nasm']

let g:syntastic_perl_checkers = ['perl', 'podchecker', 'perlcritic']
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_lib_path = ['./lib', './lib/auto']
let g:syntastic_perl_perlcritic_thres = 5
"let g:syntastic_perl_perlcritic_args = ''
let g:syntastic_perl_perlcritic_post_args = '--verbose "\%s:\%f:\%l:\%c: \%p: \%m\n"'

let g:syntastic_java_checkers = ['javac', 'checkstyle']
"let g:syntastic_python_checkers = ['python', 'pylint', 'pep8']
let g:syntastic_python_checkers = ['python', 'pylint', 'pyflakes']

"let g:syntastic_css_checkers = ['phpcs', 'recess', 'csslint', 'prettycss']
let g:syntastic_css_checkers = ['recess', 'prettycss']
let g:syntastic_html_checkers = ['jshint', 'w3', 'validator']
let g:syntastic_xhtml_checkers = ['tidy', 'jshint']
"let g:syntastic_javascript_closurecompiler_script = '/run/current-system/sw/bin/closure-compiler'
let g:syntastic_javascript_closurecompiler_script = '/usr/bin/closure'
"let g:syntastic_javascript_checkers = ['gjslint', 'closurecompiler', 'jshint' ]
let g:syntastic_javascript_checkers = ['closurecompiler']
let g:syntastic_javascript_jshint_quiet_messages = { "regex": ["Use '===' to compare with 'null'.", "Use '!==' to compare with 'null'."] }
let g:syntastic_javascript_gjslint_quiet_messages = { "regex": ['Extra space after ","', 'No docs found for member', 'Missing docs for parameter:', 'Line too long'] }
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_xml_checkers = ['xmllint']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_quiet_messages = { "regex": ['Missing file\|class\|function doc comment', 'You must use \\"/\*\*\\" style comments for a function\|file comment'] }

" Vim-airline
let g:airline_powerline_fonts = 0
let g:airline_theme='monochrome'
" http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1

" vim-autoformat
let g:formatprg_c = "astyle"
let g:formatprg_args_c = "--mode=c --style=google"
let g:formatprg_args_cpp = "astyle"
let g:formatprg_args_cpp = "--mode=cpp --style=google"
let g:formatprg_args_java = "astyle"
let g:formatprg_args_java = "--mode=java --style=google"

" Fswitch
nnoremap <leader>fs :FSHere<CR>
vnoremap <leader>fs <ESC>:FSHere<CR>
inoremap <leader>fs <ESC>:FSHere<CR>

nnoremap <leader>fr :FSSplitRight<CR>
vnoremap <leader>fr <ESC>:FSSplitRight<CR>
inoremap <leader>fr <ESC>:FSSplitRight<CR>

" Eregex.vim
"let g:eregex_default_enable = 0
"let g:eregex_forward_delim = '/'
"let g:eregex_backward_delim = '?'

"let g:ctrlp_map = ''
let g:ctrlp_use_caching = 0
" Ignore these directories
set wildignore+=*/build/**

" Eclim
nnoremap <silent> <buffer> <leader>ji :JavaImport<CR>
vnoremap <silent> <buffer> <leader>ji <ESC>:JavaImport<CR>
inoremap <silent> <buffer> <leader>ji <ESC>:JavaImport<CR>
nnoremap <silent> <buffer> <leader>jd :JavaDocSearch -x declarations<CR>
vnoremap <silent> <buffer> <leader>jd <ESC>:JavaDocSearch -x declarations<CR>
inoremap <silent> <buffer> <leader>jd <ESC>:JavaDocSearch -x declarations<CR>

function! StartEclim()
    execute '!/home/hugo/.eclipse/org.eclipse.platform_4.4.1_1543616141_linux_gtk_x86_64/eclimd &'
endfunction


let g:EclimFileTypeValidate = 1
"let g:EclimLogLevel = 'off'
"let g:EclimSignLevel = 'off'
let g:EclimJavaValidate = 1

" Tabularize
" Some stuff from http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
nnoremap <leader>aa :Tabularize /
vnoremap <leader>aa <ESC>:Tabularize /
inoremap <leader>aa <ESC>:Tabularize /
nnoremap <leader>a: :Tabularize /:\zs<CR>
vnoremap <leader>a: <ESC>:Tabularize /:\zs<CR>
inoremap <leader>a: <ESC>:Tabularize /:\zs<CR>
nnoremap <leader>a= :Tabularize /=<CR>
vnoremap <leader>a= <ESC>:Tabularize /=<CR>
inoremap <leader>a= <ESC>:Tabularize /=<CR>
nnoremap <leader>a, :Tabularize /,\zs<CR>
vnoremap <leader>a, <ESC>:Tabularize /,\zs<CR>
inoremap <leader>a, <ESC>:Tabularize /,\zs<CR>

" vim-dispatch
nnoremap <leader>r :Dispatch<CR>
vnoremap <leader>r <ESC>:Dispatch<CR>
inoremap <leader>r <ESC>:Dispatch<CR>
autocmd FileType java let b:dispatch = 'javac %'
autocmd FileType ruby let b:dispatch = 'ruby %'
autocmd FileType python let b:dispatch = 'python %'
autocmd FileType prolog let b:dispatch = '/opt/sicstus4.3.0/bin/sicstus -l %'
autocmd FileType masm map <leader>r :call AssemblyCompileJwasm()<CR>

" From tpope / cucumbertables.vim
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

" Pyclewn configuration and keybindings
let g:pyclewn_args="--gdb=async"

" Keybindings from http://pyclewn.sourceforge.net/_static/pyclewn.html some
" with a few changes
nnoremap <leader>dpr :Crun<CR>
vnoremap <leader>dpr <ESC>:Crun<CR>
inoremap <leader>dpr <ESC>:Crun<CR>
nnoremap <leader>dpR :call PyclewnIfNotOn()<CR><CR>:Cfile <C-R>=expand("%:p:h")<CR>/../bin/<C-a> <Bar> sleep 50m <Bar> Cbreak main <Bar> Crun <CR>
vnoremap <leader>dpR <ESC>:call PyclewnIfNotOn()<CR><CR>:Cfile <C-R>=expand("%:p:h")<CR>/../bin/<C-a> <Bar> sleep 50m <Bar> Cbreak main <Bar> Crun <CR>
inoremap <leader>dpR <ESC>:call PyclewnIfNotOn()<CR><CR>:Cfile <C-R>=expand("%:p:h")<CR>/../bin/<C-a> <Bar> sleep 50m <Bar> Cbreak main <Bar> Crun <CR>

nnoremap <leader>dps :call PyclewnIfNotOn()<CR><CR>:Cfile <C-R>=expand("%:p:h")<CR>/../bin/<C-a> <Bar> sleep 50m <Bar> Cbreak main<CR>
vnoremap <leader>dps <ESC>:call PyclewnIfNotOn()<CR><CR>:Cfile <C-R>=expand("%:p:h")<CR>/../bin/<C-a> <Bar> sleep 50m <Bar> Cbreak main<CR>
inoremap <leader>dps <ESC>:call PyclewnIfNotOn()<CR><CR>:Cfile <C-R>=expand("%:p:h")<CR>/../bin/<C-a> <Bar> sleep 50m <Bar> Cbreak main<CR>
nnoremap <leader>dpS :call PyclewnIfNotOn()<CR><CR>:Cfile <C-R>=expand("%:p:h")<CR>/../bin/<C-a>
vnoremap <leader>dpS <ESC>:call PyclewnIfNotOn()<CR><CR>:Cfile <C-R>=expand("%:p:h")<CR>/../bin/
inoremap <leader>dpS <ESC>:call PyclewnIfNotOn()<CR><CR>:Cfile <C-R>=expand("%:p:h")<CR>/../bin/
nnoremap <leader>dpc :nbclose<CR>
vnoremap <leader>dpc <ESC>:nbclose<CR>
inoremap <leader>dpc <ESC>:nbclose<CR>

nnoremap <leader>dw :exe "Cbreak " . expand("%:p") . ":" . line(".")<CR>

" Mapped dF to cWORD which is counter intuitive cause I use it lots more
nnoremap <leader>dd :exe "Cprint " . expand("<cWORD>")<CR>
nnoremap <leader>dD :exe "Cprint " . expand("<cword>")<CR>

nnoremap <leader>dj :Cup<CR>
nnoremap <leader>dk :Cdown<CR>
nnoremap <leader>dT :Cbacktrace<CR>
nnoremap <leader>df :Cfinish<CR>
nnoremap <leader>dc :Ccontinue<CR>
nnoremap <leader>dr :Crun<CR>
nnoremap <leader>dx :Cdelete<CR>

nnoremap <silent><leader>ds :let @x="<leader>ds" <bar> Cstep <bar> sleep 80m <bar> normal zz<CR>
nnoremap <silent><leader>dS :let @x="<leader>dS" <bar> Cstepi <bar> sleep 80m <bar> normal zz<CR>
nnoremap <silent><leader>dc :let @x="<leader>dc" <bar> Ccontinue<CR>
nnoremap <silent><leader>da :let @x="<leader>da" <bar> Cnext <bar> sleep 80m <bar> normal zz<CR>
nnoremap <silent><leader>dA :let @x="<leader>dA" <bar> Cnexti <bar> sleep 80m <bar> normal zz<CR>

function! PyclewnIfNotOn()
    if !has("netbeans_enabled")
        execute "Pyclewn"
    endif
endfunction

" CamelCaseMotion
map <silent> <ESC>w <Plug>CamelCaseMotion_w
map <silent> <ESC>b <Plug>CamelCaseMotion_b
map <silent> <ESC>e <Plug>CamelCaseMotion_e

" Easymotion
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
"let g:EasyMotion_smartcase = 1

"nmap <ESC>w <Plug>(easymotion-w)
"vmap <ESC>w <ESC><Plug>(easymotion-w)
"imap <ESC>w <ESC><Plug>(easymotion-w)
"nmap <ESC>W <Plug>(easymotion-W)
"vmap <ESC>W <ESC><Plug>(easymotion-W)
"imap <ESC>W <ESC><Plug>(easymotion-W)
"nmap <ESC>e <Plug>(easymotion-e)
"vmap <ESC>e <ESC><Plug>(easymotion-e)
"imap <ESC>e <ESC><Plug>(easymotion-e)
"nmap <ESC>E <Plug>(easymotion-E)
"vmap <ESC>E <ESC><Plug>(easymotion-E)
"imap <ESC>E <ESC><Plug>(easymotion-E)
"nmap <ESC>t <Plug>(easymotion-t)
"vmap <ESC>t <ESC><Plug>(easymotion-t)
"imap <ESC>t <ESC><Plug>(easymotion-t)
"nmap <ESC>T <Plug>(easymotion-T)
"vmap <ESC>T <ESC><Plug>(easymotion-T)
"imap <ESC>T <ESC><Plug>(easymotion-T)
"nmap <ESC>f <Plug>(easymotion-f)
"vmap <ESC>f <ESC><Plug>(easymotion-f)
"imap <ESC>f <ESC><Plug>(easymotion-f)
"nmap <ESC>F <Plug>(easymotion-F)
"vmap <ESC>F <ESC><Plug>(easymotion-F)
"imap <ESC>F <ESC><Plug>(easymotion-F)
"nmap <ESC>b <Plug>(easymotion-b)
"vmap <ESC>b <ESC><Plug>(easymotion-b)
"imap <ESC>b <ESC><Plug>(easymotion-b)
"nmap <ESC>B <Plug>(easymotion-B)
"vmap <ESC>B <ESC><Plug>(easymotion-B)
"imap <ESC>B <ESC><Plug>(easymotion-B)
"nmap <ESC>n <Plug>(easymotion-n)
"vmap <ESC>n <ESC><Plug>(easymotion-n)
"imap <ESC>n <ESC><Plug>(easymotion-n)
"nmap <ESC>N <Plug>(easymotion-N)
"vmap <ESC>N <ESC><Plug>(easymotion-N)
"imap <ESC>N <ESC><Plug>(easymotion-N)
"nmap <ESC>h <Plug>(easymotion-linebackward)
"vmap <ESC>h <ESC><Plug>(easymotion-linebackward)
"imap <ESC>h <ESC><Plug>(easymotion-linebackward)
"nmap <ESC>j <Plug>(easymotion-j)
"vmap <ESC>j <ESC><Plug>(easymotion-j)
"imap <ESC>j <ESC><Plug>(easymotion-j)
"nmap <ESC>k <Plug>(easymotion-k)
"vmap <ESC>k <ESC><Plug>(easymotion-k)
"imap <ESC>k <ESC><Plug>(easymotion-k)
"nmap <ESC>l <Plug>(easymotion-lineforward)
"vmap <ESC>l <ESC><Plug>(easymotion-lineforward)
"imap <ESC>l <ESC><Plug>(easymotion-lineforward)
"nmap <ESC>g <Plug>(easymotion-sn)
"vmap <ESC>g <ESC><Plug>(easymotion-sn)
"imap <ESC>g <ESC><Plug>(easymotion-sn)
"nmap <ESC>G <ESC><Plug>(easymotion-tn)
"vmap <ESC>G <ESC><Plug>(easymotion-tn)
"imap <ESC>G <ESC><Plug>(easymotion-tn)

" Jedi Remove \ if uncommented
"let g:jedi#goto_assignments_command = \"<leader>pa"
"let g:jedi#goto_definitions_command = \"<leader>pd"
"let g:jedi#documentation_command = \"<leader>pd"
"let g:jedi#usages_command = \"<leader>pu"
"let g:jedi#completions_command = \"<C-space>"
"let g:jedi#rename_command = \"<leader>pr"

augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END
