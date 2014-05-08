---
title: Using Sublimegit with Vintage
slug: using-sublimegit-with-vintage
category: sublime text 2
tags: sublime text 2
---

Sublimegit is great, but doesn't play well with Vintage./////

If you're not familiar with [Sublimegit](https://sublimegit.net/), go check it out, it's amazing and integrates nicely with Sublime Text workflow. However, there is a caveat - named Vintage. Vintage's option `vintage_start_in_command_mode` (which I have set to `true`) makes opening the Git: Status rather unusable.

I digged and found a way to fix this. The answer is the [ChainOfCommand](https://github.com/jisaacks/ChainOfCommand) plugin by jisaacks. It allows you to (as the name suggests) chain commands. Now we can open Git: Status in insert mode, with the following keybinding (which is of course arbitrary):

```json
{
  "keys": ["ctrl+g", "s"],
  "command": "chain",
  "args": {
    "commands": [
      ["git_status"],
      ["enter_insert_mode"]
    ]
  }
}
```

I also made a chain for commiting the changes (so that the commit message opens in insert mode as well):

```json
{
  "keys": ["c"],
  "command": "chain",
  "args": {
    "commands": [
      ["git_commit"],
      ["enter_insert_mode"]
    ]
  },
  "context": [{
    "key": "selector", "operator": "equal", "operand": "text.git-status"
  }]
},
{
  "keys": ["C"],
  "command": "chain",
  "args": {
    "commands": [
      ["git_commit", { "add": true }],
      ["enter_insert_mode"]
    ]
  },
  "context": [{
    "key": "selector", "operator": "equal", "operand": "text.git-status"
  }]
}
```