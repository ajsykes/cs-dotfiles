# Some Registrar aliases
alias intranet='cd /afs/iastate.edu/virtual/intraregistrar/WWW/'
alias registrar='cd /afs/iastate.edu/virtual/wwwregistrar/WWW/'

# To enable the web user read/write access a directory, this command has to
# be ran. Expect I always seem to forget it so this function helps.
writable() {
	if [[ -f $1 || -d $1 ]] && [[ -n "$1" ]] ; then
		fs sa $1 vwh write;
	else
		echo "'$1' is not a valid file"
	fi
}

# A better Prompt
export PS1="[\u] [\w] > "
