" see http://nvie.com/posts/how-i-boosted-my-vim/
set nocompatible
" Set author's name for SnipMate plugin
let g:snips_author = 'Andrey Hitrin'
" vim-slime setup
let g:slime_target = "tmux"

" Use tags from third-party libraries located in ~/src
set tags=./tags,./TAGS,tags,TAGS,~/src/*/tags,/usr/include/tags

"Use pathogen to easily modify the runtime path to include all plugins under ~/.vim/bundle directory
call pathogen#infect()
call pathogen#helptags()

" change mapleader from \ to ,
" http://dailyvim.blogspot.com/2008/11/using-mapleader.html
let mapleader=","

" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" quickly save current buffer and return to edit
nmap <leader>z :wa<CR>i

" hide buffers insteade of close
set hidden

set wrap            " do wrap lines
set linebreak       " and break looooooooooooooong lines
set tabstop=4       " a tab is 4 spaces
set softtabstop=4   " a tab is 4 spaces in insert mode
set expandtab       " force replace tabs w/ spaces
set backspace=eol,start,indent
                    " allow backspacing over everything in insert mode
set copyindent      " copy previous indentation
set number          " always show line numbers
set ruler           " show cursor coordinates and file position
set shiftwidth=4    " number of spaces used for autoindenting
set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
set scrolloff=3     " keep some lines below and above the cursor
set showmatch       " set show matching parenthesis
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab        " insert tabs on the start of a line according to shiftwidth, not tabstop
set smartindent     " auto indentation on {} symbols in C and so on
set hlsearch        " highlight search results
set incsearch       " show search matches as you type

set history=1000    " loooong history
set undolevels=1000 " loooong levels
set title           " change the terminal's title
set guioptions-=T   " remove tools panel in GVim
set guioptions-=L   " remove left scrollbar in GVim
set guioptions-=r   " remove right scrollbar in GVim
set guioptions-=m   " remove menu in GVim
set spelllang=ru_yo,en_us   " spellcheck: Russian with Ё, and English

if has('gui_running')
    set guifont=Ubuntu\ Mono\ 9
    set background=dark
    colorscheme solarized
else
    colorscheme desert
endif

set nobackup        " NO BACKUPS!!! (leave it in the 70's)
set noswapfile      " swap is obsolete!
syntax on           " always check & highlight syntax
filetype plugin on  " load filetype plugins

" workaround: manually set up clojure filetype (why it is not auto loaded?)
au BufRead,BufNewFile *.clj set filetype=clojure

set diffopt=vertical

" whitespaces
set list            " show whitespaces and other symbols
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" HELL YEAH!
nnoremap ; :
" paragraph reformat
vmap Q gq
nmap Q gqap
" easy work with buffers
nnoremap <silent> <F9> :BufExplorer<CR>
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>
" easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <silent> ,/ :nohlsearch<CR>

" call sudo to modify root's files after opening
cmap w!! w !sudo tee % >/dev/null
