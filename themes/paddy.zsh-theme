function prompt_char {
	git branch >/dev/null 2>/dev/null && echo '%' && return
	echo '$'
}

function get_directory {
	DIR=${PWD/#$HOME/\~}
	if [[ ! -f ~/.specialdirs || ! -r ~/.specialdirs ]]; then
		echo $DIR && return
	fi
	while read line
	do
		[[ $line = "#"* ]] && continue
		variable=$(echo ${line[(ws:=:)1]} | sed -e 's/^ *//' | sed -e 's/ *$//' | sed -e 's/^export *//')
		dir=$(echo ${line[(ws:=:)2]} | sed -e 's/^ *//' | sed -e 's/ *$//')
		[[ $DIR = $dir* ]] && echo ${DIR/#$dir/%{$reset_color%}%{$FG[003]%}\$$variable%{$fg_bold[green]%}} && return
	done < ~/.specialdirs
	echo $DIR && return
}

PROMPT='%{$fg[blue]%}$(hostname -s)%{$reset_color%} > %{$fg_bold[green]%}$(get_directory)%{$reset_color%}$(git_prompt_info) $(prompt_char) '
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GET_PROMPT_CLEAN=""
