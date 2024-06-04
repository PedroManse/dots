syntax enable
filetype plugin indent on
set re=0
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/


" Plugins
call plug#begin()
	Plug 'mg979/vim-visual-multi'         " multi cursor
	Plug 'airblade/vim-gitgutter'         " show git dif (+,-,~) in edited lines
	Plug 'mattn/emmet-vim'                " emmet
	Plug 'mbbill/undotree'                " display vim's change tree
	Plug 'jnurmine/Zenburn'               " zenburn colorscheme
	Plug 'thimc/gruber-darker.nvim'       " gruber colorscheme (tsoding's)
	Plug 'vim-airline/vim-airline'        " airline
	Plug 'vim-airline/vim-airline-themes' " zenburn airline
	Plug 'prisma/vim-prisma'              " prisma syntax
	Plug 'gleam-lang/gleam.vim'           " gleam syntax
	Plug 'HerringtonDarkholme/yats.vim'   " TypeScript syntax
	Plug 'rust-lang/rust.vim'             " Rust syntax and commands
	Plug 'vim-syntastic/syntastic'        " syntastic for rust
call plug#end()

let netrw_banner=0
let netrw_browse_split=3

" tree
let g:netrw_liststyle=3

" ; at $
autocmd FileType c,cpp,javascript,typescript,sql,css,rust,zig nnoremap <buffer> ; msA;<ESC>`s
autocmd FileType typescript,javascript iab jsf function
			\|iab jaf async function
			\|iab eaf export async function
			\|iab jef export function
			\|iab udef undefined
			\|iab ec export const
			\|iab et export type
			\|iab ceaf export async function(r: HttpReader): Promise<Handler> {}<left><CR><ESC><up>wwwi

let g:syntastic_check_on_open=1
let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_mode_map = { "mode": "active" }
autocmd FileType rust nnoremap <buffer> <C-h>h :Crun<CR>a
autocmd FileType rust nnoremap <buffer> <C-h><C-h> :Ccheck<CR>a
autocmd FileType rust nnoremap <buffer> <C-h>c :SyntasticCheck<CR>

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
set lz " lazy redraw on macro execution

"au BufWinEnter * :set tabstop=2
"au BufWinEnter * :set shiftwidth=2
"au BufWinEnter * :set noexpandtab
"au BufWinEnter *.yml :set expandtab
au BufWinEnter * ++once syntax enable
"au BufWinEnter * ++once RainbowLoad

" nMaps
nmap <SPACE> <ESC>:noh<CR>:<BS>
" move the screen
nmap <C-j> <C-e>
nmap <C-k> <C-y>
nmap <C-w>= :echo "screen equalization disabled"<CR>
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
nmap <A-h> :bprev<CR>
nmap <A-l> :bnext<CR>
nmap <leader>q :b#<bar>bw#<CR>
nmap <C-f> V$%:fold<CR>j

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
command Vmod :tabe ~/.config/nvim/init.vim
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

