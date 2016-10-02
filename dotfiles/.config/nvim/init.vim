" neovim*python ---------------------- {{{
" https://neovim.io/doc/user/nvim_python.html
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
" }}}

" Pluggins --------------------------- {{{
call plug#begin('~/.config/nvim/plugged')
  " The ultimate snippet solution for Vim
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

  " Generates config files for YouCompleteMe
  Plug 'rdnetto/YCM-Generator', {'branch': 'stable', 'for': ['c', 'cpp']}

  " A command-line fuzzy finder written in Go
  Plug 'junegunn/fzf'

  " Fzf-based commands and mappings
  Plug 'junegunn/fzf.vim'

  " A Vim alignment plugin
  Plug 'junegunn/vim-easy-align'

  " status/tabline for vim that's light as air
  Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

  " An asynchronous markdown preview plugin for Neovim
  "function! BuildComposer(info)
  "  if a:info.status != 'unchanged' || a:info.force
  "    !cargo build --release
  "    UpdateRemotePlugins
  "  endif
  "endfunction
  "Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

  " View and grep man pages in vim
  Plug 'vim-utils/vim-man'

  " Debugger integration with a focus on ease-of-use
  Plug 'critiqjo/lldb.nvim', {'for': ['c', 'cpp', 'rust', 'swift']}

  " A plugin for asynchronous :make using Neovim's job-control functionality
  Plug 'benekastah/neomake'

  " A code-completion engine for Vim
  Plug 'Valloric/YouCompleteMe'

  " Go development plugin for Vim
  Plug 'fatih/vim-go'

  " Typescript syntax files for Vim
  Plug 'leafgarland/typescript-vim'

  " Vim plug for switching between companion source files
  Plug 'derekwyatt/vim-fswitch', {'for': ['c', 'cpp']}

  " precision colorscheme for the vim text editor
  Plug 'altercation/vim-colors-solarized'

  " quoting/parenthesizing made simple
  Plug 'tpope/vim-surround'

  " file :Remove, :Unlink, :Rename, :Mkdir, etc
  Plug 'tpope/vim-eunuch'

  " Enable repeating supported plugin maps with .
  Plug 'tpope/vim-repeat'

  " Vim plugin that displays tags in a window, ordered by scope
  Plug 'majutsushi/tagbar'

  " Provide easy code formatting in Vim by integrating existing code formatters
  Plug 'Chiel92/vim-autoformat'

  " Vim motions on speed!
  Plug 'easymotion/vim-easymotion' | Plug 'haya14busa/vim-easyoperator-line' | Plug 'haya14busa/vim-easyoperator-phrase'

  " Improved incremental searching for Vim
  Plug 'haya14busa/incsearch.vim'

  " Preview colours in source code while editing
  Plug 'ap/vim-css-color', {'for': ['css', 'html', 'javascript', 'json', 'less', 'python', 'sass', 'scss', 'stylus', 'vim', 'xdefaults', 'yaml']}

  " A Git wrapper so awesome, it should be illegal
  Plug 'tpope/vim-fugitive'

  " Vim Git runtime files
  Plug 'tpope/vim-git'

  " An extensible & universal comment vim-plugin that also handles embedded filetypes
  Plug 'tomtom/tcomment_vim'

  " A tree explorer plugin for vim
  Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

  " A better JSON for Vim
  Plug 'elzr/vim-json', {'for': 'json'}

  " Add CSS3 syntax support
  Plug 'hail2u/vim-css3-syntax', {'for': 'css'}

  " HTML5 omnicomplete and syntax
  Plug 'othree/html5.vim'

  " Vim plugin, insert or delete brackets, parens, quotes in pair
  Plug 'jiangmiao/auto-pairs'

  " Vastly improved Javascript indentation and syntax support in Vim
  Plug 'pangloss/vim-javascript', {'for': 'javascript'}

  " A Vim plugin that always highlights the enclosing html/xml tags
  Plug 'Valloric/MatchTagAlways', {'for': ['jinja', 'xhtml', 'xml', 'html', 'django', 'htmldjango', 'eruby']}

  " Extended % matching for HTML, LaTeX, and many other languages
  Plug 'benjifisher/matchit.zip'

  " Emmet for vim
  Plug 'mattn/emmet-vim', {'for': ['css', 'haml', 'html', 'jade', 'less', 'sass', 'scss', 'slim']}

  " Vim plugin that provides additional text objects
  Plug 'wellle/targets.vim'
