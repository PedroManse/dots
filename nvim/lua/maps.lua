-- imported from ../init.lua
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
--- ALE
nmap("<A-S-j>", ":ALEGoToDefinition<CR>")
nmap("<A-S-n>", ":ALENextWrap<CR>")
nmap("<A-S-k>", ":ALEFix<CR>")
nmap("<A-S-m>", ":ALEDetail<CR>")

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
nmap("<A-j>", ":m +1<CR>")
nmap("<A-k>", ":m -2<CR>")
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
