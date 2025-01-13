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
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'neovim/nvim-lspconfig',
	'mg979/vim-visual-multi',
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
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},
	{
		'dense-analysis/ale',
		config = function()
			vim.g.ale_fixers = {
				go = {"gofmt"},
				sh = {"shfmt"},
				javascript = {"eslint"},
				typescript = {"tslint", "eslint"},
				rust = {},
				python = {"black"},
			}
			vim.g.ale_linters = {
				javascript = {"eslint"},
				typescript = {"eslint", "typecheck"},
				rust = {},
			}
		end
	},
	{
		"utilyre/sentiment.nvim",
		version = "*",
		opts = {
			-- config
		},
		init = function()
			-- `matchparen.vim` needs to be disabled manually in case of lazy loading
			vim.g.loaded_matchparen = 1
		end,
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true,
		opts = {
			enable_bracket_in_quote = true,
			-- removed %.
			ignored_next_char = [=[[%w%%%'%[%"%`%$]]=]
		}
	},
	"github/copilot.vim"
}, opts)

vim.cmd([[Copilot disable]])

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

require("lsp") -- ./lua/lsp.lua
require('maps') -- ./lua/maps.lua
require('options') -- ./lua/options.lua
require('vim') -- ./lua/vim.lua
