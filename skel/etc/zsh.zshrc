# ~/etc/zsh.zshrc

SHELL='/bin/zsh'

# Source shell
emulate sh -c '. "$HOME/.profile"'

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

mkdir -p "$XDG_DATA_HOME/zsh"

HISTFILE="$XDG_DATA_HOME/zsh/histfile"
HISTSIZE=10000
SAVEHIST=1000
REPORTTIME=10

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

__zsh_plugins_home="$XDG_CONFIG_HOME/zsh.plugins"

if [[ -d "$__zsh_plugins_home" ]]; then
  for __zsh_plugin_dir in "$__zsh_plugins_home"/*; do
    if [[ ! -d "$__zsh_plugin_dir" ]]; then
      break
    fi

    __zsh_plugin="$__zsh_plugin_dir/$(basename "$__zsh_plugin_dir").zsh"
    if [[ -f "$__zsh_plugin" ]]; then
      source "$__zsh_plugin"
    fi
    unset -v __zsh_plugin
  done

  unset -v __zsh_plugin_dir
fi

unset -v __zsh_plugins_home

# vim: set ts=2 sw=2 et syn=zsh:
