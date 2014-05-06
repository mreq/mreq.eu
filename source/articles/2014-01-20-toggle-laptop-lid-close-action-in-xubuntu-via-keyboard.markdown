---
title: Toggle laptop lid close action in Xubuntu via keyboard
slug: toggle-laptop-lid-close-action-in-xubuntu-via-keyboard
category: ubuntu
tags: ubuntu, xfce, bash
---

If you need to change the lid close action now and then a don't like clicking through the menus, you can use a script I wrote.///// The script is quite simple:

```bash
#!/bin/bash
state=`xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-ac`

if [ $state -eq 0 ]
	then
		# is set to do nothing -> set to suspend
		target=1
		message="suspend"
		icon="lock"
	else
		# is set to suspend -> set to do nothing
		target=0
		message="do nothing"
		icon="window-close"
fi

xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-ac -s $target
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-battery -s $target

notify-send -i $icon "Lid action changed" "to $message."
```

Be sure to check the icon and/or the messages written in the notification to fit your theme nicely. Save the script, `chmod +x` it and assign a keyboard shortcut, i.e. with `xbindkeys`:

```
"~/scripts/change_lid_action.sh"
	Mod4 + F12
```

Enjoy!