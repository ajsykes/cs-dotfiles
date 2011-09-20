# Thank you ISU for not having zsh... I very sad.

# Various settings
export HISTFILE=~/.bash/.bash_history
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# Keybindings

# An easier way to complete using the history
bind '"\e[A":history-search-backward'  
bind '"\e[B":history-search-forward'  

# A somewhat sane completion, at least for bash
bind '"\t":menu-complete'

# Some Registrar aliases
alias intranet='cd /afs/iastate.edu/virtual/intraregistrar/WWW/'
alias registrar='cd /afs/iastate.edu/virtual/wwwregistrar/WWW/'

# Some Git aliases
# Thank you, Peteris: http://www.catonmat.net/blog/git-aliases/
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

# Functions

# Registrar Intranet Deployment
function deploy-intranet() {
	read -p "Are you sure you wish to deploy the Intranet?" yn
	case $yn in
		[Yy]* ) (git checkout master && git merge development && git push origin master && cd /afs/iastate.edu/virtual/intraregistrar/WWW/master/ && git pull && chmod u+x pre-deploy.sh && ./pre-deploy.sh);;
		[Nn]* ) echo 'Aborted mission.';;
		* ) echo 'Sorry, my responses are limited.';;
	esac
}

# To enable the web user read/write access a directory, this command has to
# be ran. Expect I always seem to forget it so this function helps.
writable() {
	if [[ -f $1 || -d $1 ]] && [[ -n "$1" ]] ; then
		fs sa $1 vwh write;
	else
		echo "'$1' is not a valid file"
	fi
}

# Display Content of cd folder
function cd() { builtin cd $* && ls; }

# Uncompress depending on extension...
extract() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1        ;;
			*.tar.gz)    tar xvzf $1     ;;
			*.bz2)       bunzip2 $1       ;;
			*.rar)       unrar x $1     ;;
			*.gz)        gunzip $1     ;;
			*.tar)       tar xvf $1        ;;
			*.tbz2)      tar xvjf $1      ;;
			*.tgz)       tar xvzf $1       ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1    ;;
			*)           echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# A better Prompt
export PS1="[\u] [\w] > "
