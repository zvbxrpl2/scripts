#!/usr/bin/env bash
set -euo pipefail

bashrc="$HOME/.bashrc"
[[ -f "$bashrc" ]] || touch "$bashrc"
 

add_line() {
  local line="$1"
  if grep -qxF "$line" "$bashrc"; then
    echo "already present: $line"
  else
    echo "adding:        $line"
    echo "$line" >> "$bashrc"
  fi
}

add_line 'alias emacs="emacs -nw"'
add_line 'rm -rf ~/.cache/thumbnails/*'
# add_line 'rm -f  ~/.bash_history'


