#!/bin/bash
path=source/articles/images
images=$( ls $path | grep '\.' )
length=$( echo "$images" | wc -l )

echo "$images" | xargs -I {} convert -resize 200x150^ -extent 200x150 $path/{} $path/thumbs/{}

echo "Thumbnailed $length images."