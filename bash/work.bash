#! /usr/bin/env bash

DEFAULT_LOG_NAME="work"
function work {
	pushd "$DIARY_REPO" || exit
	git pull --ff
	if [ -n "$1" ] ; then
		$EDITOR "$1"
	else
		$EDITOR "$DEFAULT_LOG_NAME"
	fi
	gitmsg=$(date +'%d/%mT%H:%M')
	git add .
	git commit -m "$gitmsg" -m "automatic commit"
	git push
	popd
}
alias log=work

__compl_log() {
	COMPREPLY=(
		$(compl $DOTS/completions/work.compl ${COMP_WORDS[@]:1})
	)
}
complete -F __compl_log "log"
complete -F __compl_log "work"

