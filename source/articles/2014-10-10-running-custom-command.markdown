---
title: Running custom command on file/folder in Sublime
slug: running-custom-command
category: sublime text 2
tags: sublime text 2
---

Ever needed to run a command on currently editting file/folder? I've made a simple plugin to do just that./////

Save the following as `run_cmd.py` in your `Packages/User` folder.

```python
import os
import sublime
import sublime_plugin

class RunCmd(sublime_plugin.WindowCommand):
  def run(self, cmd):
    if "$file_name" in cmd:
      view = self.window.active_view()
      cmd = cmd.replace("$file_name",view.file_name())
    if "$file_dir" in cmd:
      view = self.window.active_view()
      cmd = cmd.replace("$file_dir",os.path.split(view.file_name())[0])
    print 'Running custom command:', cmd
    os.system(cmd + " &")
```

Now it's super easy to run commands. Strings `$file_name` and `$file_dir` are replaced with file's name or directory, respectively.

Want to run Double Commander on file's folder? Add this to your `Commands.sublime-commands`:

```json
{
  "caption": "doublecmd",
  "command": "run_cmd",
  "args": {
    "cmd": "doublecmd $file_dir"
  }
}
```

Need to run `gitk` on the current file? Ok:

```json
{
  "caption": "Gitk: Current file",
  "command": "run_cmd",
  "args": {
    "cmd": "gitk $file_name"
  }
}
```

Create a `tmux` shell with `R` in CWD? I think you've got the point...

```json
{
  "caption": "rmux",
  "command": "run_cmd",
  "args": {
    "cmd": "terminator --working-directory='$file_dir' -x /usr/bin/tmux new 'R --no-save'"
  }
}
````
