#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias ping='ping -c 4'
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
myip() { dig myip.opendns.com @resolver1.opendns.com +short ;}

# cli pastebins
sprunge() { $@ | curl -F 'sprunge=<-' sprunge.us ;}
ix() { $@ | curl -F 'f:1=<-' ix.io ;}
clbin() { $@ | curl -F 'clbin=<-' https://clbin.com ;}
clbin-scrot() { scrot -e 'curl -F "clbin=@$f" https://clbin.com' ;}

# update AdBlock easylists
bollock() { wget https://easylist-downloads.adblockplus.org/{easy{list,privacy},fanboy-annoyance}.txt -nv -N -P $HOME/.local/share/luakit/adblock/ ;}
