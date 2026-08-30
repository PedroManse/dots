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

function convert2() {
	data=$(trim_string "$1")
	query_key=$(trim_string "$2")
	store_into=$(trim_string "${3:-REPLY}")

	export IFS=$'\n'
	for line in $data ; do
		export IFS=' '
		declare -a data_array=()
		read -ra data_array <<< "$line"
		line_key=$(trim_string "${data_array[0]}")
		if [ "$query_key" = "$line_key" ] ; then
			read -ra "${store_into?}" <<< "${data_array[*]:1}"
			return 0
		fi
	done
	return 1
}

# $1 = Current Item
# $2 IFS="\n" string or Items
#
# If $1 not in $2, first line of $2 will be returned
function cyclic_find_next_item {
	old_item=$1
	items=$2

	found_current=0
	for item in $items ; do
		if [ "$item" = "$old_item" ] ; then
			found_current=1
		elif [ "$found_current" = "1" ] ; then
			echo "$item"
			found_current=2
			break
		fi
	done
	if [ "$found_current" != "2" ] ; then
		echo "$items" | head -n1
	fi
}

function trim_string {
	echo "$1" | awk '{$1=$1};1'
}
