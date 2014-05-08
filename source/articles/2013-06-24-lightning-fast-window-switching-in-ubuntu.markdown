---
title: Lightning fast window switching in ubuntu
slug: lightning-fast-window-switching-in-ubuntu
category: ubuntu
tags: ubuntu, wmctrl, bash
---

A tutorial on how to switch windows in Ubuntu really fast./////

We'll need `wmctrl` and `xbindkeys` installed, both avaiable from the standard repositories:

```perl
sudo apt-get install wmctrl xbindkeys
```

We'll use a script for the switching. Place it somewhere in your home directory (I did so in `~/scripts/bin/switch_to_app`) and make sure that it's executable - for my path:

```perl
chmod +x petr ~/scripts/bin/switch_to_app
```

Here's the script we'll use, you don't have to understand it in order to use it:

```bash
#!/bin/bash
app_name=$1
workspace_number=`wmctrl -d | grep '\*' | cut -d' ' -f 1`
win_list=`wmctrl -lx | grep $app_name | grep " $workspace_number " | awk '{print $1}'`

if [[ $win_list ]]; then
  active_win_id=`xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}' | awk -F', ' '{print $1}'`
  if [ "$active_win_id" == "0" ]; then
    active_win_id=""
  fi

  # get next window to focus on, removing id active
  switch_to=`echo $win_list | sed s/.*$active_win_id// | awk '{print $1}'`
  # if the current window is the last in the list ... take the first one
  if [ "$switch_to" == "" ]; then
    switch_to=`echo $win_list | awk '{print $1}'`
  fi
fi
if [[ $switch_to ]]
  then
    wmctrl -ia "$switch_to" &
  else
    if [[ $2 ]]; then
      $2 &
    fi
fi

exit 0
```

To use the script, you invoke it by it's name and pass window identifier (see `wmctrl -lx`) as the first argument and an optional command as the second argument. If the script doesn't find the window by identifier and a command is present, it executes it.

Aftewards make a `~/.xbindkeysrc` file with defined shortcuts, syntax is pretty straightforward:

```
"~/scripts/bin/switch_to_app 'chromium-browser.Chromium-browser' chromium-browser"
    Mod4 + 1

"~/scripts/bin/switch_to_app 'sublime_text.sublime-text-2' subl"
    Mod4 + 2

"~/scripts/bin/switch_to_app 'terminator.Terminator' terminator"
    Mod4 + 3
```

Once xbindkeys is loaded, fire your shortcuts at will. If you have multiple windows of an app opened, the script cycles through them. If you modify `.xbindkeysrc` you can restart xbindkeys by:

```perl
killall xbindkeys && xbindkeys​
```

The script was written for Xubuntu but should work with any DE. In Xubuntu it filters out other workspaces, which doesn't work with Compiz. Am not sure about Metacity.