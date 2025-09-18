
if [ ! -z $TMPLRS_DIR ] ; then
	dir=$TMPLRS_DIR
elif [ ! -z $DOTS ] ; then
	dir="$DOTS/tmpl-rs"
else 
	dir="$HOME/Templates/tmpl-rs"
fi

tmpl () {
	if [ $# = 0 ] ; then
		echo "Usage: tmpl procedure [proc's args...]"
		return 1
	fi
	proc="$1"
	shift
	args="$@"
	bash "$dir/$proc.sh" $@
}

function __compl_tmpl() {
	COMPREPLY=(
		$(compl $DOTS/completions/tmpl.compl ${COMP_WORDS[@]:1})
	)
}
complete -F __compl_tmpl "tmpl"

