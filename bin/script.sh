#!/bin/bash
# list="bash zsh gitconfig nvim vim ranger tmux vifm xplr zathura alacritty rofi environment"
list="$(vcsh list | sed 's|vc_||g' | tr '\n' ' ')"

# file=vcsh-default
for l in $list; do
	# if grep -q vc_"$l" ~/.config/mr/available.d/$file; then
	#   grep vc_"$l" ~/.config/mr/available.d/$file >~/.config/mr/available.d/vc_"$l".vcsh
	#   echo -e '\n# vi: ft=ini syntax=sh' | tee -a /home/ru/.config/mr/available.d/vc_"$l".vcsh
	# fi

	if [ "$l" != vc ]; then
    # vcsh upgrade vc_"$l"
    # vcsh write-gitignore vc_"$l"
		vc "$l" add -f "/home/ru/.config/mr/available.d/vc_$l"
		# vc "$l" commit -m "add available.d/vc_$l"
		# echo -e "$HOME/.config/mr/available.d/vc_$l.vcsh"
	fi
	# vcsh init vc_"$l"
	# gh repo create vc_"$l" --public -y
	# vcsh run vc_"$l" git remote add origin git@github.com:svrvt/vc_"$l"
	#
	# vcsh run vc_"$l" git push --set-upstream origin main
done

# gh repo list -L 100 | grep svrvt/vc | awk '{print $1}' | sort
