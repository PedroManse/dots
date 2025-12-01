function default {
	default=$1
	optional=$2
	if [ -z "$optional" ] ; then
		echo "$default"
	else
		echo "$optional"
	fi
}

function convert {
	infile=$1
	outfile=$2
	framerate=$(default 24 "$3")
	quality=$(default 28 "$4")
	ffmpeg -i "$infile" -vcodec libx265 -crf "$quality" -r "$framerate"  "$outfile"
}

