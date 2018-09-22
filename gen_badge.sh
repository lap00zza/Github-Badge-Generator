#!/bin/sh
# This script is for imagemagick 7
## Create round edged and resized avatar ##
magick composite -gravity center -compose CopyOpacity \
    ./resources/mask_rect.png ./__cache__/gh_avatar_$6.png \
    -resize 60x60 \
    ./__cache__/gh_avatar_$6_res.png

## Add the above avatar to base badge template ##
magick composite -geometry +10+10 \
    ./__cache__/gh_avatar_$6_res.png ./resources/badge_base.png \
    ./__cache__/compose_over_$6.png

## Add the actual text ##
#  is $(printf '\uf401') - nf-oct-repo
#  is $(printf '\uf450') - nf-oct-location
#  is $(printf '\ue708') - nf-dev-github_alt
#  is $(printf '\uf40c') - nf-oct-gist
#  is $(printf '\uf0c0') - nf-fa-group
#  is $(printf '\uf408') - nf-oct-mark_github
magick convert ./__cache__/compose_over_$6.png \
    -pointsize 16   -fill '#2b2b2b' -font "./resources/hack_bold_NF.ttf"      -draw "text 15,105 '$3'" \
    -pointsize 12.5 -fill '#4f4f4f' -font "./resources/hack_regular_NF.ttf"   -draw "text 15,120 ' Repos'" \
    -pointsize 16   -fill '#2b2b2b' -font "./resources/hack_bold_NF.ttf"      -draw "text 95,105 '$4'" \
    -pointsize 12.5 -fill '#4f4f4f' -font "./resources/hack_regular_NF.ttf"   -draw "text 95,120 ' Gists'" \
    -pointsize 16   -fill '#2b2b2b' -font "./resources/hack_bold_NF.ttf"      -draw "text 175,105 '$5'" \
    -pointsize 12.5 -fill '#4f4f4f' -font "./resources/hack_regular_NF.ttf"   -draw "text 175,120 ' Followers'" \
    -pointsize 20   -fill '#2b2b2b' -font "./resources/hack_bold_NF.ttf"      -draw "text 80,35 '$1'" \
    -pointsize 15   -fill '#4f4f4f' -font "./resources/hack_regular_NF.ttf"   -draw "text 80,55 '@$2'" \
    ./__cache__/gh_badge_$6.png
# -pointsize 17   -draw "text 20,130 'India'" \
# -pointsize 12.5 -draw "text 20,145 ' location'" \

## Remove temporary files ##
rm ./__cache__/gh_avatar_$6.png ./__cache__/gh_avatar_$6_res.png ./__cache__/compose_over_$6.png