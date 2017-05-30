# ~/etc/zsh.zshrc

SHELL='/bin/zsh'

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

# Source shell
emulate sh -c '. "$HOME/.profile"'

HISTFILE="$XDG_DATA_HOME/zsh/histfile"
HISTSIZE=10000
SAVEHIST=1000
REPORTTIME=10

if [[ ! -z "$LOCAL_BIN" && *"$LOCAL_BIN"* != "$PATH" ]]; then
  PATH="$LOCAL_BIN${PATH:+:$PATH}"
fi

setopt PROMPT_SUBST
setopt appendhistory
# Uncomment for extended completions
#setopt extendedglob
unsetopt beep

__zsh_prompt="$XDG_CONFIG_HOME/zsh.zsh_prompt"

if [[ -f "$__zsh_prompt" ]]; then
  source "$__zsh_prompt"
fi

unset -v __zsh_prompt

# vim: set ts=2 sw=2 et syn=zsh:
