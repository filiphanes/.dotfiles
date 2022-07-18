setopt prompt_subst

precmd() {
    export BRANCH=$(echo_branch)
    test -z $BRANCH || export BRANCH="($BRANCH)"
    PS1="%{$fg[cyan]%}%c%{$fg[blue]%}$BRANCH%{$reset_color%}: "
}

