local function on_file(pattern, fn)
	vim.api.nvim_create_autocmd('FileType', {
		pattern = pattern,
		callback = fn,
	})
end

on_file({ 'c', 'cpp', 'javascript', 'typescript', 'sql', 'css', 'nix', 'rust', 'zig' }, function()
	vim.api.nvim_buf_set_keymap(0, 'n', ';', "msA;<ESC>`s", { noremap = true, silent = true })
end)

on_file({ 'go' }, function()
	vim.api.nvim_buf_set_keymap(0, 'n', ';', "msA,<ESC>`s", { noremap = true, silent = true })
end)

on_file({ 'typescript', 'javascript' }, function()
	vim.cmd([[
			iab jsf function
			iab eaf export async function
			iab jef export function
			iab udef undefined
			iab ec export const
			iab et export type
		]])
end)

on_file('rust', function()
	vim.api.nvim_buf_set_keymap(0, 'n', '<C-h>h', ":Crun<CR>a", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, 'n', '<C-h><C-h>', ":Ccheck<CR>a", { noremap = true, silent = true })
end)

on_file({ 'nix', 'haskell' }, function()
	vim.opt.expandtab = true
end)
