#!/bin/bash
sh generate_thumbnails.sh
middleman build
rm -rf build/tagged
rsync -avz /home/petr/work/mreq-blog/build/ mreq:/home/petr/php/mreq
	
notify-send -u low -i emblem-default 'Build done.' 'Changes rsynced.'