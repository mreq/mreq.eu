---
title: Control spotify client via keyboard shortcuts
slug: spotify-client-shortcuts
category: ubuntu
tags: ubuntu, spotify, bash
---

Since there's no official way to control the spotify client by keyboard, I've written a script that does that./////

## About the script

The script can do the following things:

1. Launch spotify when it's not running
2. Play/pause spotify client when it's running
3. Skips the song when passed the `next` argument
4. Goes back a song when passed the `prev` argument

What it actually does is that it switches to the spotify client, clicks the button in the lower left corner and then switches back.

## Drawbacks

You have to run spotify maximized. Also you might need to tweak the `$y` variable as this one assumes you have a top panel bar.

## Installation

You'll need to have some packages installed. On *buntu:

```perl
sudo apt-get install wmctrl xdotool xbindkeys
```

Save the following script somewhere. I've got it saved as `~/scripts/play_pause_spotify.sh`.

```bash
#!/bin/bash
# See if spotify is running
if [[ $( wmctrl -lx |  grep spotify.Spotify ) ]]; then
  id=$( wmctrl -lx | grep spotify.Spotify | awk '{ print $1 }' )
  y=$(( $(  wmctrl -d | head -n1 | awk '{ print $9 }' | awk -F'x' '{ print $2 }' ) ))

  # Accept bash arguments
  if   [ $1 == next ]; then
    x=88
  elif [ $1 == prev ]; then
    x=24
  else
    x=55
  fi

  # Release alt as we'll be alt+tabing back
  xdotool keyup alt
  # Don't hide spotify if it was already selected
  if [ 0x0$( xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}' | awk -F', ' '{print $1}' ) == $id ]; then
    xdotool mousemove $x $y click 1 mousemove restore
  else
    # Switch to spotify
    wmctrl -iR $id
    # Click on the relevant button
    xdotool mousemove $x $y click 1 mousemove restore
    # Alt+tab back to what we were doing
    xdotool keyup Shift; xdotool keydown alt key Tab; xdotool keyup alt
  fi
else
  spotify &
  notify-send -i 'spotify' 'Spotify' 'Launching spotify.'
fi
```

Make it executable

```perl
chmod +x ~/scripts/play_pause_spotify.sh
```

## Usage

Play/pause spotify

```perl
~/scripts/play_pause_spotify.sh
```

Play next

```perl
~/scripts/play_pause_spotify.sh next
```

Play previous

```perl
~/scripts/play_pause_spotify.sh prev
```

## Keybindings

You can use xbindkeys to assign shortcuts. Mine are:

```
"~/scripts/play_pause_spotify.sh"
  Pause

"~/scripts/play_pause_spotify.sh next"
  Shift + Pause

"~/scripts/play_pause_spotify.sh prev"
  Control + Shift + Pause
```