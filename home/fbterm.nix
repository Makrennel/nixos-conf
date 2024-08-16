{ config, lib, pkgs, ... }: with config.lib.stylix.colors; { xdg.configFile."fbterm/fbtermrc".text = ''
# Configuration for FbTerm

# Lines starting with '#' are ignored.
# Note that end-of-line comments are NOT supported, comments must be on a line of their own.


# font family names/pixelsize used by fbterm, multiple font family names must be seperated by ','
# and using a fixed width font as the first is strongly recommended
font-names=Jetbrains Mono,Sarasa Gothic
font-size=14

# force font width (and/or height), usually for non-fixed width fonts
# legal value format: n (fw_new = n), +n (fw_new = fw_old + n), -n (fw_new = fw_old - n)
#font-width=
#font-height=

# terminal palette consists of 256 colors (0-255)
# 0 = black, 1 = red, 2 = green, 3 = brown, 4 = blue, 5 = magenta, 6 = cyan, 7 = white
# 8-15 are brighter versions of 0-7
# 16-231 is 6x6x6 color cube
# 232-255 is grayscale
color-0=${base00-hex}
color-1=${red}
color-2=${green}
color-3=${brown}
color-4=${blue}
color-5=${magenta}
color-6=${cyan}
color-7=${base05-hex}
color-8=${base03-hex}
color-9=${bright-red}
color-10=${bright-green}
color-11=${yellow}
color-12=${bright-blue}
color-13=${bright-magenta}
color-14=${bright-cyan}
color-15=${base06-hex}


# default foreground/background colors (chosen from palette)
color-foreground=7
color-background=0

# max scroll-back history lines of every window, value must be [0 - 65535], 0 means disable it
history-lines=0

# up to 5 additional text encodings, multiple encodings must be seperated by ','
# run 'iconv --list' to get available encodings.
text-encodings=

# cursor shape: 0 = underline, 1 = block
# cursor flash interval in milliseconds, 0 means disable flashing
cursor-shape=0
cursor-interval=500

# additional ascii chars considered as part of a word while auto-selecting text, except ' ', 0-9, a-z, A-Z
word-chars=._-

# change the clockwise orientation angle of screen display
# available values: 0 = 0 degree, 1 = 90 degrees, 2 = 180 degrees, 3 = 270 degrees
screen-rotate=0

# specify the favorite input method program to run
input-method=

# treat ambiguous width characters as wide
#ambiguous-wide=yes
''; }

