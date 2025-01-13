vim.cmd([[
autocmd FileType rust let g:ale_enabled = 0
autocmd FileType c,cpp,javascript,typescript,sql,css,nix,rust,zig nnoremap <buffer> ; msA;<ESC>`s
autocmd FileType typescript,javascript iab jsf function
			\|iab jaf async function
			\|iab eaf export async function
			\|iab jef export function
			\|iab udef undefined
			\|iab ec export const
			\|iab et export type
			\|iab ceaf export async function(r: HttpReader): Promise<Handler> {}<left><CR><ESC><up>wwwi

autocmd FileType rust nnoremap <buffer> <C-h>h :Crun<CR>a
autocmd FileType rust nnoremap <buffer> <C-h><C-h> :Ccheck<CR>a

autocmd FileType go nnoremap <buffer> ; msA,<ESC>`s
autocmd BufWinEnter *.gohtml setfiletype html

" emmet
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

autocmd BufWinEnter * ++once syntax enable


" Commands
command Vmod :tabe $MYVIMRC
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
iab vdelta Δ

" Fancy colors
if $INTTY == "true"
	" "in a tty"
	colorscheme industry
	" autocmd BufWritePost * GitGutterBufferDisable
	au BufWinEnter * ++once AirlineTheme base16_bespin
else
	" "in pts"
	" autocmd BufWritePost * GitGutterBufferEnable
	au BufWinEnter * ++once AirlineTheme zenburn
endif

]])

