if [ "$TMPLRS_DIR" = "" ] ; then
	TMPLRS_DIR="$HOME/Templates/tmpl-rs"
fi
python3 "$TMPLRS_DIR/go.py" $@
