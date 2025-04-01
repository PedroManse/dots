blt() {
	case $1 in
		30|q30|Q30)
			dvc="E8:EE:CC:6F:35:FE"
		;;
		bug)
			dvc="9C:19:C2:16:86:55"
		;;
	esac
	act=$2
	case $act in
		"on")
			echo "connect $dvc" | bluetoothctl
		;;
		"off")
			echo "disconnect $dvc" | bluetoothctl
		;;
	esac
}

