return {
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
}
