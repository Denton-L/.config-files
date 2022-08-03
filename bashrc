HISTCONTROL=ignoredups
HISTSIZE=1000
HISTFILESIZE=-1

if [[ -z "$SSHHOME" ]]
then
	CONFIG_ROOT=~
else
	CONFIG_ROOT="$SSHHOME"
fi

shopt -s checkwinsize checkjobs extglob globstar

[[ -d "$CONFIG_ROOT"/.config-files/bashrc_sources/ ]] && for f in "$CONFIG_ROOT"/.config-files/bashrc_sources/*
do
	source "$f"
done

[[ -f "$CONFIG_ROOT"/bin/completions.bash ]] && source "$CONFIG_ROOT"/bin/completions.bash
[[ -f "/usr/local/etc/profile.d/bash_completion.sh" ]] && source "/usr/local/etc/profile.d/bash_completion.sh"

detach() {
	bg "$1" && disown "$1"
}

cdupgit() {
	cd "$(git rev-parse --show-toplevel)"
}

cdup() {
	cd "$(pwd | sed "s/\(.*\/$1\/\).*/\1/")"
} &&
pushdup() {
	pushd . && cdup "$@"
} &&
_cdup() {
	COMPREPLY=()

	if [[ "$COMP_CWORD" == "1" ]]
	then
		local IFS=$'\n'
		COMPREPLY=( $(compgen -W "$(echo $PWD | tr / \\n)" -- $2) )
		return 0
	fi
} &&
complete -F _cdup cdup &&
complete -F _cdup pushdup &&
type -t _ssh &> /dev/null && complete -F _ssh sshrc

alias sl=ls
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias emacs=vim
alias edtemp='$VISUAL $(mktemp)'

PS1='[\u@\h \W$(GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWUPSTREAM=auto __git_ps1 2>/dev/null)$(e=$?; [[ $e -eq 0 ]] || echo " ($e)")]\n\$ '

return 0
