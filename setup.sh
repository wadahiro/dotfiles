#!/bin/bash

pwd=`pwd`
for f in `find . -maxdepth 1 -mindepth 1 | gawk -F/ '{print $NF}'`
do
    [ "$f" = ".git" ] && continue
    [ "$f" = "setup.sh" ] && continue

    #echo $f
    ln -snfv "$pwd/$f" "$HOME"/"$f"
done
