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

require("lazy").setup({
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'neovim/nvim-lspconfig',
	'mg979/vim-visual-multi',
	'lewis6991/gitsigns.nvim',
	{
		"olrtg/nvim-emmet",
		--config = function()
		--	vim.keymap.set({ "i" }, ',', require('nvim-emmet').wrap_with_abbreviation)
		--end,
	},
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
				python = {"black"},
			}
			vim.g.ale_linters = {
				javascript = {"eslint"},
				typescript = {"eslint", "typecheck"},
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

vim.api.nvim_command("Copilot disable")

require("lsp") -- ./lua/lsp.lua
require('maps') -- ./lua/maps.lua
require('options') -- ./lua/options.lua
require('vim') -- ./lua/vim.lua
