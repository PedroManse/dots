" Plugins
call plug#begin()
	Plug 'mg979/vim-visual-multi', {'branch': 'master'}
	"Plug 'morhetz/gruvbox'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	"Plug 'tmhedberg/matchit'
	"Plug 'frazrepo/vim-rainbow'
	Plug 'airblade/vim-gitgutter'
	Plug 'mattn/emmet-vim'
	Plug 'mbbill/undotree'
	Plug 'jnurmine/Zenburn'
	Plug 'prisma/vim-prisma'
call plug#end()

" rgb {[()]}
"let g:rainbow_active = 1

let netrw_banner=0
let netrw_browse_split=3

" tree
let g:netrw_liststyle=3

" ; at $
autocmd FileType c,cpp,javascript,typescript,sql,css,rust nnoremap <buffer> ; msA;<ESC>`s
autocmd FileType typescript iab jsf function
			\|iab jaf async function
			\|iab eaf export async function
			\|iab jef export function
			\|iab udef undefined

autocmd FileType go nnoremap <buffer> ; msA,<ESC>`s
autocmd BufWinEnter *.gohtml setfiletype html

autocmd BufWritePost * GitGutterBufferEnable

" emmet
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Sets
set tabstop=2
set shiftwidth=2
set noexpandtab
set whichwrap+=[,],<,>
set encoding=UTF-8
set nowrap

" nMaps
" add ; to EOL
"nmap ; msA;<ESC>`s
nmap <SPACE> <ESC>:noh<CR>:<BS>
" move the screen
nmap <C-j> <C-e>
nmap <C-k> <C-y>
nmap <C-w>= :echo "screen equalization disabled"
" move within line-wrap
nmap j gj
nmap k gk
" oposite of J (Join/Split)
nmap S mar<LINEFEED>`a
" move the line
nmap <A-j>	:m +1<CR><Space>
nmap <A-k>	:m -2<CR><Space>
nmap <C-l> @q
nmap U :UndotreeToggle<CR>:UndotreeFocus<CR>
nmap + :tabfirst<CR>

" iMaps
" move the screen
imap <C-j> <C-e>
imap <C-k> <C-y>
" move the line
imap <A-j>	<ESC>:m +1<CR>i
imap <A-k>	<ESC>:m -2<CR>i
imap jj <ESC>

imap <A-(> ()<LEFT>
imap <A-[> []<LEFT>
imap <A-{> {}<LEFT>
imap <A-"> ""<LEFT>
imap <A-<> <><LEFT>
imap <C-l> <ESC>@q

" tMaps
tnoremap <ESC> <C-\><C-n>


" Commands
command Vmod :tabe ~/.vimrc
command Tmod :tabe ~/.shrc.sh

" typos
iab hepl help
iab tihs this
iab oepn open
iab coudl could
iab cosnt const

" abbreviation
iab vsqrt √
iab vlambda λ

au BufWinEnter * :set tabstop=2
au BufWinEnter * :set shiftwidth=2
au BufWinEnter * :set noexpandtab
au BufWinEnter *.yml :set expandtab
au BufWinEnter * ++once syntax enable
"au BufWinEnter * ++once RainbowLoad
au TermEnter * ++once syntax enable

" Fancy colors
if $INTTY == "true"
	" "in a tty"
	colorscheme peachpuff
	autocmd BufWritePost * GitGutterBufferDisable
	au BufWinEnter * ++once AirlineTheme base16_bespin
else
	" "in pts"
	autocmd BufWritePost * GitGutterBufferEnable
	if $ZEN == "true"
		let g:zenburn_transparent = 1
		colorscheme zenburn
		au BufWinEnter * ++once AirlineTheme zenburn
	else
		colorscheme gruvbox
		"au BufWinEnter * ++once AirlineTheme desertink
		au BufWinEnter * ++once AirlineTheme gruvbox
	endif
endif

