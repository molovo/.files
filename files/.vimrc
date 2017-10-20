" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2014 Nov 05
"
" To use it, copy it to
"     for Unix:  ~/.vimrc
"     for MS-DOS and Win32:  $VIM\_vimrc

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup             " keep a backup file (restore to previous version)
set undofile           " keep an undo file (undo changes after closing)
set history=50         " keep 50 lines of command line history
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set incsearch          " do incremental searching
set swapfile           " keep unsaved changes in a swapfile

" Set backup directories rather than leaving hidden files everywhere
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp
set backupskip=/tmp/*,/private/tmp/*

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

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

  set autoindent               " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


syntax on
set background=dark
let ayucolor="mirage"
colorscheme ayu

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd				                              " Show (partial) command in status line.
set showmatch			                              " Show matching brackets.
set ignorecase		                              " Do case insensitive matching
set smartcase			                              " Do smart case matching
set incsearch			                              " Incremental search
set hlsearch
set autowrite		                                " Automatically save before commands like :next and :make
set hidden                                      " Hide buffers when they are abandoned
set mouse=a				                              " Enable mouse usage (all modes) in terminals
set number                                      " Show line numbers
highlight LineNr ctermfg=08 ctermbg=black       " Remove hideous green background from line numbers
let g:indentLine_color_term = 08

" tabs -> spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Show statusline by default
set laststatus=2

" space = pagedown, - = pageup
noremap <Space> <PageDown>
noremap - <PageUp>

" remap'd keys
map <Tab><Tab> <C-W>w
nnoremap <F5><F5> :set invhls hls?<CR>    " use f5f5 to toggle search hilight
nnoremap <F4><F4> :set invwrap wrap?<CR>  " use f4f4 to toggle wordwrap
nnoremap <F2><F2> :vsplit<CR>
nnoremap <F3><F3> <C-W>w

" Stop vim-json from hiding quotes in JSON files
let g:vim_json_syntax_conceal = 0

" Set a better line indent indicator
let g:indentLine_char = '·'

" Gitgutter settings
let g:gitgutter_sign_column_always             = 1
let g:gitgutter_realtime                       = 1
let g:gitgutter_override_sign_column_highlight = 0

" Gitgutter color highlighting
highlight SignColumn ctermbg            = black
highlight DiffAdd ctermbg               = black
highlight DiffAdd ctermfg               = green
highlight GitGutterAdd ctermbg          = black
highlight GitGutterAdd ctermfg          = green
highlight DiffChange ctermbg            = black
highlight DiffChange ctermfg            = yellow
highlight GitGutterChange ctermbg       = black
highlight GitGutterChange ctermfg       = yellow
highlight DiffDelete ctermbg            = black
highlight DiffDelete ctermfg            = red
highlight GitGutterDelete ctermbg       = black
highlight GitGutterDelete ctermfg       = red
highlight DiffChangeDelete ctermbg      = black
highlight DiffChangeDelete ctermfg      = yellow
highlight GitGutterChangeDelete ctermbg = black
highlight GitGutterChangeDelete ctermfg = yellow

" StatusLine color highlighting
highlight StatusLine ctermfg            = black
highlight StatusLine ctermbg            = white
highlight StatusLineNC ctermfg          = black
highlight StatusLineNC ctermbg          = white

" TabLine color highlighting
highlight TabLineFill ctermfg = white
highlight TabLineFill ctermbg = black
highlight TabLine ctermfg     = white
highlight TabLine ctermbg     = black
highlight TabLineSel ctermfg  = green
highlight TabLineSel ctermbg  = black
highlight Title ctermfg       = blue
highlight Title ctermbg       = black

nmap <C-n> :tabnew<CR>

set tags=./.vimtags;/

map <Leader><Up> :wincmd k<CR>
map <Leader><Down> :wincmd j<CR>
map <Leader><Left> :wincmd h<CR>
map <Leader><Right> :wincmd l<CR>

" Enable spellchecking for markdown and git commits
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command='ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching=0
endif

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim/spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

au BufNewFile,BufRead *.sublime-project set filetype=json
au BufNewFile,BufRead Phakefile set filetype=php

filetype plugin on

call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

nmap ; :Buffers<CR>
nmap <C-t> :Files<CR>
nmap <C-r> :Tags<CR>
