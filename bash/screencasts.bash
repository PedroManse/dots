function convert-video {
	infile=$1
	outfile=$2
	framerate=${3:-24}
	quality=${4:-28}
	ffmpeg -i "$infile" -vcodec libx265 -crf "$quality" -r "$framerate"  "$outfile"
}