call plug#end()
" }}}

" *augroup*nvimrc*reset -------------- {{{
augroup nvimrc
  autocmd!
augroup END
" }}}

" *color*settings -------------------- {{{
" Switch syntax highlighting on, when the terminal has colors. From Valloric
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark
  colorscheme solarized
  hi MatchParen cterm=bold ctermbg=none ctermfg=208 " Little tweak with the matching parents colors
endif
" }}}

" *gui*elements ---------------------- {{{
set guioptions-=m         " Remove menu bar
set guioptions-=M         " Do not source the menu script
set guioptions-=T         " Remove toolbar
set guioptions-=r         " No Right-hand scrollbar
set guioptions-=R         " No Right-hand scrollbar on vertial split
set guioptions-=L         " No Left-hand scrollbar
set guioptions-=l         " No Left-hand scrollbar on split
set guioptions-=b         " No bottom scrollbar
set guicursor+=a:blinkon0 " Disable all blinking

if has('gui_running')
  set guifont=Source\ Code\ Pro\ for\ Powerline\ 14
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif
" }}}

" *vim*general ------------------------------ {{{
filetype plugin on
filetype indent on

" Display tabs, trailing spaces and eol
set listchars=tab:▸\ ,trail:⋅,nbsp:⋅,eol:¶
set tabpagemax=50
set mat=2                            " How many tenths of a second to blink when matching brackets
set showmatch                        " Show matching brackets when text indicator is over them
set showmode                         " Sow the current mode
set showcmd                          " Display incomplete commands
set ruler                            " Show the cursor position
set title                            " Show title
set cursorline                       " Highlight the current line
set cmdheight=1                      " Height of the command bar
set number                           " Show line numbers
set relativenumber                   " Use relative line numbering
set laststatus=2                     " Always show the status line
set hidden                           " Allows making buffers hidden even with unsaved changes

" *search*settings -------------------------- {{{
set incsearch                        " Find as entering pattern
set hlsearch                         " Highlight search results
set ignorecase                       " Case insensitive patterns,...
set smartcase                        " When only lowercase is case doesnt matter
set magic                            " For regular expressions turn magic on
" }}}

" *tab*indent*settings ----------------------------- {{{
set tabstop=2                        " No. of spaces for tab in file
set shiftwidth=2                     " No. of spaces for step in autoindent
set softtabstop=2                    " No. of spaces for tab when editing
set expandtab                        " Expand tabs into spaces
set smarttab                         " Smart tabulation and backspace
set autoindent                       " Enable auto-indentation
set shiftround                       " Round spaces to nearest shiftwidth multiple
set nojoinspaces                     " Don't convert spaces to tabs
set nosmartindent                    " Do not do smart autoindenting when starting a new line
set cindent                          " Do restricted smart indent for c
"set textwidth=80                    " Lines longer than x break
set formatoptions=tcroqnj            " see help formatoptions
" }}}

set backspace=indent,eol,start       " Allow backspacing over everything in insert mode
set iskeyword+=_,$,@,%,#             " these characters should not be dividers

" Better split opening
set splitright
set splitbelow

set wrap                             " Wrap lines
set linebreak                        " Wrap lines at convenient points

set mouse=a                          " Enable mouse in all modes
set modelines=0                      " Don't use modelines (for security)
set history=1024                     " Remember more commands and search history
set undolevels=1024                  " Use many levels of undo
set autoread                         " Auto read when a file is changed from the outside
set nobackup                         " Turn backup off
set noswapfile                       " Turn swap off
set nowritebackup

set completeopt=menu,menuone,longest " longest: only insert the longest common text of the matches
set switchbuf=useopen,usetab

let mapleader=" "                    " Set the <leader> key
let maplocalleader=" "               " Set the <localleader> key
" }}}

