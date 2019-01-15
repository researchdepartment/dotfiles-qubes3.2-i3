#set fish_greeting

#if status --is-interactive
#    set PATH $PATH /snap/bin;
#end


alias help='tldr'
alias psg="ps aux | grep"
alias ping='prettyping --nolegend'
alias hsg="history | grep"
alias ls='ls -haltor --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias findin='egrep -rl'
alias findinphp='egrep -rl --include=\*.php'
alias findintxt='egrep -rl --include=\*.txt'
alias cp='cp -v'
alias rm='rm -v --preserve-root'
alias nano='nano -w'
alias ipinfo="wget -qO- https://n1.a52.io/s/ip.php ; echo"

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
