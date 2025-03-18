--- imported from ../init.lua

-- vim-like maps
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
nmap("<C-t>", ":terminal<CR>a")
nmap("<SPACE>", "<ESC>:noh<CR>:<BS>")

--- LSP
-- lsp config in ./lsp.lua
nmap("<A-S-n>", ":lua= vim.diagnostic.goto_next{wrap = true}<CR>")
nmap("<A-S-j>", ":lua= vim.lsp.buf.definition()<CR>")
nmap("<A-S-k>", ":lua= vim.lsp.buf.implementation()<CR>")
nmap("<A-S-m>", ":lua= vim.lsp.buf.format()<CR>")

-- copilot
nmap("<C-w>c", ":Copilot panel<CR>")

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

imap([[A-<]], "<><ESC><left>")
imap([[<C-l>]], "<ESC>@q")

-- tMaps
tmap([[<ESC>]], [[<C-\><C-n>]])
