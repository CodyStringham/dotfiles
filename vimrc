" Leader
let mapleader=" "
let g:ackprg = 'ag --nogroup --nocolor --column'

nnoremap <SPACE> <Nop>

set hidden        " Allows unsaved buffer to be hidden instead of required save
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set hls!          " Don't highlight my searches, its lame
set expandtab     " Spaces not tabs!

" resize vim on tmux split
autocmd VimResized * :wincmd =

" Quit insert
imap jk <esc>
imap kj <esc>

" Let's be reasonable, shall we?
nmap k gk
nmap j gj

" Find in center of screen
nnoremap n nzz
nnoremap N Nzz

" Add/Remove lines
nmap <CR> o<Esc>
:autocmd CmdwinEnter * nnoremap <CR> <CR>
:autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Numbers
set number
set numberwidth=5

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Tab navigation
nnoremap <Leader><S-tab> :tabprevious<CR>
nnoremap <Leader><tab>   :tabnext<CR>
inoremap <Leader><S-tab> <Esc>:tabprevious<CR>i
inoremap <Leader><tab>   <Esc>:tabnext<CR>i

" Insert binding.pry
map <Leader>p obinding.pry<ESC>:w<CR>

" Move to the next buffer
nmap <leader>k :bnext<CR>

" Move to the previous buffer
nmap <leader>j :bprevious<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Rerun last command
map <Leader>r q:k<CR>
map <Leader>R q:kk<CR>


" Vimux
map <Leader>vr :call VimuxOpenRunner()<CR>
map <Leader>et :w<CR>:call VimuxRunCommand("clear; mix test " . bufname("%"))<CR>
map <Leader>eT :w<CR>:call VimuxRunCommand("mix test)<CR>
map <Leader>rt :w<CR>:call VimuxRunCommand("clear; rake test " . bufname("%"))<CR>
map <Leader>rT :w<CR>:call VimuxRunCommand("rake test)<CR>

" Clear search highlight
map <Leader>h :noh<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set FZF
set rtp+=/usr/local/opt/fzf
map <Leader>t :Files<CR>

"search project for word under cursor with Ag
nnoremap <leader>F :Ag<C-R><C-W><CR>
nnoremap <leader>f :Ag<Space>

" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
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

"strip all trailing whitespace in file on save
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Persistent Undo
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Colors
syntax on
set cursorline
colorscheme onedark
