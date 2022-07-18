export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef       # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/prompt.zsh"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export EDITOR=vim
export TERMINAL=alacritty
export BROWSER=firefox

export NNN_PLUG="g:_git log;$NNN_PLUG"
export NNN_PLUG="f:_flacconv \$nnn;$NNN_PLUG"
export NNN_PLUG="l:-_less -iR \$nnn*;$NNN_PLUG"
export NNN_PLUG="s:_mvp \$nnn;$NNN_PLUG"
export NNN_PLUG="o:fzopen;$NNN_PLUG"

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

case "$(uname -s)" in

Darwin)
	export HOSTNAME=$HOST
	export PATH="/opt/homebrew/opt/bison/bin:$PATH"
	export PATH="/usr/local/opt/node@16/bin:$PATH"
	# Python 3.10 until it will be default in homebrew
	export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
	export LDFLAGS="-L/opt/homebrew/opt/python@3.10/lib"
	export PKG_CONFIG_PATH="/opt/homebrew/opt/python@3.10/lib/pkgconfig"
	;;

Linux)
	# remap caps to escape
	# setxkbmap -option caps:escape
	# swap escape and caps
	setxkbmap -option caps:swapescape
	source_if_exists /usr/share/fzf/completion.zsh
	source_if_exists /usr/share/fzf/key-bindings.zsh
	source_if_exists /usr/share/doc/fzf/examples/completion.zsh
	source_if_exists /usr/share/doc/fzf/examples/key-bindings.zsh
	;;

CYGWIN*|MINGW32*|MSYS*|MINGW*)
	;;
*)
	;;
esac


compinit

# Key-bindings
bindkey -s '^o' 'nnn^M'
bindkey -s '^f' 'zi^M'
# bindkey -s '^n' 'nvim $(fzf)^M'
# bindkey -s '^v' 'nvim\n'
bindkey -s '^z' 'zi^M'
bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
#bindkey -r "^u"
#bindkey -r "^d"

