#!/bin/bash
# list="bash zsh gitconfig nvim vim ranger tmux vifm xplr zathura"
list="alacritty rofi environment"

for l in $list; do
	vcsh init vc_"$l"
	gh repo create vc_"$l" --public -y
	vcsh run vc_"$l" git remote add origin git@github.com:svrvt/vc_"$l"
	# vcsh run vc_"$l" git push --set-upstream origin main
done

# gh repo list -L 100 | grep svrvt/vc | awk '{print $1}' | sort
