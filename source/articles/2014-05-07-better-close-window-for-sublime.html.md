---
title: Better close window command for Sublime Text
slug: better-close-window-for-sublime
category: sublime text
tags: sublime text
---

I got fed up with sublime opening the last project and a new window when closed and being launched. This super-simple plugin offers a single `better_close_window` command, which closes the project and then the window.

The plugin overrides the default `close_window` shortcut (that's `ctrl+shift+w` on Win/Linux and `super+shift+w` on OSX).

## Before

1. Work on a `foo.sublime-project`.
2. Close sublime.
3. Start sublime opening a folder/project. `subl ~/bar`.
4. Two sublime windows open - first with the `foo` project, second with `~/bar` folder.

## Now

1. Work on a `foo.sublime-project`.
2. Close sublime via this plugin.
3. Start sublime opening a folder/project. `subl ~/bar`.
4. A single sublime window opens - with `~/bar` folder.

## Installation

The code is hosted on [github](https://github.com/mreq/sublime-better-close-window). You can install it via Package control in sublime.
