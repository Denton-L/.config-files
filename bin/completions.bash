completions() {
	command -v _git_complete_revlist &&
	_git_squash() {
		if [[ "$COMP_CWORD" == "2" ]]
		then
			__git_complete_revlist
		fi

		return 0
	} &&
	complete -F _git_squash git-squash "git squash"

	command -v __gitcomp_nl &&
	command -v __git_remotes &&
	command -v __git_heads &&
	_git_delete() {
		if [[ "$COMP_CWORD" == "2" ]]
		then
			__gitcomp_nl "$(__git_remotes)"
		else
			__gitcomp_nl "$(__git_heads)"
		fi

		return 0
	} &&
	complete -F _git_delete git-delete "git delete"

	command -v __git_complete_revlist &&
	_git_squash_rebase() {
		if [[ "$COMP_CWORD" == "2" ]]
		then
			__git_complete_revlist
		fi

		return 0
	} &&
	complete -F _git_squash_rebase git-squash-rebase "git squash-rebase"

	command -v __gitcomp_nl &&
	command -v __git_remotes &&
	command -v __git_heads &&
	_git_fetch_branch() {
		if [[ "$COMP_CWORD" == "2" ]]
		then
			__gitcomp_nl "$(__git_remotes)"
		elif [[ "$COMP_CWORD" == "3" ]]
		then
			__gitcomp_nl "$(__git_heads)"
		fi

		return 0
	} &&
	complete -F _git_fetch_branch git-fetch-branch "git fetch-branch"

	command -v __gitcomp_nl &&
	command -v __git_remotes &&
	_git_push_up() {
		if [[ "$COMP_CWORD" == "2" ]]
		then
			__gitcomp_nl "$(__git_remotes)"
		fi

		return 0
	} &&
	complete -F _git_push_up git-push-up "git push-up"

	command -v __git_find_on_cmdline &&
	command -v __gitcomp &&
	command -v __gitcomp_file &&
	_git_ignore() {
		local subcommands='on off list'
		local subcommand="$(__git_find_on_cmdline "$subcommands")"

		if [[ -z "$subcommand" ]]
		then
			__gitcomp "$subcommands"
		else
			case "$subcommand" in
				on)
					__gitcomp_file
					;;
				off)
					if git rev-parse --is-inside-work-tree &> /dev/null
					then
						__gitcomp "$(git ignore list)"
					fi
					;;
				list)
					;;
			esac
		fi

		return 0
	} &&
	complete -F _git_ignore git-ignore "git ignore"

	command -v __git_complete_revlist &&
	_git_view_conflict() {
		__git_complete_revlist

		return 0
	} &&
	complete -F _git_view_conflict git-view-conflict "git view-conflict"

	command -v __git_compute_all_commands &&
	command -v __gitcomp &&
	command -v __git_all_commands &&
	command -v __git_aliases &&
	_git_git() {
		__git_compute_all_commands
		__gitcomp "$__git_all_commands $(__git_aliases)"
	} &&
	complete -F _git_git git-git "git git"

	command -v _command && complete -F _command run
}

completions &> /dev/null
