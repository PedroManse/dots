--- imported from ../init.lua

-- vim-like maps
local function map(mode, shortcut, command)
	vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

local function tmap(shortcut, command)
	map('t', shortcut, command)
end

local function nmap(shortcut, command)
	map('n', shortcut, command)
end

local function imap(shortcut, command)
	map('i', shortcut, command)
end

-- nMaps
nmap("<C-t>", ":terminal<CR>a")
nmap("<SPACE>", "<ESC>:noh<CR>:<BS>")
nmap("git", ":LazyGit<CR>")
nmap("gb", ":ls<CR>:b<space>")

--- LSP
-- lsp config in ./lsp.lua
vim.diagnostic.config({
	severity_sort = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
nmap("<A-S-n>", function()
	vim.diagnostic.jump { wrap = true, count = 1, float = true }
end)
nmap("grt", vim.lsp.buf.definition)
nmap("<A-S-m>", vim.lsp.buf.format)
-- grt -> def
-- gri -> impl
-- grr -> refs

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

nmap("gn", ':cn<CR>')
nmap("gp", ':cp<CR>')

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
