_ct_to_ns="
ns 1
us 1000
ms 1000000
s  1000000000
"

function convert() {
	table="$1"
	from="$2"
	required="$3"
	got_it=0

	export IFS=$'\n '
	for line in $table ; do
		if [ "$got_it" = 1 ] ; then
			echo "$line"
			return
		fi
		if [ "$from" = "$line" ] ; then
			got_it=1
		fi
	done

	if ! [ "$required" = "optional" ] ; then
		echo "Can't map $from with table ($table)";
		exit 1
	fi
}

### default <default value> <optional value>
function default {
	default=$1
	optional=$2
	if [ -z "$optional" ] ; then
		echo "$default"
	else
		echo "$optional"
	fi
}
