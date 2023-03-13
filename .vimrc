source ~/.vim/autoload/plug.vim

call plug#begin('~/.config/nvim/autoload/plugged')
	" monokai
	"Plug 'jam1garner/vim-code-monokai'
	"Plug 'tanvirtin/monokai.nvim'

	" git branch
	Plug 'tpope/vim-fugitive'

	" clock
	"Plug 'enricobacis/vim-airline-clock'

	" git branch
	Plug 'itchyny/vim-gitbranch'

	" colorscheme grubvox
	Plug 'morhetz/gruvbox'

	" colorscheme darkula
	" Plug 'crusoexia/vim-dracula'

	" file-line
	"Plug 'bogado/file-line'

	" status line
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" rgb {[()]}
	Plug 'frazrepo/vim-rainbow'

	" autl-complete
	"Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" fileman configs
	"Plug 'editorconfig/editorconfig-vim'

call plug#end()
normal! :<Bs>
"source ~/.vim/colors/monokai.vim

let g:python_recommended_style=0
let g:rainbow_active = 1
let g:netrw_liststyle = 3
" only if modifiable
function! BufDo(command)
	if !&modifiable
		exe a:command
	endif
endfun " :(

" sets
command! -nargs=+ BufDo call BufDo(<q-args>)
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set whichwrap+=[,],<,>
set nowrap
set nonu
set formatoptions-=crof
set linebreak
set noswapfile
set encoding=UTF-8

set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab

" au FileType * call rainbow#load()

BufDo au BufRead,BufNewFile,BufWrite *.xmp setfiletype Xmp
BufDo au BufRead,BufNewFile,BufWrite *.xmp set filetype=Xmp

" commands
" PlugUpgrade
" PlugUpdate
" PlugInstall
" PlugStatus

" theme
"colorscheme dracula
colorscheme gruvbox
"colorscheme delek


" HotKeys
	" tabbing
	" replaces spaces with tabs

	" quick macro
	map <C-l> @q

	" ()[]{}""
	imap <A-(> ()<Left>
	imap <A-[> []<Left>
	imap <A-{> {}<Left>
	imap <A-"> ""<Left>
	imap <A-<> <><Left>


	" file man
	map <C-s>		:w	<CR>
	map <C-q>		:wq <CR>
	imap <C-s>		<Esc>:w  <CR>a
	imap <C-q>		<Esc>:wq <CR>
	" map <C-p>		:Files<Cr>

	" why not
	map <Space>	:noh<CR>:<BS>
	imap <C-h> <Left>
	imap <C-l> <Right>
	map <C-c> yy
	imap <C-c> <Esc>yya


	" move the line it-self
	nmap <A-j>	:m +1<CR><Space>
	imap <A-j>	<Esc>:m +1<CR>i
	nmap <A-k>	:m -2<CR><Space>
	imap <A-k>	<Esc>:m -2<CR>i

	" don't use arrows in normal mode
	"nmap <Up>	:echo "NO!, use K"<CR>
	"nmap <Down>	:echo "NO!, use J"<CR>
	"nmap <Right> :echo "NO!, use L"<CR>
	"nmap <Left>	:echo "NO!, use H"<CR>

	" move three lines at a time
	" map <C-Up>		kkk
	" imap <C-Up>		<Up><Up><Up>
	" map <C-Down>	jjj
	" imap <C-Down>	<Down><Down><Down>

	map <C-k>		<C-y>
	" imap <C-k>		<C-y>
	map <C-j>		<C-e>
	" imap <C-j>		<C-e>

	" ctrl delete word
	imap <A-Bs> <C-w>
	imap <A-Del> <Esc>wi<C-w>

	" open NERDTree
	"map <C-p>		 :NERDTree<CR>
	"imap <C-p>		<Esc>:NERDTree<CR>

	" somewhat quicker
	map <C-A-/> I"<Esc>
	map ; msA;<Esc>`s
	map <C-/> msI//<Esc>`s

	" search
	imap <C-f>		<C-o>/

	" :%s/find/replace/g
	" do: (%)make (s)tring
	" with (search) : RE
	" to (replace) : s

	" abbs
	iab hepl help
	iab tihs this
	iab oepn open
	iab vsqrt √
	iab vlambda λ
	iab vplusminus ±
	iab LOREM Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum.<CR>Aliquam nonummy auctor massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.<CR>Nulla at risus. Quisque purus magna, auctor et, sagittis ac, posuere eu, lectus. Nam mattis, felis ut adipiscing. <CR>
	iab MAIN #include <stdio.h><CR><CR>int main(int argc, char *argv[]) {<CR>printf("Hello World\n");<CR>return 0;<CR>}

	" moving
	map k gk
	map j gj

	" map <Up> gk
	" map <Down> gj



	nmap O o<Tab>
	nmap <C-o> o<Bs>

	map ´ `
	map <C-g> `
	imap <C-g> <C-o>`

	"imap <Up>	<C-o>gk
	"imap <Down> <C-o>gj

	map ^	g^
	map $	g$
	nmap S r<Cr>k$

	" windows
	nmap <F1> <C-w>v<C-w>l:e
	nmap <F2> <C-w>i:e


	" yanking
	nmap <C-c><S-Right>		vEy<Esc>
	nmap <C-c><S-Right><S-Right>		vEEy<Esc>
	nmap <C-c><S-Right><S-Right><S-Right>		vEEEy<Esc>

	" insert -> normal
	imap <C-J><C-J> <Esc>

	" debug
	" map	<F2> :<C-U>setlocal lcs=tab:-->,space:.,eol:⏎ list! list? <CR>
	map	<F2> :<C-U>setlocal lcs=tab:-->,space:.,eol:$ list! list? <CR>
	" for tty mode
	map	<F7> :<C-U>setlocal lcs=tab:-->,space:.,eol:$ list! list? <CR>
	nmap * %

	nmap <C-w>b :split h<CR>


"functions


" commands
:command Vmod tabedit ~/.vimrc
:command Tmod tabedit ~/.zshrc
:command Ter	terminal
:command Smod tabedit $VIMRUNTIME/syntax
:command Trim %s/\s\+$//e
:command HexToDec s/0x[0-9a-fA-F]\+/\=str2nr(submatch(0), 16)


" syntax hi
au FileType go syn keyword ikw include
au FileType go syn keyword ikw Include
au FileType go syn keyword goBuiltins exit
au FileType go hi def link ikw Keyword


BufDo au FileType * set tabstop=2
BufDo au FileType * set shiftwidth=2
BufDo au FileType * set softtabstop=2
BufDo au FileType * set noexpandtab
BufDo au FileType * set noet
BufDo au FileType * set nonu
BufDo au FileType * set textwidth=0
BufDo au FileType * set wrapmargin=0
BufDo au FileType * retab!

" airline
" let g:airline#extensions#branch#enable = 1
" let g:airline_extensions = ['branch', 'whitespace', 'clock']
"
" let g:airline_powerline_fonts = 1

" let g:airline_section_b = '%{gitbranch#name()}'
