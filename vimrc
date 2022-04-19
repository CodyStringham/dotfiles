let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" START PLUGINS - - - - - - - - - - - - - - - - - - - - - - - -
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'qpkorr/vim-bufkill'
Plug 'sheerun/vim-polyglot'
" Plug 'vim-ruby/vim-ruby'
" Plug 'tpope/vim-rake'
"
call plug#end()

" END PLUGINS - - - - - - - - - - - - - - - - - - - - - - - - -

" Run deoplete.nvim automatically
" let g:deoplete#enable_at_startup = 1


" Airline
let g:airline_powerline_fonts = 1
let g:airline_extensions = []

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
set clipboard=unnamed   " Should always copy to system clipboard
set mouse=a             " Use the mouse!

" Persistent Undo
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set pyxversion=3

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

" DelimitMate
let delimitMate_expand_cr = 1

" Nerd Tree
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>m :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↓'
let NERDTreeShowHidden=1
let g:NERDTreeMouseMode = 3
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Markdown Preview
let vim_markdown_preview_github=1

" Indent
let g:indentLine_char = '┆'
let g:vim_json_syntax_conceal = 0

" Buffers
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
map <silent> <Leader>x :BD<CR>

" Reload Vim
map <silent> <Leader>. :source ~/dev/dotfiles/vimrc<CR>

" Insert binding.pry
map <silent> <Leader>p obinding.pry<ESC>:w<CR>

" Move to the next buffer
nmap <silent> <Leader>k :bnext<CR>

" Move to the previous buffer
nmap <silent> <Leader>j :bprevious<CR>

" Terminal
tnoremap <Esc> <C-\><C-n>

" Vimux
map <expr> <Leader>c ":call VimuxRunCommand('clear; " . input("Command to run: ") . "')<CR>"
map <Leader>r :call VimuxRunLastCommand()<CR>
map <Leader>vr :call VimuxOpenRunner()<CR>
map <Leader>rt :w<CR>:call VimuxRunCommand("clear; bundle exec rails test " . bufname("%"))<CR>
map <Leader>RT :w<CR>:call VimuxRunCommand("clear; bundle exec rails test")<CR>
map <Leader>rs :w<CR>:call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec " . bufname("%"))<CR>
map <Leader>rsl :w<CR>:call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec " . bufname("%") . ":" . line("."))<CR>
map <Leader>RS :w<CR>:call VimuxRunCommand("clear; derp JRUBY_OPTS=--debug bundle exec rspec")<CR>

" Format code
map <Leader>fmt :call CocActionAsync('format')<CR>

" Clear search highlight
map <silent> <Leader>h :noh<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Set FZF
set rtp+=/usr/local/opt/fzf
nnoremap  <silent> <C-t> :Files<CR>
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Search project for word under cursor with Ag
" nnoremap <Leader>d :GoDef<CR>
nnoremap <silent> <Leader>F :Tags<Space><C-R><C-W><CR>
nnoremap <silent> <Leader>f :Ag<Space>
nnoremap <silent> <Leader>ts :tselect<CR>

" tag navigation
nnoremap <Leader>o <C-]>

" search history
nnoremap<Leader>? :History:<CR>

" neosnippet
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"strip all trailing whitespace in file on save
" autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" function! <SID>StripTrailingWhitespaces()
    " let l = line(".")
    " let c = col(".")
    " %s/\s\+$//e
    " call cursor(l, c)
" endfun

" Colors
syntax on
set cursorline

" set background=dark " Set to dark for a dark variant
colorscheme nord

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif
