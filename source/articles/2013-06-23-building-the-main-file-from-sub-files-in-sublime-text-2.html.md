---
title: Building the main file from sub-files in Sublime Text
slug: building-the-main-file-from-sub-files-in-sublime-text-2
category: sublime text
tags: sublime text
---

How to build a master file when working with sub-files? I've encountered this question on IRC and superuser often enough to create a post about it./////

You don't have to change the main-file in any way. For the sub-files, use a first-line comment like in the TeX file bellow:

```tex
%!../main_file.tex
\textbf{Some TeX stuff} in a sub-file.

We want to build the main_file.tex which is one dir above \texttt{../}.
```

Create a custom build script, which looks at the first line:

```bash
match=`head -n1 $1 | grep %!`

if [[ $match ]]
    then
        # do stuff with the parent's name, which is ${match:2:100}
    else
        # no match :/
fi
```

Add the build to Sublime:

```json
{
    "cmd": ["/path/to/build/script.sh", "$file"],
    "selector": "whatever"
}
```

That's it! To end with, here's my XeLaTeX build file as an example:

```bash
#!/bin/bash
file="$1"
flag="-halt-on-error"

match=`head -n1 $file | grep %!`

if [[ $match ]]
    then
        if [ ${match:2:3} = ../ ]
            then
                cd .. &amp;&amp;
                target=${match:5:100}
            else
                target=${match:2:100}
        fi
    else
        target=$file
fi
rubber -c 'set arguments -shell-escape' -f -m xelatex -W all $target

exit 0
```