" *bash*highlighted ------------------------- {{{
" Highligh shell scripts as bash scripts
let g:is_posix = 1
" }}}

" *wild*settigs ----------------------------- {{{
set wildmode=longest,list,full                       " complete, then list, then scroll through matches
set wildmenu                                         " Enable ctrl-n and ctrl-p to scroll through matches
set wildignore+=*.o,*.obj,.git,*.pyc,*.so,*~,*.class " Stuff to ignore when tab completing
" }}}

" *folding*settings ------------------------- {{{
set foldmethod=indent                        " Fold based on indent
set foldnestmax=3                            " maximum nesting of folds for the indent and syntax methods
set foldlevelstart=99                        " all folds open by default
" }}}

" *file*format*tweaks ----------------------- {{{
set fileformats=unix,dos,mac                 " Detects unix, dos, mac file formats in that order. And first is used for new buffers.
" }}}

" *Unicode*support -------------------------- {{{
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif
" }}}

" *clean*trash*chars*on --------------------- {{{
function! Clean_trash_chars_and_retab()
  retab
  %s/[\r \t]\+$//
endfunction
" Automatically delete trailing DOS-returns and whitespace on file open and write.
augroup nvimrc
  autocmd BufRead,BufWritePre,FileWritePre * silent! :call Clean_trash_chars_and_retab()
augroup END
" }}}

" *jump*last*position ----------------------- {{{
" :help restore-cursor
augroup nvimrc
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup nvimrc
" }}}

" *auto*quickfix*window --------------------- {{{
" From http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
augroup nvimrc
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
augroup nvimrc
" }}}

" *very*magic*substitute -------------------- {{{
" http://vim.wikia.com/wiki/Simplifying_regular_expressions_using_magic_and_no-magic
"cnoremap s/ s/\v
"cnoremap %s/ %s/\v
" }}}

" *no*indent*files -------------------------- {{{
autocmd nvimrc FileType text,markdown,gitcommit set nocindent
" }}}

" *shift*visually --------------------------- {{{
" http://vim.wikia.com/wiki/Shifting_blocks_visually
vnoremap < <gv
vnoremap > >gv
" }}}

