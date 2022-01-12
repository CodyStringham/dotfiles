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

Plug 'neoclide/coc.nvim', {'branch': 'release'}

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


" START COC-NVIM - - - - - - - - - - - - - - - - - - - - - - - -
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" END COC-NVIM - - - - - - - - - - - - - - - - - - - - - - - -
