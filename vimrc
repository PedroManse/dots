" Plugins
call plug#begin()
	Plug 'mg979/vim-visual-multi', {'branch': 'master'}
	Plug 'morhetz/gruvbox'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'tmhedberg/matchit'
	Plug 'frazrepo/vim-rainbow'
	Plug 'airblade/vim-gitgutter'
	Plug 'mattn/emmet-vim'
	Plug 'mbbill/undotree'
call plug#end()

" rgb {[()]}
let g:rainbow_active = 1

" tree
let g:netrw_liststyle=3

" ; at $
autocmd FileType c nnoremap <buffer> ; msA;<ESC>`s
autocmd FileType cpp nnoremap <buffer> ; msA;<ESC>`s
autocmd FileType javascript nnoremap <buffer> ; msA;<ESC>`s
autocmd FileType css nnoremap <buffer> ; msA;<ESC>`s
autocmd FileType sql nnoremap <buffer> ; msA;<ESC>`s
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
" move within line-wrap
nmap j gj
nmap k gk
" oposite of J (Join/Split)
nmap S mar<LINEFEED>`a
" move the line
nmap <A-j>	:m +1<CR><Space>
nmap <A-k>	:m -2<CR><Space>
nmap <C-l> @q
nmap U :UndotreeToggle<CR><C-w><left><C-w><up>

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
imap <C-l> @q

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
iab jsf function
iab vsqrt √
iab vlambda λ

au BufWinEnter * ++once syntax enable
au BufWinEnter * ++once RainbowLoad

" Fancy colors
if $INTTY == "true"
	" "in a tty"
	colorscheme peachpuff
	autocmd BufWritePost * GitGutterBufferDisable
	au BufWinEnter * ++once AirlineTheme base16_bespin
else
	" "in pts"
	colorscheme gruvbox
	autocmd BufWritePost * GitGutterBufferEnable
	au BufWinEnter * ++once AirlineTheme desertink
endif

