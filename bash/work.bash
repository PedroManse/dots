#! /usr/bin/env bash
DIARY_REPO="$HOME/diary"
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
	git commit -m "$gitmsg" -m "\nautomatic commit"
	git push
	popd
}

