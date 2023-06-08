" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2014 Nov 05
"
" To use it, copy it to
"     for Unix:  ~/.vimrc
"     for MS-DOS and Win32:  $VIM\_vimrc

let mapleader = ","

" Set UTF-8 encoding
set encoding=utf-8
scriptencoding utf-8

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup     " keep a backup file (restore to previous version)
set undofile   " keep an undo file (undo changes after closing)
set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching
set swapfile   " keep unsaved changes in a swapfile
set autoread   " automatically update buffer if file on disk changes

" Set backup directories rather than leaving hidden files everywhere
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp
set backupskip=/tmp/*,/private/tmp/*

" Auto-install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'ayu-theme/ayu-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'pearofducks/vim-quack-lightline'
Plug 'ap/vim-buftabline'
Plug 'junegunn/vim-easy-align'
"Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'dhruvasagar/vim-prosession'
Plug 'tmux-plugins/vim-tmux-focus-events'
" Plug 'lifepillar/vim-mucomplete'
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'othree/es.next.syntax.vim', {'for': 'javascript'}
Plug 'mxw/vim-jsx', {'for': 'javascript'}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'heavenshell/vim-jsdoc', {'for': 'javascript'}
Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'}
Plug 'ternjs/tern_for_vim', {'do': 'npm install', 'for': ['javascript', 'javascript.jsx']}
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/unite.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv', { 'for': 'php' }
Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
Plug 'liuchengxu/vim-which-key'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'kristijanhusak/deoplete-phpactor'

" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lumiliet/vim-twig'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" color scheme
set termguicolors
set noshowmode
set nocursorline
set nolist
let g:loaded_matchparen=1
set lazyredraw
set ttyfast

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-lists'
\ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Lightline
let g:lightline = {
\ 'colorscheme': 'one',
\ 'active': {
\   'left': [['mode', 'paste'], ['gitbranch'], ['filename'], ['modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_function': {
\   'gitbranch': 'fugitive#head'
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

let ayucolor="mirage"
colorscheme ayu
"colorscheme palenight
"let g:palenight_terminal_italics=1

if &term =~# '^tmux'
  " Colors in tmux
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Completion options
set noinfercase
set completeopt+=menuone
set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

call deoplete#custom#option({
      \ 'auto_complete': v:true,
      \ 'auto_complete_delay': 50,
      \ 'smart_case': v:true
      \ })

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
  \]

let g:deoplete#omni#functions.php = [
  \ 'phpactor#Complete',
  \]

set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources.javascript = ['ternjs', 'file']
let g:deoplete#sources['javascript.jsx'] = ['ternjs', 'file']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

let g:deoplete#sources = {}
let g:deoplete#sources.php = ['omni', 'phpactor', 'buffer']


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

" Set up cursor switching in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Switch cursor upon entering or leaving vim, and entering or leaving insert mode
autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"

" Reduce escape time
set timeoutlen=100 ttimeoutlen=10

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

  " For all text files set 'textwidth' to disable wrapping.
  autocmd FileType text setlocal textwidth=0

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

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set nowrap      " Disable line wrapping
set showcmd     " Show (partial) command in status line.
set showmatch   " Show matching brackets.
set ignorecase  " Do case insensitive matching
set smartcase   " Do smart case matching
set incsearch   " Incremental search
set hlsearch    " Highlight search terms
set autowrite   " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned
set mouse=a     " Enable mouse usage (all modes) in terminals
set number      " Show line numbers
set scrolloff=3 " Show 3 lines above/below the cursor
hi LineNr ctermfg=238 ctermbg=00   " Remove hideous green background from line numbers

" show indentation
set listchars=space:·
set list
hi SpecialKey ctermfg=238
hi ExtraWhitespace ctermbg=Red
match ExtraWhitespace /\s\+$/

" show comments in italics
hi Comment cterm=italic

" tabs -> spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

autocmd FileType php setlocal tabstop=4
autocmd FileType php setlocal softtabstop=4
autocmd FileType php setlocal shiftwidth=4

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

" Map jk to <Esc>
inoremap jk <Esc>

" Remove search highlighting with Esc-Esc
nnoremap <Esc><Esc> :noh<CR>

" Save file when leaving insert mode
autocmd InsertLeave * silent exec 'w'

" Map CTRL-J and CTRL-K to switch buffers
inoremap <C-J> <Esc>:bprev<CR>
inoremap <C-K> <Esc>:bnext<CR>
nnoremap <C-J> :bprev<CR>
nnoremap <C-K> :bnext<CR>

" Stop vim-json from hiding quotes in JSON files
let g:vim_json_syntax_conceal = 0

" Gitgutter settings
set signcolumn=yes
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

" TabLine color highlighting
highlight TabLineFill ctermfg = black
highlight TabLineFill ctermbg = black
highlight TabLine ctermfg     = white
highlight TabLine ctermbg     = black
highlight TabLineSel ctermfg  = green
highlight TabLineSel ctermbg  = black
highlight Title ctermfg       = blue
highlight Title ctermbg       = black

" nmap <C-n> :tabnew<CR>

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      exec expl_win_num . 'wincmd w'
      close
      exec cur_win_nr . 'wincmd w'
      unlet t:expl_buf_num
    else
      unlet t:expl_buf_num
    endif
  else
    exec '1wincmd w'
    Vexplore
    let t:expl_buf_num = bufnr("%")
  endif
endfunction

map <silent> <C-E> :call ToggleVExplorer()<CR>

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" set autochdir

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
endif

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

" Put this in vimrc or a plugin file of your own.
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'php': ['php_cs_fixer'],
\}

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'php': ['phpmd'],
\}

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1
let g:ale_php_cs_fixer_options = '--config="$HOME/.php_cs"'

" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Set keymappings for FZF plugin
nmap ; :Buffers<CR>
nmap <C-t> :Files<CR>
nmap <C-r> :BTags<CR>
nmap <C-r><C-r> :Tags<CR>
nmap <C-t><C-r> :Ag!<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" prosession config
let g:prosession_tmux_title = 1
let g:prosession_per_branch = 1

" fzf.vim config
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 fzf#vim#with_preview('right:50%'),
  \                 <bang>0)

command! -bang -nargs=* Files
  \ call fzf#vim#files(<q-args>,
  \                 fzf#vim#with_preview('right:50%'),
  \                 <bang>0)

" Make y and p copy and paste from global buffer
set clipboard+=unnamed

" use hybrid line numbering
set number relativenumber
set nu rnu

let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"
nnoremap <buffer> <Leader>d :call pdv#DocumentWithSnip()<CR>

" Make it obvious where 80 characters is
set textwidth=0
set wrapmargin=0
set formatoptions-=t
set colorcolumn=+1

inoremap <expr><tab>      pumvisible()? "\<C-n>" : "\<tab>"
inoremap <expr><S-tab>    pumvisible()? "\<C-p>" : "\<S-tab>"
inoremap <expr><Down>     pumvisible()? "\<C-n>" : "\<Down>"
inoremap <expr><Up>       pumvisible()? "\<C-p>" : "\<Up>"
" inoremap <expr><Esc>      pumvisible()? "\<C-e>" : "\<Esc>"
" inoremap <expr><CR>       pumvisible()? "\<C-y>" : "\<CR>"
" inoremap <expr><PageDown> pumvisible()? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
" inoremap <expr><PageUp>   pumvisible()? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpactor#Complete
augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

let g:phpactorOmniAutoClassImport = v:true
let g:phpactorOmniError = v:true

" Allow copying and pasting between instances of vim
vmap <leader>y :w! /tmp/vitmp<CR>
nmap <leader>p :r! cat /tmp/vitmp<CR>

nnoremap <silent> K :call CocAction('doHover')<CR>
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
