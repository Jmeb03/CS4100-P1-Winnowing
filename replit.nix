{ pkgs }: {
	deps = [
   pkgs.flex_2_5_35
   pkgs.flex
		pkgs.clang_12
		pkgs.ccls
		pkgs.gdb
		pkgs.gnumake
	];
}