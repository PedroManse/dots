
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

__tmpl_complete() {
	if [ ${#COMP_WORDS[@]} -gt 2 ] ; then
		return
	fi

	CR=""
	for path in "$dir"/*.sh ; do
		file=$(basename "$path")
		CR="$CR ${file%.sh}"
	done
	COMPREPLY=($(compgen -W "$CR" "${COMP_WORDS[1]}" ))
}
complete -F __tmpl_complete "tmpl"

