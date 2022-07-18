function source_if_exists() {
    [ -f "$1" ] && source "$1"
}


function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        source_if_exists "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        source_if_exists "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone --depth 1 "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}


function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For completions
        completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
        fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
    completion_file="$(basename "${completion_file_path}")"
    if [ "$2" = true ] && compinit "${completion_file:1}"
}


function echo_branch() {
  # Find in all dir levels from current dir
  local branch="" dir="$PWD"
  while [[ "$dir" != '/' ]]; do
    # Find .git directory
    if [[ -d "${dir}/.git" ]]; then
      branch="${"$(<"${dir}/.git/HEAD")"##*/}"
      echo "${branch:gs/%/%%}"
      return
    fi

    # Find .hg directory
    if [[ -d "${dir}/.hg" ]]; then
      if [[ -f "${dir}/.hg/branch" ]]; then
        branch="$(<"${dir}/.hg/branch")"
      else
        branch="default"
      fi

      if [[ -f "${dir}/.hg/bookmarks.current" ]]; then
        branch="${branch}/$(<"${dir}/.hg/bookmarks.current")"
      fi

      echo "${branch:gs/%/%%}"
      return
    fi

    # Check parent directory
    dir="${dir:h}"
  done
}
