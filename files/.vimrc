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

" Load all pathogen plugins
execute pathogen#infect()

" Map keyboard shortcuts for tabularize
let mapleader=','
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" Auto align equals signs whilst typing
"inoremap <silent> = =<Esc>:call <SID>ealign()<CR>a
"function! s:ealign()
""  let p = '^.*=[^>|]*$'
""  if exists(':Tabularize') && getline('.') =~# '^.*=' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
""    let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
""    let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
""    Tabularize/=/l1
""    normal! 0
""    call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
""  endif
"endfunction

" Auto align colons whilst typing
"inoremap <silent> : :<Esc>:call <SID>calign()<CR>a
"function! s:calign()
""  let p = '^.*:\s.*$'
""  if exists(':Tabularize') && getline('.') =~# '^.*:' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
""    let column = strlen(substitute(getline('.')[0:col('.')],'[^:]','','g'))
""    let position = strlen(matchstr(getline('.')[0:col('.')],'.*:\s*\zs.*'))
""    Tabularize/:/l1
""    normal! 0
""    call search(repeat('[^:]*:',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
""  endif
"endfunction

" Auto align bars whilst typing
"inoremap <silent> <Bar>   <Bar><Esc>:call <SID>baralign()<CR>a
"function! s:baralign()
""  let p = '^\s*|\s.*\s|\s*$'
""  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
""    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
""    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
""    Tabularize/|/l1
""    normal! 0
""    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
""  endif
"endfunction

" Syntastic Settings
set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" A few syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0

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

" Set sections in statusline
let g:airline_section_a = '%m'
let g:airline_section_b = '%{fugitive#statusline()}'
let g:airline_section_c = '%f %y'

" Set statusline theme
let g:airline_theme='molovo'

nmap <C-r> :TagbarToggle<CR>
nmap <C-t> :CtrlP<CR>
nmap <C-e> :NERDTreeToggle<CR>
nmap <C-n> :tabnew<CR>

map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

set tags=./.vimtags;/

let g:easytags_async          = 1
let g:easytags_auto_update    = 0
let g:easytags_auto_highlight = 0
let g:easytags_opts           = ['--PHP-kinds=+cf']

inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>

autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <Leader><Up> :wincmd k<CR>
map <Leader><Down> :wincmd j<CR>
map <Leader><Left> :wincmd h<CR>
map <Leader><Right> :wincmd l<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

let NERDTreeShowHidden = 1

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('scss', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('sass', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('less', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'yellow', 'none', '#ff00ff', '#151515')

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

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open           = 1
let g:syntastic_html_tidy_ignore_errors = [" proprietary attribute \"ng-"]
let g:syntastic_aggregate_errors        = 1
let g:syntastic_quiet_messages          = { "type": "style" }

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.zprezto/runcoms/.vim/spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

let g:phpcomplete_index_composer_command       = "/usr/local/bin/composer"
let g:phpcomplete_complete_for_unknown_classes = 1
let g:phpcomplete_search_tags_for_variables    = 1
let g:phpcomplete_parse_docblock_comments      = 1
let g:phpcomplete_cache_taglists               = 1
let g:phpcomplete_enhance_jump_to_definition   = 1

" If php-cs-fixer is in $PATH, you don't need to define line below
let g:php_cs_fixer_path="/usr/local/bin/php-cs-fixer" " path to the php-cs-fixer
let g:php_cs_fixer_level="symfony"                    " which level ?
" let g:php_cs_fixer_config="default"                 " configuration
let g:php_cs_fixer_php_path="/usr/local/bin/php"      " Path to PHP
" If you want to define specific fixers:
let g:php_cs_fixer_fixers_list="-unalign_equals,-unalign_double_arrow,align_equals,align_double_arrow,,phpdoc_order,ordered_use,-phpdoc_indent,-phpdoc_inline_tag,header_comment,-psr0,-new_with_braces,-unused_use"
" let g:php_cs_fixer_enable_default_mapping=1         " Enable mapping (<leader>pcd)
" let g:php_cs_fixer_dry_run=0                        " Call command with dry-run option
" let g:php_cs_fixer_verbose=0                        " Return the output of command if 1, else an inline information.

au BufNewFile,BufRead *.sublime-project set filetype=json
au BufNewFile,BufRead Phakefile set filetype=php

filetype plugin on

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
