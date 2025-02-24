{enable?true}: {
	inherit enable;
	userName = "Pedro Manse";
	userEmail = "pedro.manse@dmk3.com.br";
	aliases = {
		f = "fetch --prune";
		c = "checkout";
		b = "branch";
	};
	delta = {
		enable = true;
	};
	extraConfig = {
		safe = {
			directory = ".";
		};
		commit = {
			gpgsign = true;
		};
		merge = {
			conflictstyle = "diff3";
		};
		core = {
			editor = "nvim";
		};
		diff = {
			colorMoved = false;
		};
		# defined in ~/.gitconfig; not here
		#user = { signingkey = ""; };
		push = {
			autoSetupRemote = true;
			default = "current";
		};
		credential = {
			helper = "!/usr/bin/gh auth git-credential";
		};
	};
}
