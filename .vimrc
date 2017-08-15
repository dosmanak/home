set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=150		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
" To disable a plugin, add it's bundle name to the following list
"let g:pathogen_disabled = ['vim-ansible-yaml']
execute pathogen#infect()
syntax on           " enable syntax processing
colorscheme gruvbox
set background=dark
set laststatus=2    " always show statusline
set tabstop=2       " number of visual spaces per TAB
set shiftwidth=2    " set indenting
set softtabstop=2   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
hi CursorLineNR     term=bold cterm=bold guibg=Grey40

set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <space> :nohlsearch<CR>
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" SETTINGS for STATUS LINE
hi User1 ctermfg=3   ctermbg=0  guifg=#eea040 guibg=#222222
hi User2 ctermfg=1   ctermbg=0  guifg=#dd3333 guibg=#222222
hi User3 ctermfg=191 ctermbg=0  guifg=#dd3333 guibg=#222222
hi User4 ctermfg=193 ctermbg=0  guifg=#a0ee40 guibg=#222222
hi User5 ctermfg=13  ctermbg=0  guifg=#eeee40 guibg=#222222
set statusline=
set statusline+=%1*[%n]\ %*            "buffer number
set statusline+=%4*\ %<%F%*            "full path
set statusline+=%1*\ +%l%*             "current line
set statusline+=%2*%m%*                "modified flag
set statusline+=%1*%=%4v:%*             "virtual column number
set statusline+=%1*%l%*             "current line
set statusline+=%3*/%L\ %*               "total lines

set pastetoggle=<f3>
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
" Do not store backupfiles in CWD, but here
set backupdir=~/.vim/backup
" use path with - as extension
let &backupext=substitute(getcwd(),"/","-","g")
" remeber undo history in separate dir
set undodir=~/.vim/undodir
set undofile

noremap <silent> <F1> :call MouseToggle()<CR>
inoremap <F1> <nop>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F6> :call QuickfixToggle()<CR>

function! MouseToggle()
    if &mouse == "a"
      let &mouse = "" 
    else
      let &mouse = "a"
    endif
endfunction

" BEGIN: Toggle grep results in new window
let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" END: Toggle grep results in new window

" NERDTree mapping
let g:NERDTreeMapPreview="<F2>"

" Grep recursively in cwd
command! -nargs=0 -bar Grep silent! grep! -r "\<<cword>\>" .<args>| call QuickfixToggle()


