let g:ackprg = 'ag --nogroup --nocolor --column'

" Leader
let mapleader=" "
nnoremap <SPACE> <Nop>

set hidden              " Allows unsaved buffer to be hidden instead of required save
set backspace=2         " Backspace deletes like most programs in insert mode
set nobackup            " No backup files
set nowritebackup       " No backup files
set noswapfile          " No swap file
set history=50          " Set history to 50
set ruler               " Show the cursor position all the time
set showcmd             " Display incomplete commands
set incsearch           " Do incremental searching
set laststatus=2        " Always display the status line
set autowrite           " Automatically :write before running commands
set hls!                " Don't highlight my searches, its lame
set tabstop=2           " Tabs are two spaces!
set shiftwidth=2        " Tabs are two spaces!
set expandtab           " Spaces not tabs!
set so=999              " Search in middle of screen
set clipboard=unnamed   " Should always copy to system clipboard
set mouse=a             " Use the mouse!

" Persistent Undo
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" resize vim on tmux split
autocmd VimResized * :wincmd =

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

" Nerd Tree
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>m :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↓'
let NERDTreeShowHidden=1

" Tab navigation
nnoremap <Leader><S-tab> :tabprevious<CR>
nnoremap <Leader><tab>   :tabnext<CR>

" Reload Vim
map <Leader>. :source ~/dev/dotfiles/vimrc<CR>

" Insert binding.pry
map <Leader>p obinding.pry<ESC>:w<CR>

" Move to the next buffer
nmap <leader>k :bnext<CR>

" Move to the previous buffer
nmap <leader>j :bprevious<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Vimux
map <Leader>r :call VimuxRunLastCommand()<CR>
map <Leader>vr :call VimuxOpenRunner()<CR>
map <Leader>et :w<CR>:call VimuxRunCommand("clear; mix test " . bufname("%"))<CR>
map <Leader>ET :w<CR>:call VimuxRunCommand("clear; mix test")<CR>
map <Leader>rt :w<CR>:call VimuxRunCommand("clear; bundle exec rails test " . bufname("%"))<CR>
map <Leader>RT :w<CR>:call VimuxRunCommand("clear; bundle exec rails test")<CR>
map <Leader>rs :w<CR>:call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>
map <Leader>RS :w<CR>:call VimuxRunCommand("clear; bundle exec rspec")<CR>

" Clear search highlight
map <Leader>h :noh<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set FZF
set rtp+=/usr/local/opt/fzf
map <Leader>t :FZF<CR>

"search project for word under cursor with Ag
nnoremap <leader>F :Ag<Space><C-R><C-W><CR>
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

" Colors
syntax on
set cursorline
colorscheme one
set background=dark

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

