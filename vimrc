
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim
colorscheme slate

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
set background=dark

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
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

let mapleader = " "

"forces Vim to source vimrc file if it is present in the working directory"
set exrc

" Sets the working directory to the current file that you are editing
set autochdir

" prevents the execution of arbitrary code in my vimrc"
set secure

" does stuff with tabs so that the white space is nice and neat in practice
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" This option will allow the user to go to the current indentation level by
" pressing enter from the previous line
set autoindent

" This option is to show line numbers and to help with navigation of code
set number


"show the bar always
set laststatus=2
let g:airline#extensions#tabline#enabled=1


"This setting is show that the command that you are currently typing is shown in vim
set showcmd

set autowrite
nnoremap <C-c> :!bash ~/.vim/scripts/compileSource.sh %:t<CR>
vnoremap <C-c> "+y
"maps macros for c++ comments in vim
let @c="I//j"
let @u=":s#//##gj"

"maps for quick select all
let @y="ggVG"

"map for quick surround in {}
"doesn't work too well with comments
:vnoremap <leader>{ dkA{"}=i{

"maps for quickly selecting a definition rather than the 
"clumsy <C-]> gets the next function call definition
:map gd t(<C-]>zz

"for getting to the next error quickly
"requires YCM
:map <leader>n :lnext<CR>

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_use_clangd=0
let g:ycm_always_populate_location_list = 1
let g:ycm_min_num_of_chars_for_completion = 7
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1


call plug#begin()


" On-demand loading
" Use PlugInstall and PlugUpdate"
Plug 'myusuf3/numbers.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'ycm-core/YouCompleteMe'
call plug#end()

"Sets the main program to send no visual errors instead of annoying beeps!
:set vb
:set novb

:set foldmethod=indent
augroup AutoSaveFolds
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end


