" see http://nvie.com/posts/how-i-boosted-my-vim/
set nocompatible
set encoding=utf-8
" Set author's name for SnipMate plugin
let g:snips_author = 'Andrey Hitrin'
" vim-slime setup
let g:slime_target = "tmux"
let g:slime_default_config = { "socket_name": "default", "target_pane": "" }
let g:slime_dont_ask_default = 1

" Use tags from third-party libraries located in ~/src
set tags=./tags,./TAGS,tags,TAGS,~/src/*/tags,/usr/include/tags

" change mapleader from \ to ,
" http://dailyvim.blogspot.com/2008/11/using-mapleader.html
let mapleader=","

" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" quickly save current buffer and return to edit
nmap <leader>z :wa<CR>i

set autoread        " reload changed file without askin'
set hidden          " hide buffers insteade of close
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
set belloff=all     " no *freaking* bells!

colorscheme desert
if has('gui_running')
    set guifont=Hack\ 11
    colorscheme solarized
    set background=light
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

" Insert timestamp at the first line of the buffer
function TimestampFirst()
    let ts = strftime("%Y-%m-%d %H:%M:%S %Z")
    let line = "== " . ts
    call append(line("1"), line)
endfunction

" wrappers against my custom tools
command Braindump :edit `~/projects/ideas/bin/braindump -n` | :call TimestampFirst()
command Develop :edit `~/projects/ideas/bin/devel-braindump -n` | :call TimestampFirst()
command Journal :edit `~/projects/ideas/bin/journal -n`
command Monthly :edit `~/projects/ideas/bin/monthly -n`
command Myplan :edit `~/projects/ideas/bin/myplan -n`
command Weekly :edit `~/projects/ideas/bin/weekly -n`
command Workplan :edit `~/projects/ideas/bin/workplan -n`
command RndCard :edit `~/projects/ideas/bin/random-card`

function AdocLink()
    let line = getline('.')
    if strpart(line, 0, 10) ==# 'See: link:'
        " echo strpart(line, 10)
        let target_subpath = substitute(strpart(line, 10), '\[.*', '', 'g')
        " echo target_subpath
        if strpart(target_subpath, 0, 1) ==# '/'
            " absolute path
            let short_file = target_subpath
        else
            " relative path
            let this_file = expand('%')
            " echo this_file
            let new_file = substitute(this_file, '/[^/]*$', '/', '') . target_subpath
            " echo new_file
            let short_file = trim(system("realpath " . new_file))
        endif
        " echo "|" . short_file . "|"
        if filereadable(short_file)
            execute "edit " . short_file
        else
            echo "File not found: " . short_file
        endif
    endif
endfunction

nmap <leader>] :call AdocLink()<cr>
