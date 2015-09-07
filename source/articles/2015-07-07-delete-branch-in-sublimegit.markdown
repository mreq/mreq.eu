---
title: Delete branch in SublimeGit
slug: delete-branch-in-sublimegit
category: sublime text 2
tags: sublime text 2
---

Sublimegit can't delete branches./////

I've written a simple sublime plugin, which enables unix users to do so.

```python
import sublime
import sublime_plugin
import subprocess

class GitDeleteBranch(sublime_plugin.WindowCommand):
  def run(self):
    view = self.window.active_view()
    cmd = 'cd ' + self.window.folders()[0] + '; git branch | cut -c 3-'
    a = subprocess.check_output(cmd, shell=True)
    branches = bytes.decode(a).splitlines()
    targetBranch = ''
    def doDelete(i):
      global targetBranch
      if i == 0:
        self.window.run_command('git_custom', {
          'cmd': 'branch -d ' + targetBranch,
          'output': 'panel',
          'async': True
        })
    def onDone(i):
      global targetBranch
      if i != -1:
        targetBranch = branches[i]
        options = ['Yes, delete ' + targetBranch + '.', 'Do not delete anything.']
        self.window.show_quick_panel(options, doDelete)
    self.window.show_quick_panel(branches, onDone)
```

Save that as `git_delete_branch.py` in your User folder. The plugin lists your branches, let's you select one, which is (after confirmation) deleted.

To have a command available, simply extend your `*.sublime-commands` with:

```json
{
  "caption": "Git: Delete Branch",
  "command": "git_delete_branch"
}
```