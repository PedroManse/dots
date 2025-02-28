{enable?true}: {
	inherit enable;
	settings = {
		default = {
			path = ../../backgrounds; # send to /nix/store
			duration = "1d";
			queue-size = 3;
		};
	};
}
