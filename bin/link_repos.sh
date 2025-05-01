#!/bin/bash
o_dir="$HOME/src/github.com"
owner=$(command ls "$o_dir")
config="nvim tmux zellij ranger xplr bash zsh shell scripts awesome bin wezterm alacritty"

for c in $config; do
	path=()
	mkdir -p "$HOME/src/config/$c"
done

mkdir -p "$HOME"/src/{ansible/{dot-lab,full-up,ollama},docker,hummingbot,config/{vcsh,},orthanc}

for o in $owner; do
	for c in $config; do
		path=()
		while IFS= read -r line; do
			path+=("$line")
			# done < <(find "$o_dir/$o" -type d -name "$c" -print0 | xargs -r -0 realpath -q)
		done < <(find "$o_dir/$o" -type d -name "$c")
		if [ -n "${path[*]}" ]; then
			if [ "${#path[*]}" == 1 ]; then
				path="${path[0]}"
			elif [ "${#path[*]}" -gt 1 ]; then
				if [[ "${path[1]}" == "${path[0]}"* ]]; then
					path="${path[1]}"
				else
					break
					# echo "${path[0]}"
					# echo "${path[1]}"
				fi
			fi
			# echo "${#path[@]} ${path[*]}"
			ln -svnf "$path" "$HOME/src/config/$c/$o"
			# find "$HOME/associate/config/$c/$o/" -maxdepth 1 -name "$c" #-print0 | xargs -0 rm
		fi
	done
done
