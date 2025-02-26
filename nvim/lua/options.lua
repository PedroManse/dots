-- colorscheme
vim.g.zenburn_force_dark_Background=1
vim.g.zenburn_transparent=1
vim.opt.syntax="enable"
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

vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab = false
vim.opt.whichwrap='[,],<,>'
vim.opt.encoding='UTF-8'
vim.opt.wrap = false
vim.opt.lz=true -- lazy redraw on macro execution

-- ALE
vim.g.ale_linters_explicit=1

-- git signs
require('gitsigns').setup {
	signs = {
		add		  = { text = '+' },
		change	   = { text = '~' },
		delete	   = { text = '-' },
		topdelete	= { text = '-' },
		changedelete = { text = '~' },
		untracked	= { text = '┆' },
	}
}

-- emmet
--vim.g.user_emmet_leader_key=","
--vim.g.user_emmet_install_global=0
--vim.cmd([[ autocmd FileType html,css EmmetInstall ]])
