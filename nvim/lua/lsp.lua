-- vim.opt.completeopt = { "menuone", "noselect", "popup" }
-- local function merge_table(t1, t2)
-- 	local tr = t1
-- 	for k, v in pairs(t2) do tr[k] = v end
-- 	return tr
-- end
--
-- local function on_attach(client, bufnr)
-- 	vim.lsp.completion.enable(true, client.id, bufnr, {
-- 		autotrigger = true,
-- 		convert = function(item)
-- 			return { abbr = item.label:gsub("%b()", "") }
-- 		end,
-- 	})
-- 	vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
-- end

local cmp = require 'cmp'
cmp.setup {
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' }
	}, {
		{ name = 'buffer' }
	}),
	mapping = cmp.mapping.preset.insert({
		['<C-j>'] = cmp.mapping.scroll_docs(2),
		['<C-k>'] = cmp.mapping.scroll_docs(-2),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-b>'] = cmp.mapping.select_prev_item(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
}

local lsps = {
	"ts_ls",
	"nixd",
	"emmet_language_server",
	"bashls",
	"eslint",
	{
		"lua_ls",
		{ settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
	},
	{ "rust_analyzer", {
		settings = {
			["rust-analyzer"] = {
				imports = {
					granularity = {
						group = "module",
					},
					prefix = "self",
				},
				cargo = {
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true
				},
			}
		}
	} },
}

for idx, lsp in pairs(lsps) do
	if type(lsp) == "table" then
		-- local name, config = lsp[1], merge_table(lsp[2] or {}, { on_attach = on_attach })
		local name, config = lsp[1], lsp[2] or {}
		vim.lsp.enable(name)
		vim.lsp.config(name, config)
	elseif type(lsp) == "string" then
		vim.lsp.enable(lsp)
	else
		print("Error with #" .. idx .. " LSP")
	end
end
