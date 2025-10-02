#! /usr/bin/env bash

function work {
	git pull
	$EDITOR "$HOME/diary/work"
	gitmsg=$(date +'%d/%mT%H:%M')
	pushd "$HOME/diary"
	git commit -am "$gitmsg" -m "\nauto commit"
	git push
	popd
}

