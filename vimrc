
" Update Plugins:  :PlugUpdate

" Delete Plugins:
" 1. Delete or comment out "Plug" commands for the plugins you want to remove.
" 2. Reload vimrc (:source ~/.vimrc) or restart Vim
" 3. Run ":PlugClean". It will detect and remove undeclared plugins

" Dependencies:
" 1. for mac: brew install cmake
" 2. ctags generator:
"	apt-get install ctags
"	for mac: brew install ctags
" 3. youcompletemy installer:
" 	cd ~/.vim/plugged/youcompleteme && python install.py
" 4. ag install:
"	apt-get install silversearcher-ag
"	for mac: brew install the_silver_searcher


""" Documentation for plugins:
" General:
" F2 - NERDTRee
" F3 - FZF Files
" F4 - :buffers (opened files)
"
" FZF:
" tab - multiple select
" alt+a - select all
" alt-d - deselect all
"
" NERDTree:
" m - display the nerd tree menu
" O - open directory recursively
" I - show hidden filders/files
" B - toggle whether bookmark table is displayed
"
" NERDTree open files modes:
" s - open file in vsplit mode and focus in the opened file
" gs - same but not focus in the opened file

" i - open file in split mode and focus in the opened file
" gi - same but not focus in the opened file

" t - open selected node/bookmar in a new tab
" T - same as 't' but keep the focus on the current tab
" gt - next tab
" gT - previous tab
"
" VDebug:
" F2 - Step over
" F3 - Step in
" F4 - Step out

" F7 - Detach

" F5 - Run (waiting for connection)
" F6 - stop/close
" F9 - run to cursor
" F10 -setting a line breakpoint (VdebugSetLineBreakpoint)
"

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'szw/vim-g' " google for vim
"Plug 'crusoexia/vim-monokai' " color theme
"Plug 'dracula/vim', {'as':'dracula'} " color theme
Plug 'morhetz/gruvbox'

function! BuildYCM(info)
	" info is a dictionary with 3 fields
	" - name:   name of the plugin
	" - status: 'installed', 'updated', or 'unchanged'
	" - force:  set on PlugInstall! or PlugUpdate!
	if a:info.status == 'installed' || a:info.force
		!./install.py
	endif
endfunction

Plug 'valloric/youcompleteme', { 'do': function('BuildYCM') } " cd ~/.vim/plugged/youcompleteme && ./install.py --clang-completer
Plug 'tpope/vim-fugitive'

Plug 'w0rp/ale' "Asynchronous Lint Engine
let g:ale_linters = {}
let g:ale_linters_explicit = 1 "Only run linters named in ale_linters settings


Plug 'scrooloose/nerdtree' " file manager
let g:NERDTreeWinPos = "left"
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeWinSize=25
let g:NERDTreeShowHidden=1


Plug 'majutsushi/tagbar' " functions/variables bar << command: TagbarToggle
"autocmd VimEnter * TagbarToggle
"let g:tagbar_width = 35


Plug 'vim-airline/vim-airline' " status bar
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1


Plug 'airblade/vim-gitgutter'
set updatetime=100
set signcolumn="yes"


" #### search files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf for user
Plug 'junegunn/fzf.vim'	" Fzf vim plugin

"Regenerate tags run in vim :Tags
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules --exclude=tags --exclude=vendor'
let $FZF_DEFAULT_COMMAND = 'ag -g ""' "Ignore search in files who included in .gitingore

Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_ctermcolor='red'
let g:strip_whitespace_on_save = 1 "after save file delete spaces

Plug 'vim-vdebug/vdebug' " debugger
"timeout is default
"break_on_open - first line turn off = 0
let g:vdebug_options = {
			\ "port" : 9000,
			\ "server" : '',
			\ "timeout" : 20,
			\ "ide_key" : 'PHPSTORM',
			\ "marker_default" : '⬦',
			\ "marker_closed_tree" : '▸',
			\ "marker_open_tree" : '▾',
			\ "watch_window_style" : 'compact',
			\ "path_maps": { "/var/www/my-repo": "/var/www/my-repo" },
			\ "break_on_open" : 0,
			\ "window_arrangement": ["DebuggerWatch", "DebuggerStack", "DebuggerStatus"],
			\	'window_commands': {
			\     'DebuggerStack': 'belowright new +res5',
			\     'DebuggerWatch': 'vertical belowright new',
			\     'DebuggerStatus': 'belowright new +res5',
			\   },
			\ }

let g:vdebug_features = { 'max_children': 200 }
"map <c-d> :exe 'g/'.g:vdebug_options["marker_open_tree"]."/normal \<cr><cr>"


hi default DbgBreakptLine term=reverse ctermfg=Black ctermbg=Yellow guifg=#ffffff guibg=#ffffff
hi default DbgBreakptSign term=reverse ctermfg=Black ctermbg=Red guifg=#ffffff guibg=#ff0000
sign define current text=-> texthl=DbgCurrentSign linehl=DbgCurrentLine
sign define breakpt text=A> texthl=DbgBreakptSign linehl=DbgBreakptLine


"Plug 'scrooloose/syntastic'
"general
"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"
""other
let g:syntastic_enable_signs=1
let g:syntastic_loc_list_height=5
let g:syntastic_aggregate_errors=1
"
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--builtins=_ --max-line-length=100'
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_php_checkers = ['php', 'phpmd'] "phpcs - spaces and etc. (need dependency: pecl install PHP_CodeSniffer)
let g:syntastic_php_phpmd_post_args = 'cleancode,codesize,controversial,design,unusedcode,naming'
let g:syntastic_php_phpcs_args = '--standard=psr2'
let g:syntastic_php_phpmd_exec = '/var/www/phpmd/src/bin/phpmd'
"

call plug#end()

colorscheme gruvbox
"colorscheme dracula
"colorscheme monokai
"colorscheme pablo

" ######### BIND KEYS
nnoremap <f2> :NERDTreeToggle<CR>
nnoremap <f3> :Files<CR>
nnoremap <f4> :Buffers<CR>


" ######## General configurations
" Source/reload .vimrc after saving .vimrc
autocmd bufwritepost .vimrc source $MYVIMRC

set laststatus=2
set t_Co=256
set encoding=utf-8
set colorcolumn=120,160 "show mark at this symbol position
set listchars=tab:»\ ,trail:·,eol:$ "turn on use: set list
autocmd FileType qf wincmd J "push your quickfix window to the bottom
syntax on " Enable syntax highlighting

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
set scrolloff=5 "kai pagedown pageup kiek nuo virsaus apacios eiluciu bus kursorius
"set nowrap " neperkelia i next line jei terminale netelpa tekstas

" # BLOCK
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
set tabstop=4 " a tab is four spaces
set shiftwidth=4 " number of spaces to use for autoindenting
" #BLOCK END

"set eol "add end of file encoding unix add 'LF' (0x0A)
set noeol "same as eol but negative
set binary "binary and noeol combination to prevent EOF add 'LF' (0x0A)
set backspace=indent,eol,start " allow backspacing over everything in insert mode

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

set copyindent " copy the previous indentation on autoindenting
set smarttab " insert tabs on the start of a line according to

set number " always show line numbers
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch " set show matching parenthesis
set ignorecase " ignore case when searching
set smartcase " ignore case if search pattern is all lowercase,
"case-sensitive otherwise
"shiftwidth, not tabstop
set hlsearch " highlight search terms
set incsearch " show search matches as you type

" increase the history buffer for undo'ing mistakes
set history=1000
set undolevels=1000

set mouse=a

" ### Commented features
"set cursorline "its slow then scrolling

set directory=~/.vim/.swp/
set backupdir=~/.vim/.backup/
set undodir=~/.vim/.undo/

function! CreateDirs()
	if !isdirectory(&directory)
		silent call mkdir(&directory, 'p')
	endif

	if !isdirectory($backupdir)
		silent call mkdir(&backupdir, 'p')
	endif

	if !isdirectory(&undodir)
		silent call mkdir(&undodir, 'p')
	endif
endfunction
call CreateDirs()

au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=99 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |
	\ set colorcolumn=79,120 |
