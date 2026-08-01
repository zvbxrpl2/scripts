#!/bin/bash


if grep --quiet "alias emacs" ~/.bashrc; then
	echo emacs alias already exists
else
	echo writing emacs alias
	echo 'alias emacs="emacs -nw"' >> ~/.bashrc
fi


if grep --quiet "rm -rf ~/.cache/thumbnails/*" ~/.bashrc; then
	echo cache thumbnail cleanup already exists
else
	echo writing thumbnail cleanup
	echo 'rm -rf ~/.cache/thumbnails/*' >> ~/.bashrc
fi


if grep --quiet "rm -rf ~/.bash_history" ~/.bashrc; then
	echo bash history cleanup already exists
else
	echo writing bash history cleanup
	echo 'rm -rf ~/.bash_history"' >> ~/.bashrc
fi
