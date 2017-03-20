---
title: Window snapping via wmctrl in Ubuntu
slug: window-snapping-via-wmctrl
category: ubuntu
tags: ubuntu, wmctrl, bash
---

Xubuntu 13.04 which I'm using makes it easy to snap windows via mouse.
But there are no keyboard shortcuts for it! Luckily, there's wmctrl
which we'll use to create our own.

We'll need `wmctrl` installed, avaiable from the standard
repositories.

```shell_session
sudo apt-get install wmctrl
```

We'll use a script for the switching. Place it somewhere in your home
directory (I did so in `~/scripts/bin/wmctrl_snap_window`) and make sure
that it's executable - for my path:

```shell_session
chmod +x petr ~/scripts/bin/wmctrl_snap_window
```

Here's the script we'll use, you don't have to understand it in order to
use it (I might explain the bits if you're interested in the comments
bellow):

```bash
#!/bin/bash
size=`wmctrl -d | head -n 1 | grep -Eho '[0-9]{4}x[0-9]{3,4}' | tail -1`
width=`echo $size | cut -d'x' -f 1`
half=$(( $width/2 ))

wmctrl -r :ACTIVE: -b remove,maximized_horz,shaded &

if [[ $1 == 'left' ]]
  then
    wmctrl -r :ACTIVE: -b add,maximized_vert -e 0,0,24,$half,-1 &
  else
    wmctrl -r :ACTIVE: -b add,maximized_vert -e 0,$half,24,$half,-1 &
fi

exit 0
```

To invoke the script, just call it with an (optional) argument `left` or
`right` (default) to snap the window to left/right half of the screen:

```shell_session
. ~/scripts/bin/wmctrl_snap_window left
```

or:

```shell_session
. ~/scripts/bin/wmctrl_snap_window right
```

With `xbindkeys` installed it's easy to assign shortcuts, like so:

```
"~/scripts/bin/wmctrl_snap_window left"
  Mod4 + Left

"~/scripts/bin/wmctrl_snap_window right"
  Mod4 + Right
```

That's it. I've also created a wmctrl script which resizes the active
window by a percentage introducing a bit of tiling window managers'
functionality to XFCE. Might write about them later.
