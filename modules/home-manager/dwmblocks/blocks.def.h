//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		                                     /*Update Interval*//*Update Signal*/
    {"", ".config/nixos/modules/home-manager/dwmblocks/blocks/sb-network",    0,                 9},
    {"", ".config/nixos/modules/home-manager/dwmblocks/blocks/sb-volume",     0,                10},
    {"", ".config/nixos/modules/home-manager/dwmblocks/blocks/sb-battery",    5,                 0},
	{"", "date '+ %a %b %d %I:%M %p'",					                      5,	             0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
