" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

"Fix backspace problem
set backspace=indent,eol,start

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=light

set nohlsearch

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

let mapleader = " "

"forces Vim to source vimrc file if it is present in the working directory"
set exrc


" Sets the working directory to the current file that you are editing

" prevents the execution of arbitrary code in my vimrc"
set secure

filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2


" This option will allow the user to go to the current indentation level by
" pressing enter from the previous line
set autoindent

" This option is to show line numbers and to help with navigation of code
set number


"show the bar always
set laststatus=2
let g:airline#extensions#tabline#enabled=1 

" Display command at the bottom of the vim bar
set showcmd

set autowrite
nnoremap <C-c> :!bash ~/.vim/scripts/compileSource.sh %:t<CR>
vnoremap <C-c> "+y
" maps macros for c++ comments in vim
let @c="I//j"

"maps for quick select all
:map <leader>a ggVG

"center in on the found search query
:map n nzz
:map N Nzz


"maps for quickly selecting a definition rather than the "clumsy <C-]> gets the next function call definition

"for getting to the next error quickly
"requires YCM
:map <leader>n :lnext<CR> 
"read in template for hackerrank
:map <leader>rt :read ~/.vim/scripts/template.cpp<CR>

"edit template for hackerrank
:map <leader>et :e ~/.vim/scripts/template.cpp<CR>


let g:ale_lint_on_save = 1
let g:ale_linters = {'python':[],'javascript': []}
highlight ALEWarning ctermbg=61

" See :help ale_linters for more info (seriously, do it)

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_use_clangd=0
let g:ycm_always_populate_location_list = 1
let g:ycm_min_num_of_chars_for_completion = 7
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ "objc":1,
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ "python":1,
			\ }

set hidden
let g:racer_cmd = "/home/neal/.cargo/bin/racer"

call plug#begin()

" On-demand loading
" Use PlugInstall and PlugUpdate");
Plug 'myusuf3/numbers.vim'
"Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips'] 
" fzf is a bit better for the time being
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
"Plug 'dense-analysis/ale'
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'kkoomen/vim-doge'
"Open Vim and run :call doge#install() after
call plug#end()


"Sets the main program to send no visual errors instead of annoying beeps!
:set vb t_vb=
:map  :%s/
:set foldmethod=indent
"augroup AutoSaveFolds
  "autocmd!
  "" view files are about 500 bytes
  "" bufleave but not bufwinleave captures closing 2nd tab
  "" nested is needed by bufwrite* (if triggered via other autocmd)
  "autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  "autocmd BufWinEnter ?* silent! loadview
"augroup end

" Stolen from StackOverflow
" Shell ------------------------------------------------------------------- {{{
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>s :Shell

function! s:VExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>VExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ VShell call s:VExecuteInShell(<q-args>)
nnoremap <leader>vs :VShell
" }}}
"
 
"""""""""""""""""""""" _MAPS FOR WASPAI BITBOARD_"""""""""""""""""""""""""""""
" Get the 8x8 hex bitboard of the current number for WaspAi
:nnoremap <leader>bb m'<C-A><C-X>"1yiw:Shell ~/.vim/scripts/hexView.sh <C-r>1<CR>
" Same as above but vertical split
:nnoremap <leader>vb m'<C-A><C-X>"1yiw:VShell ~/.vim/scripts/hexView.sh <C-r>1<CR>
" Same as above but paste result into current window
:nnoremap <leader>pb m'<C-A><C-X>"1yiw:r !bash /home/neal/.vim/scripts/hexView.sh <C-r>1<CR>`'

" Like J but for 8 consecutive lines hence the name (b)itboard J
:nnoremap <leader>Jb <C-v>$7jd8k$p8j8dd

" (a)ppend (b)itboard from the bottom to the top (deletes the line number
" column)
:nmap <leader>ab 8k$/.* 8<CR>0<C-v>7jf1l"1d<leader>Jb
"""""""""""""""""""""" _END MAPS FOR WASPAI BITBOARD_"""""""""""""""""""""""""""""

" Get the 8x8 hex bitboard of the current number for WaspAi
:nnoremap <leader>bt m' "1yiw:Shell ~/.vim/scripts/tetView.sh <C-r>1<CR>
" Same as above but vertical split
:nnoremap <leader>vt m' "1yiw:VShell ~/.vim/scripts/tetView.sh <C-r>1<CR>
" Same as above but paste result into current window
:nnoremap <leader>pt m' :r !bash /home/neal/.vim/scripts/tetView.sh <cword><CR>

" Fuzzy finder
:map <C-f> :Files<CR>

" Pull up rip-grep dialog
:map <leader>R :Rg<CR>

" Search current word using rip-grep
:map <expr> <leader><C-r> ':Rg '.expand('<cword>').'<CR>'

" Whatever is highlighted, google it! Uses the s command defined at
" ~/.local/s and the s register
:map <expr> gs ':!s '.expand('<cword>').'<CR>'

" Interesting command: credit - https://dalibornasevic.com/posts/43-12-vim-tips
" Select last yanked text
:nnoremap <expr> gb '`[' . getregtype()[0] . '`]'

" Normal mode on selected but less typing
:map <leader>nn :normal 
" Normal mode everywhere but less typing
:map <leader>%% :%normal 

" Terminal-mode has quick escape as well
:tnoremap <C-l> <C-w>l
:tnoremap <C-j> <C-w>j
:tnoremap <C-h> <C-w>h
:tnoremap <C-k> <C-w>k

:nnoremap <C-l> <C-w>l
:nnoremap <C-j> <C-w>j
:nnoremap <C-h> <C-w>h
:nnoremap <C-k> <C-w>k
" Quickly access terminal mode
:noremap <leader>t :terminal<CR>

" Quickly edit vimrc
:noremap <leader>ev :vsp ~/.vim/vimrc<CR>

" Quickly source vimrc
:noremap <leader>sv :source ~/.vim/vimrc<CR>

" Quick escape from terminal mode 
:tnoremap  <C-\><C-N>

" Quick find file in split
:map gF :vsp<CR>gf


:nmap "' ysiw :nmap "" ysiW
:nmap <leader>" yss

autocmd FileType rust inoremap <buffer> ppp println!("{}",  


function! Rusty()
    nnoremap <C-e> :terminal cargo run<cr>
    inoremap <C-e> <esc>:terminal cargo run<cr>
endfunction 

augroup rust
    autocmd!
    autocmd FileType rust call Rusty()
augroup end

"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-n>"
"let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"let g:UltiSnipsEditSplit="vertical"

"let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips'] 



" Set highlighting options so everything doesn't look weird
" Make the error msg readable
:hi ErrorMsg none
:hi ErrorMsg term=reverse cterm=bold ctermbg=9 gui=bold guibg=Red
" For the coc-rust-analyzer get rid of default ugly highlitng
:hi CocInlayHint none
:hi CocInlayHint ctermfg=12


" Automatic ctags for rust
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/


:nnoremap <leader>ds :!rm /home/neal/.local/share/nvim/swap/  

:nnoremap <leader><Left> <C-w>10<
:nnoremap <leader><Right> <C-w>10>
:nnoremap <leader><Up> <C-w>5+
:nnoremap <leader><Down> <C-w>5-
