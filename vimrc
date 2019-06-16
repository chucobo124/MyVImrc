"==================
"==== Vim Plug ====
"==================

call plug#begin()
	Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
	Plug 'fatih/vim-go'
	Plug 'fatih/molokai'
	Plug 'AndrewRadev/splitjoin.vim'
	Plug 'SirVer/ultisnips'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'scrooloose/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'
	Plug 'mhinz/vim-signify'
	Plug 'scrooloose/nerdcommenter'
	Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
	Plug 'zchee/deoplete-go', { 'do': 'make','for':'go'}
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'pangloss/vim-javascript'
	Plug 'moll/vim-node'
	Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
	Plug 'ternjs/tern_for_vim'
	Plug 'deoplete-plugins/deoplete-jedi'
	Plug 'aklt/plantuml-syntax'
	Plug 'davidhalter/jedi-vim'
	Plug 'nvie/vim-flake8'
	Plug 'ap/vim-css-color'
call plug#end()

"=========================
"==== Default setting ====
"=========================

set encoding=utf-8
set autoindent
set nu
syntax on
set autowrite " Automatically save before :next, :make etc.
set hlsearch  " Highlight found searches
set incsearch " Shows the match while typing
set directory=$HOME/.vim/tmp//
set backspace=2
set backspace=indent,eol,start
let g:python3_host_prog  = '/usr/local/bin/python3'
set spell
set spelllang=en_us
set complete+=kspell
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare
hi SpellBad cterm=underline
noremap <leader>nt :tabnew<CR>

"==== Quick Fix settings ====
" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
noremap <C-n> :cn<CR>
noremap <C-m> :cp<CR>
noremap <leader>a :ccl<CR>

"======================================
"==== Separate Config By Language ====
"======================================

augroup css 
	autocmd!
	autocmd FileType css,sass,scss setlocal omnifunc=csscomplete#CompleteCSS
	autocmd Filetype css setlocal tabstop=4
augroup end

augroup html
	autocmd!
	autocmd FileType html setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd Filetype html setlocal tabstop=4
augroup end

augroup quickfix
	autocmd!
	" In the quickfix window, <CR> is used to jump to the error under the
	" cursor, so undefine the mapping there.
	autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
	autocmd FileType qf setlocal wrap linebreak 
augroup end

augroup python
	autocmd!
	autocmd BufWritePost *.py :call flake8#Flake8()
augroup end

augroup uml
    autocmd!
    autocmd BufWritePost *.uml :call Build_uml_png()
augroup end

augroup golang
    autocmd!
    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()
    autocmd BufWritePost *.go :call <SID>build_go_files()
    autocmd BufWritePost *_test.go :call <SID>build_go_files()
augroup end

augroup git
	autocmd QuickFixCmdPost *grep* cwindow
augroup end

"============================
"==== Customise Function ====
"============================

" build png when uml saved
function! Build_uml_png()
    :make;open %:r.png
endfunction


" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file=expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

"=======================
"==== Plug Settings ====
"=======================

"==== jedi-vim ====
let g:jedi#goto_command = "gg"
let g:jedi#goto_assignments_command = "ga"
let g:jedi#goto_definitions_command = "gd"

"==== vim-javascript ====
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1


"==== vim-snippets ====
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

"==== deoplete ====
let g:deoplete#enable_at_startup = 1
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd BufWritePost * if pumvisible() == 0 | pclose | endif
let g:deoplete#enable_refresh_always = 1

"==== deoplete-GO ====
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

"==== deoplete-ternjs ====
let g:deoplete#sources#ternjs#tern_bin = '/usr/local/bin/tern'
let g:deoplete#sources#ternjs#timeout = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#filter = 0
let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]

"==== tern_for_vim ====
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

"==== NERD Tree ====
noremap <C-Bslash> :NERDTreeToggle<CR>
noremap <C-h> :NERDTreeFind<CR>

"==== Vim-Go ====
let g:go_fmt_command = "goimports"
let g:go_test_show_name=1
let g:go_autodetect_gopath = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_gocode_autobuild=1
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "camelcase"

"==== plantuml-syntax ====
let g:plantuml_executable_script="java -jar ~/bin/plantuml.jar"

"==== vim-flake8 ====
let g:flake8_cmd="/usr/local/bin/flake8"

