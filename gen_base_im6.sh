#!/bin/sh
# This will generate the base image and base mask for the badge.

# badge_width=400
# badge_height=150

# Badge Base. NOTE: rectangle dimension are off by 1 to allow for strokewidth.
convert -size 400x150 xc:transparent \
    -fill white -stroke "#ccc" -strokewidth 1 -draw "roundRectangle 0,0,399,149,10,10" \
    -draw "line 10,80,390,80" \
    -draw "line 10,130,390,130" \
    -draw "line 85,80,85,130" \
    -draw "line 165,80,165,130" \
    ./resources/badge_base.png

# Github logo
convert ./resources/badge_base.png \
    -pointsize 25  -fill "#2b2b2b" -font "./resources/hack_regular_NF.ttf" -draw 'text 367,30 ""' \
    ./resources/badge_base.png

# Generate mask for cropping avatars
convert -size 460x460 xc:transparent -fill lightblue \
    -draw "roundRectangle 0,0,460,460,40,40" \
    ./resources/mask_rect.png
