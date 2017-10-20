CONFIG_ROOT=${SSHHOME:-~}
shopt -s autocd checkwinsize checkjobs extglob

[[ -d $CONFIG_ROOT/.config-files/bashrc_sources/ ]] && for f in $CONFIG_ROOT/.config-files/bashrc_sources/*
do
	[[ -f $f ]] && source $f
done

[[ -f $CONFIG_ROOT/bin/completions.bash ]] && source $CONFIG_ROOT/bin/completions.bash

cdup() {
	cd "$(pwd | sed "s/\(.*\/$1\/\).*/\1/")"
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
complete -F _cdup cdup
type -t _ssh &> /dev/null && complete -F _ssh sshrc

alias sl=ls
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias emacs=vim
alias edtemp='$VISUAL $(mktemp)'

PS1='[\u@\h \W$(__git_ps1 2>/dev/null)$(e=$?; [[ $e -eq 0 ]] && echo "" || echo " ($e)")]\n\$ '

return 0
