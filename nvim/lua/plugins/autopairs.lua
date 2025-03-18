return {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = true,
	opts = {
		enable_bracket_in_quote = true,
		-- removed %.
		ignored_next_char = [=[[%w%%%'%[%"%`%$]]=]
	}
}