" *vim*extend*path -------------------------- {{{
set path=.,/usr/include/**,/usr/local/include/**,,
" }}}

" *suffixes*low*priority -------------------- {{{
" Suffixes that get lower priority when doing tab completion for filenames.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" }}}

" *vim*spelling ----------------------------- {{{
" http://vim.wikia.com/wiki/Toggle_spellcheck_with_function_keys
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

au nvimrc FileType gitcommit setlocal spell! spelllang=en
" }}}

" *filetype*settings ------------------------ {{{

augroup nvimrc
  au FileType vim
        \ set foldmethod=marker
augroup END

" }}}

" *center*visual ---------------------------- {{{
" http://stackoverflow.com/questions/26137838/vim-centering-text-within-selection
function! GetVisual()
    try
        let v_save = @v
        normal! gv"vy
        return @v
    finally
        let @v = v_save
    endtry
endfunction

function! CenterMe()
    let v = GetVisual()
    "let l = getline('.')
    let lre = '^\zs\s*\ze\S'
    let rre = '\s*$'
    let sp= matchstr(v,lre)
    let sp .= matchstr(v,rre)
    let ln=len(sp)
    let v = substitute(v,lre,sp[:ln/2-1],'')
    let v = substitute(v,rre,sp[ln/2:],'')
    let ve_save = &virtualedit
    let v_save = @v
    let &virtualedit = 'all'
    call setreg('v', v,visualmode())
    normal! gvx"vP
    let @v = v_save
    let &virtualedit = ve_save
endf
"}}}

" *nvim*fast*keybindings -------------------- {{{

" Repeat saved colon command
function! CopyLastColonCommandToRegister(register)
    call setreg(a:register, ":" . @: . "\r")
endfunction
nnoremap <M-;> @x
vnoremap <M-;> <ESC>@x
inoremap <M-;> <ESC>@x
nnoremap <M-:> :call CopyLastColonCommandToRegister("x")<CR>
inoremap <M-:> <ESC>:call CopyLastColonCommandToRegister("x")<CR>
vnoremap <M-:> <ESC>:call CopyLastColonCommandToRegister("x")<CR>
nnoremap <M-'> @:
vnoremap <M-'> <ESC>@:
inoremap <M-'> <ESC>@:

" Fast Escape
nnoremap <M-a> <ESC>
vnoremap <M-a> <ESC>
inoremap <M-a> <ESC>

" Easy window resize
nnoremap <M-[> <C-W>>
vnoremap <M-[> <C-W>>
inoremap <M-[> <C-O><C-W>>
nnoremap <M-{> <C-W><
vnoremap <M-{> <C-W><
inoremap <M-{> <C-O><C-W><
nnoremap <M-}> <C-W>-
vnoremap <M-}> <C-W>-
inoremap <M-}> <C-O><C-W>-
nnoremap <M-]> <C-W>+
vnoremap <M-]> <C-W>+
inoremap <M-]> <C-O><C-W>+

" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
nnoremap <M-1> :%s/\<<C-r><C-w>\>//gcI<Left><Left><Left><Left>
vnoremap <M-1> :s/\v/gcI<Left><Left><Left><Left>
inoremap <M-1> <ESC>:%s/\<<C-r><C-w>\>//gcI<Left><Left><Left><Left>
nnoremap <M-!> :%s/\<<C-r><C-a>\>//gcI<Left><Left><Left><Left>
vnoremap <M-!> :s/\v/gcI<Left><Left><Left><Left>
inoremap <M-!> <ESC>:%s/\<<C-r><C-a>\>//gcI<Left><Left><Left><Left>
nnoremap <M-2> :,$s/\<<C-r><C-w>\>//gcI<Left><Left><Left><Left>
vnoremap <M-2> <ESC>:,$s/\v/gcI<Left><Left><Left><Left>
inoremap <M-2> <ESC>:,$s/\<<C-r><C-w>\>//gcI<Left><Left><Left><Left>
nnoremap <M-"> :,$s/\<<C-r><C-a>\>//gcI<Left><Left><Left><Left>
vnoremap <M-"> <ESC>:,$s/\v/gcI<Left><Left><Left><Left>
inoremap <M-"> <ESC>:,$s/\<<C-r><C-a>\>//gcI<Left><Left><Left><Left>

" Make
nnoremap <leader>mf :vsplit %:p:h/../makefile<CR>
vnoremap <leader>mf <ESC>:vsplit %:p:h/../makefile<CR>
nnoremap <leader>mc :<CR>:Neomake! makeclean<CR>
vnoremap <leader>mc <ESC>:Neomake! makeclean<CR>
nnoremap <leader>md :wa<CR>:Neomake! makedebug<CR>
vnoremap <leader>md <ESC>:wa<CR>:Neomake! makedebug<CR>
nnoremap <leader>ma :wa<CR>:Neomake! makeall<CR>
vnoremap <leader>ma <ESC>:wa<CR>:Neomake! makeall<CR>
nnoremap <leader>me :!<C-R>=expand("%:p:h")<CR>/../bin/
vnoremap <leader>me <ESC>:!<C-R>=expand("%:p:h")<CR>/../bin/

" Vim
nnoremap <leader>z :vsplit $MYVIMRC<CR>
vnoremap <leader>z <ESC>:vsplit $MYVIMRC<CR>
nnoremap <leader>Z :split $MYVIMRC<CR>
vnoremap <leader>Z <ESC>:split $MYVIMRC<CR>

" Save
nnoremap <M-s> :update<CR>
vnoremap <M-s> <ESC>:update<CR>
inoremap <M-s> <C-O>:update<CR>
nnoremap <M-S> :wa<CR>
vnoremap <M-S> <ESC>:wa<CR>
inoremap <M-S> <C-O>:wa<CR>

" Copy
nnoremap <M-c> "+yy<CR>
vnoremap <M-c> "+yy<CR>
inoremap <M-c> <ESC>"+yy<CR>

" Cut
nnoremap <M-x> "+x<CR>
vnoremap <M-x> "+x<CR>
inoremap <M-x> <ESC>"+x<CR>

" Paste
function! PasteMe()
    execute "set paste"
    execute "normal \"+p"
    execute "set nopaste"
endfunction
nnoremap <M-v> :call PasteMe()<CR>
vnoremap <M-v> :call PasteMe()<CR>
inoremap <M-v> <C-O>:call PasteMe()<CR>

" Switch to the directory of the open buffer
noremap <leader>c :cd %:p:h<CR>

" Window movement
nnoremap <leader>H <c-w>h
nnoremap <leader>J <c-w>j
nnoremap <leader>K <c-w>k
nnoremap <leader>L <c-w>l

" Move by virtual lines instead of physical lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Buffer movement
nnoremap <M-n> :bn<CR>
vnoremap <M-n> <ESC>:bn<CR>
inoremap <M-n> <ESC>:bn<CR>
nnoremap <M-N> :bp<CR>
vnoremap <M-N> <ESC>:bp<CR>
inoremap <M-N> <ESC>:bp<CR>
nnoremap <M-b> :b #<CR>
vnoremap <M-b> :b #<CR>
inoremap <M-b> :b #<CR>
nnoremap <M-B> <c-^>:bd #<CR>
vnoremap <M-B> <ESC><c-^>:bd #<CR>
inoremap <M-B> <ESC><c-^>:bd #<CR>

" Fold
nnoremap <leader>s za

" Easy macro
nnoremap <M-q> :normal @@
vnoremap <M-q> :normal @@
inoremap <M-q> <ESC>:normal @@
nnoremap <M-Q> :normal @
vnoremap <M-Q> :normal @
inoremap <M-Q> <ESC>:normal @

" Quit buffer without saving
nnoremap <leader>q :q<CR>

" Quit all buffers without saving
nnoremap <leader>Q :qa<CR>

" Write all changed buffers and exit
nnoremap <leader>x :xa<CR>

" Quit all buffers without saving, there is no prompt!
nnoremap <leader>X :qa!<CR>

" Disable highlight
noremap <silent> <leader><CR> :nohls<CR>

" Quickfix
" Close
nnoremap <M-H> :ccl<CR>
vnoremap <M-H> <ESC>:ccl<CR>
inoremap <M-H> <ESC>:ccl<CR>
" Next
nnoremap <M-J> :cn<CR>
vnoremap <M-J> <ESC>:cn<CR>
inoremap <M-J> <ESC>:cn<CR>
" Previous
nnoremap <M-K> :cp<CR>
vnoremap <M-K> <ESC>:cp<CR>
inoremap <M-K> <ESC>:cp<CR>
" List
nnoremap <M-L> :clist<CR>
vnoremap <M-L> <ESC>:clist<CR>
inoremap <M-L> <ESC>:clist<CR>

" Location-list
" Close
nnoremap <M-h> :lcl<CR>
vnoremap <M-h> <ESC>:lcl<CR>
inoremap <M-h> <ESC>:lcl<CR>
" Next
nnoremap <M-j> :lnext<CR>
vnoremap <M-j> <ESC>:lnext<CR>
inoremap <M-j> <ESC>:lnext<CR>
" Previous
nnoremap <M-k> :lprevious<CR>
vnoremap <M-k> <ESC>:lprevious<CR>
inoremap <M-k> <ESC>:lprevious<CR>
" List
nnoremap <M-l> :llist<CR>
vnoremap <M-l> <ESC>:llist<CR>
inoremap <M-l> <ESC>:llist<CR>

nnoremap <F2> :TagbarToggle<CR>
vnoremap <F2> <ESC>:TagbarToggle<CR>
inoremap <F2> <ESC>:TagbarToggle<CR>

nnoremap <F3> :Autoformat<CR>
vnoremap <F3> <ESC>:Autoformat<CR>
inoremap <F3> <ESC>:Autoformat<CR>

nnoremap <F4> :call MySpellLang()<CR>
vnoremap <F4> <ESC>:call MySpellLang()<CR>
inoremap <F4> <ESC>:call MySpellLang()<CR>

set pastetoggle=<F5>

nnoremap <F6> :so $MYVIMRC<CR>
vnoremap <F6> <ESC>:so $MYVIMRC<CR>
inoremap <F6> <ESC>:so $MYVIMRC<CR>
" }}}

" vim-easy-align ---------------------------- {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" vim-airline ------------------------------- {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='monochrome'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
" }}}

" ultisnips --------------------------------- {{{
let g:UltiSnipsExpandTrigger='<c-e>'
let g:UltiSnipsJumpForwardTrigger='<TAB>'
let g:UltiSnipsJumpBackwardTrigger='<s-TAB>'
let g:UltiSnipsEditSplit="vertical"
" }}}

" vim-fswitch ------------------------------- {{{
nnoremap <M-g> :FSHere<CR>
vnoremap <M-g> <ESC>:FSHere<CR>
inoremap <M-g> <ESC>:FSHere<CR>

nnoremap <M-G> :FSSplitRight<CR>
vnoremap <M-G> <ESC>:FSSplitRight<CR>
inoremap <M-G> <ESC>:FSSplitRight<CR>
" }}}

" vim-autoformat ---------------------------- {{{
let g:formatters_cpp = ['clangformat']
let g:formatdef_clangformat = "'clang-format -lines='.a:firstline.':'.a:lastline.' -style=\"google\"'"
" }}}

" YouCompleteMe ----------------------------- {{{
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚠'
let g:ycm_always_populate_location_list = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_max_diagnostics_to_display = 30
let g:ycm_show_diagnostics_ui = 1

let g:ycm_complete_in_comments = 0
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 0

let g:ycm_key_list_select_completion = ['<TAB>', '<DOWN>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<UP>']
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_detailed_diagnostics = '<leader>o'
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 1

let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_use_ultisnips_completer = 1
" }}}

" vim-easymotion --------------------- {{{
let g:EasyMotion_startofline = 0 " keep cursor on current column after J and K motion
let g:EasyMotion_smartcase = 1 " work similarly to Vim's smartcase option for G and g motion
let g:EasyMotion_do_mapping = 0 " no default maps

nmap <leader>w <Plug>(easymotion-w)
vmap <leader>w <Plug>(easymotion-w)
nmap <leader>W <Plug>(easymotion-W)
vmap <leader>W <Plug>(easymotion-W)
nmap <leader>e <Plug>(easymotion-e)
vmap <leader>e <Plug>(easymotion-e)
nmap <leader>E <Plug>(easymotion-E)
vmap <leader>E <Plug>(easymotion-E)
nmap <leader>t <Plug>(easymotion-t)
vmap <leader>t <Plug>(easymotion-t)
nmap <leader>T <Plug>(easymotion-T)
vmap <leader>T <Plug>(easymotion-T)
nmap <leader>f <Plug>(easymotion-f)
vmap <leader>f <Plug>(easymotion-f)
nmap <leader>F <Plug>(easymotion-F)
vmap <leader>F <Plug>(easymotion-F)
nmap <leader>b <Plug>(easymotion-b)
vmap <leader>b <Plug>(easymotion-b)
nmap <leader>B <Plug>(easymotion-B)
vmap <leader>B <Plug>(easymotion-B)
nmap <leader>n <Plug>(easymotion-n)
vmap <leader>n <Plug>(easymotion-n)
nmap <leader>N <Plug>(easymotion-N)
vmap <leader>N <Plug>(easymotion-N)
nmap <leader>h <Plug>(easymotion-linebackward)
vmap <leader>h <Plug>(easymotion-linebackward)
nmap <leader>j <Plug>(easymotion-j)
vmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
vmap <leader>k <Plug>(easymotion-k)
nmap <leader>l <Plug>(easymotion-lineforward)
vmap <leader>l <Plug>(easymotion-lineforward)
nmap <leader>g <Plug>(easymotion-sn)
vmap <leader>g <Plug>(easymotion-sn)
nmap <leader>G <Plug>(easymotion-tn)
vmap <leader>G <Plug>(easymotion-tn)
" }}}

" incsearch.vim ---------------------- {{{
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#magic = '\v'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

augroup incsearch-keymap
    autocmd!
    autocmd VimEnter * call s:incsearch_keymap()
augroup END
function! s:incsearch_keymap()
    IncSearchNoreMap <TAB>   <Over>(incsearch-next)
    IncSearchNoreMap <S-TAB> <Over>(incsearch-prev)
    IncSearchNoreMap <C-j>   <Over>(incsearch-scroll-f)
    IncSearchNoreMap <C-k>   <Over>(incsearch-scroll-b)
endfunction
" }}}

" vim-easyoperator-line -------------- {{{
let g:EasyOperator_line_do_mapping = 0
map <leader>v <Plug>(easyoperator-line-select)
map <leader>d <Plug>(easyoperator-line-delete)
map <leader>y <Plug>(easyoperator-line-yank)
" }}}

" vim-easyoperator-phrase ------------ {{{
let g:EasyOperator_phrase_do_mapping = 0
map <leader>V <Plug>(easyoperator-phrase-select)
map <leader>D <Plug>(easyoperator-phrase-delete)
map <leader>Y <Plug>(easyoperator-phrase-yank)
" }}}

" tagbar ----------------------------- {{{
let g:tagbar_left = 1
let g:tagbar_autoclose = 0 " close when you jump to a tag
let g:tagbar_autofocus = 1 " cursor will move to the Tagbar window when it is opened
let g:tagbar_sort = 0      " do not sort tags according to their name
" }}}

" vim-fugitive ----------------------- {{{
noremap <leader>gst :Gstatus<CR>
noremap <leader>glo :Git log<CR>
noremap <leader>gdi :Gvdiff<space>
noremap <leader>gdc :Git diff --cached<CR>
noremap <leader>gad :Gwrite<CR>
noremap <leader>gco :Gcommit -v<CR>
noremap <leader>gca :Gcommit -a -v<CR>
noremap <leader>gpu :Gpush<CR>
noremap <leader>gpl :Gpull<CR>
noremap <leader>gcb :Git checkout -b<space>
noremap <leader>gch :Git checkout<space>
noremap <leader>gme :Gmerge<space>
noremap <leader>gre :Git reset<space>
noremap <leader>grh :Git reset HEAD --hard<space>
noremap <leader>gfe :Gfetch<space>
noremap <leader>grm :Gremove<space>
noremap <leader>gmv :Gmove<space>
noremap <leader>gbl :Gblame<CR>
" }}}

" tcomment_vim ----------------------- {{{
" let g:tcommentMaps = 0
let g:tcommentmapleader1 = '' " should be a shortcut that can be used with map, imap, vmap
let g:tcommentMapLeader2 = '' " Should be a shortcut that can be used with map, xmap
let g:tcommentMapLeaderOp1 = 'gc' " Should be a shortcut that can be used with nmap and xmap
let g:tcommentMapLeaderUncommentAnyway = 'g<' " Should be a shortcut that can be used with nmap and xmap
let g:tcommentMapLeaderCommentAnyway = 'g>' " Should be a shortcut that can be used with nmap and xmap
let g:tcommentTextObjectInlineComment = 'ic' " Should be a shortcut that can be used with vmap and omap
" }}}

" fzf.vim ---------------------------- {{{
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'}

let g:fzf_buffers_jump = 1 " Jump to the existing window if possible
let g:fzf_layout = { 'down': '~35%' }

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
nnoremap <M-w> :Snippets<CR>
vnoremap <M-w> <ESC>:Snippets<CR>
inoremap <M-w> <ESC>:Snippets<CR>
nnoremap <M-W> :Windows<CR>
vnoremap <M-W> <ESC>:Windows<CR>
inoremap <M-W> <ESC>:Windows<CR>
nnoremap <M-e> :Buffers<CR>
vnoremap <M-e> <ESC>:Buffers<CR>
inoremap <M-e> <ESC>:Buffers<CR>
nnoremap <M-E> :Marks<CR>
vnoremap <M-E> <ESC>:Marks<CR>
inoremap <M-E> <ESC>:Marks<CR>
nnoremap <M-r> :BLines<CR>
vnoremap <M-r> <ESC>:BLines<CR>
inoremap <M-r> <ESC>:BLines<CR>
nnoremap <M-R> :Lines<CR>
vnoremap <M-R> <ESC>:Lines<CR>
inoremap <M-R> <ESC>:Lines<CR>
nnoremap <M-t> :BCommits<CR>
vnoremap <M-t> <ESC>:BCommits<CR>
inoremap <M-t> <ESC>:BCommits<CR>
nnoremap <M-T> :Commits<CR>
vnoremap <M-T> <ESC>:Commits<CR>
inoremap <M-T> <ESC>:Commits<CR>
nnoremap <M-d> :BTags<CR>
vnoremap <M-d> <ESC>:BTags<CR>
inoremap <M-d> <ESC>:BTags<CR>
nnoremap <M-D> :Tags<CR>
vnoremap <M-D> <ESC>:Tags<CR>
inoremap <M-D> <ESC>:Tags<CR>
nnoremap <M-f> :GitFiles<CR>
vnoremap <M-f> <ESC>:GitFiles<CR>
inoremap <M-f> <ESC>:GitFiles<CR>
nnoremap <M-F> :Files<CR>
vnoremap <M-F> <ESC>:Files<CR>
inoremap <M-F> <ESC>:Files<CR>
" }}}

" nerdtree --------------------------- {{{
nnoremap <M-A> :NERDTreeToggle<CR>
vnoremap <M-A> <ESC>:NERDTreeToggle<CR>
inoremap <M-A> <ESC>:NERDTreeToggle<CR>
" }}}


" vim-json --------------------------- {{{
let g:vim_json_syntax_conceal = 0
" }}}

" neomake ---------------------------- {{{
let g:neomake_open_list = 2

let g:neomake_php_enabled_makers = ['php', 'phpmd', 'phpcs']
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_elixir_enabled_makers = ['elixir']
let g:neomake_go_enabled_makers = ['go', 'golint', 'govet']
let g:neomake_c_enabled_makers = ['clang', 'clang-tidy']
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_css_enabled_makers = ['csslint', 'stylelint']
let g:neomake_tex_enabled_makers = ['chktex', 'lacheck', 'rubberinfo']
let g:neomake_sh_enabled_makers = ['sh', 'shellcheck']
let g:neomake_scss_enabled_makers = ['scsslint']
let g:neomake_rust_enabled_makers = ['rustc']
let g:neomake_json_enabled_makers = ['jsonlint']
let g:neomake_html_enabled_makers = ['tidy', 'htmlhint']
let g:neomake_python_enabled_makers = ['python', 'pylama', 'vulture']

function! Make_args_factory(target)
  let closure = {'target': a:target}
  function! closure.fn()
    let l:makefileLocation = expand("%:p:h:h")
    let l:args = [self.target, '-C', l:makefileLocation]
    return l:args
  endfunction
  return closure
endfunction

let g:neomake_makedebug_maker = {
    \ 'exe': 'make',
    \ 'args': Make_args_factory('debug'),
    \ }
let g:neomake_makeall_maker = {
    \ 'exe': 'make',
    \ 'args': Make_args_factory('all'),
    \ }
let g:neomake_makeclean_maker = {
    \ 'exe': 'make',
    \ 'args': Make_args_factory('clean'),
    \ }
" }}}

" auto-pairs ------------------------- {{{
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutToggle = '<M-p>'
let g:AutoPairsShortcutJump = '<S-Tab>'
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = ''
" }}}

" vim-go ----------------------------- {{{
" }}}

" Lots of stuff from here and there -- {{{
" http://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier
" https://github.com/Valloric/dotfiles/blob/master/vim/vimrc.vim
" https://github.com/junegunn/dotfiles/blob/master/vimrc
" https://github.com/haya14busa/dotfiles/blob/master/.vimrc
" https://github.com/scrooloose/vimfiles/blob/master/vimrc
" https://github.com/mony960/dotfiles/blob/master/.vimrc
" https://github.com/tarruda/dot-files/blob/master/config/nvim/init.vim
" https://bitbucket.org/jloureiro/dotfiles/src
" https://github.com/amix/vimrc
" http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs
" http://statico.github.io/vim2.html
" }}}
