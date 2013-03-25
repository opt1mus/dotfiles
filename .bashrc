#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias ping='ping -c 3'
alias vim='vim -X'

# list - maintain order
alias ls='ls -F --color=auto'
alias la='ls -Ahil'
alias ll='ls -l'

# ask before foo
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'

# variable
export EDITOR='vim'
export PAGER='less'
export HISTCONTROL='ignoreboth:erasedups'
export HISTIGNORE='cd *:&:exit:history:l[asl]'
export HISTSIZE='100'

# misc
stty -ctlecho

# prompt KISS
PS1='>'
PS2='\\'

# external IP
myip() { curl -s http://ifconfig.me/ ;}

# sprunge
sprunge() { $@ | curl -F 'sprunge=<-' sprunge.us ;}
