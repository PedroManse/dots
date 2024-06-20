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
	{
		'dense-analysis/ale',
		config = function()
			vim.g.ale_fixers = {
				javascript = {"eslint"},
				typescript = {"eslint"},
				rust = {"rustfmt"},
				python = {"black"},
			}
			vim.g.ale_linters = {
				javascript = {"eslint"},
				typescript = {"eslint", "typecheck"},
				rust = {"cargo"},
			}
		end
	}
}, opts)

require('gitsigns').setup()
require('maps')
require('options')
require('vim')
