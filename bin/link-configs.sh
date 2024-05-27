#!/bin/bash
owner=$(command ls "$HOME"/associate/dotfiles)
config="nvim tmux"

for o in $owner; do
	for c in $config; do
    mkdir -p "$HOME/associate/config/$c"
		# path=$(realpath -q "$(find "$HOME"/associate/dotfiles/"$o" -type d -name "$c" -print0 | xargs -r -0 | awk 'NR==1 {print $1}')")
		path=$(find "$HOME"/associate/dotfiles/"$o" -type d -name "$c" -print0 | xargs -r -0 realpath -q | awk 'NR==1 {print $1}')
		if [ -n "$path" ]; then
      # echo "$path"
			ln -svnf "$path" "$HOME/associate/config/$c/$o"
      # find "$HOME/associate/config/$c/$o/" -maxdepth 1 -name "$c" #-print0 | xargs -0 rm
		fi
	done
done
