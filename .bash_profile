#
# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
	exec nohup startx > .xlog & vlock
fi
