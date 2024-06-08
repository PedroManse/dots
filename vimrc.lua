local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


-- emmet
vim.g.user_emmet_leader_key=","
vim.g.user_emmet_install_global=0
vim.cmd([[ autocmd FileType html,css EmmetInstall ]])

require("lazy").setup({
	'mg979/vim-visual-multi',
	--'airblade/vim-gitgutter',
	'lewis6991/gitsigns.nvim',
	'mattn/emmet-vim',
	'mbbill/undotree',
	'jnurmine/Zenburn',
	'thimc/gruber-darker.nvim',
	'vim-airline/vim-airline',
	'vim-airline/vim-airline-themes',
	'prisma/vim-prisma',
	'gleam-lang/gleam.vim',
	'HerringtonDarkholme/yats.vim',
	'rust-lang/rust.vim',
	'vim-syntastic/syntastic'
}, opts)

require('gitsigns').setup()

function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function tmap(shortcut, command)
	map('t', shortcut, command)
end

function nmap(shortcut, command)
	map('n', shortcut, command)
end

function imap(shortcut, command)
	map('i', shortcut, command)
end

-- nMaps
nmap("<C-t>", ":w<CR>:term<CR>a")
nmap("<SPACE>", "<ESC>:noh<CR>:<BS>")

-- move the screen
nmap("<C-j>", "<C-e>")
nmap("<C-k>", "<C-y>")
nmap("<C-w>=", [[:echo "screen equalization disabled"<CR>]])
-- move within line-wrap
nmap("j", "gj")
nmap("k", "gk")
-- oposite of J (Join/Split)
nmap("S", "mar<LINEFEED>`a")
-- move the line
nmap("<A-j>", ":m +1<CR><Space>")
nmap("<A-k>", ":m -2<CR><Space>")
nmap("<C-l>", "@q")
nmap("U", ":UndotreeToggle<CR>:UndotreeFocus<CR>")
nmap("<A-h>", ":bprev<CR>")
nmap("<A-l>", ":bnext<CR>")
nmap("<leader>q", ":b#<bar>bw#<CR>")
nmap("<C-f>", "V$%:fold<CR>j")

-- iMaps
-- move the screen
imap("<C-j>", "<C-e>")
imap("<C-k>", "<C-y>")
-- move the line
imap("<A-j>	<ESC>:m", "+1<CR>i")
imap("<A-k>	<ESC>:m", "-2<CR>i")
imap("jj", "<ESC>")

imap([[<A-(>]], "()<LEFT>")
imap([[<A-[>]], "[]<LEFT>")
imap([[<A-{>]], "{}<LEFT>")
imap([[<A-">]], [[""<LEFT>]])
imap([[<A-<>]], "<><LEFT>")
imap([[<C-l>]], "<ESC>@q")

-- tMaps
tmap([[<ESC>]], [[<C-\><C-n>]])

-- colorscheme
vim.g.zenburn_force_dark_Background=1
vim.g.zenburn_transparent=1
vim.cmd("syntax enable")
vim.cmd.colorscheme("zenburn")

-- disable mouse
vim.opt.mouse=""
vim.g.clipboard = false

-- syntastic
vim.cmd("filetype plugin indent on")
vim.cmd("autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/")
vim.g.syntastic_check_on_open=1
vim.g.syntastic_rust_checkers = {"cargo"}
vim.g.syntastic_mode_map = { mode= "active" }
vim.g.re=0

-- netrw
vim.g.netrw_banner=0
vim.g.netrw_browse_split=3
vim.g.netrw_liststyle=3

-- the rest
vim.cmd([[

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
