" START PLUGINS - - - - - - - - - - - - - - - - - - - - - - - -
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-go', { 'do': 'make'}
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'buoto/gotests-vim'

Plug 'w0rp/ale'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'elzr/vim-json'
Plug 'posva/vim-vue'

Plug 'christoomey/vim-tmux-navigator'
" Plug 'knubie/vim-kitty-navigator'
Plug 'benmills/vimux'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'CodyStringham/vim-minimal'
call plug#end()

" END PLUGINS - - - - - - - - - - - - - - - - - - - - - - - - -

" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" autocomplete unimported packages
let g:deoplete#sources#go#unimported_packages = 1
let g:deoplete#enable_refresh_always = 1

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
nnoremap <Leader>n :NERDTree<CR>
nnoremap <Leader>m :NERDTree<CR>:q<CR>:NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↓'
let NERDTreeShowHidden=1
let g:NERDTreeMouseMode = 3
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Indent
let g:indentLine_char = '┆'
let g:vim_json_syntax_conceal = 0

" Tab navigation
nnoremap <tab>   :bnext<CR>

" Buffer delete
map <Leader>x :bd<CR>

" Reload Vim
map <Leader>. :source ~/dev/dotfiles/vimrc<CR>

" Insert binding.pry
map <Leader>p obinding.pry<ESC>:w<CR>

" Move to the next buffer
nmap <Leader>k :bnext<CR>

" Move to the previous buffer
nmap <Leader>j :bprevious<CR>

" Show all open buffers and their status
nmap <Leader>bl :ls<CR>

" Terminal
tnoremap <Esc> <C-\><C-n>

" Vimux
map <expr> <Leader>c ":call VimuxRunCommand('clear; " . input("Command to run: ") . "')<CR>"
map <Leader>r :call VimuxRunLastCommand()<CR>
map <Leader>vr :call VimuxOpenRunner()<CR>
map <Leader>rt :w<CR>:call VimuxRunCommand("clear; bundle exec rails test " . bufname("%"))<CR>
map <Leader>RT :w<CR>:call VimuxRunCommand("clear; bundle exec rails test")<CR>
map <Leader>rs :w<CR>:call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>
map <Leader>RS :w<CR>:call VimuxRunCommand("clear; bundle exec rspec")<CR>

" Clear search highlight
map <Leader>h :noh<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Set FZF
set rtp+=/usr/local/opt/fzf
map <Leader>t :FZF<CR>

"search project for word under cursor with Ag
nnoremap <Leader>d :GoDef<CR>
nnoremap <Leader>F :Ag<Space><C-R><C-W><CR>
nnoremap <Leader>f :Ag<Space>

" search history
nnoremap<Leader>? :History:<CR>

" Ale Configs
let g:ale_sign_error = '●'
let g:ale_sign_warning = '○'
let g:airline#extensions#ale#enabled = 1
let g:ale_pattern_options = {'measure_list.rb': {'ale_enabled': 0}}
" highlight clear ALEErrorSign
highlight clear ALEWarningSign
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" go-vim
filetype plugin on
set completeopt-=preview

let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
" let g:go_highlight_types = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
" let g:go_auto_sameids = 1
" let g:go_auto_type_info = 1

" neosnippet
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


" Lightline
let g:lightline = {
\ 'colorscheme': 'minimal',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'filename': 'LightlineFilename',
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

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

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

" set background=dark " Set to dark for a dark variant
colorscheme minimal

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif
