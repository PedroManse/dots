function __compl_tmpl() {
	COMPREPLY=(
		$(compl $DOTS/completions/tmpl.compl ${COMP_WORDS[@]:1})
	)
}
complete -F __compl_tmpl "tmpl"

