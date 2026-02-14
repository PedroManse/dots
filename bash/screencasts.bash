function convert-video {
	infile=$1
	outfile=$2
	framerate=$(default 24 "$3")
	quality=$(default 28 "$4")
	ffmpeg -i "$infile" -vcodec libx265 -crf "$quality" -r "$framerate"  "$outfile"
}

