# ~/etc/bash.bashrc

# If not running interactively, don't do anything
if [[ "$-" != *'i'* ]]; then
  return
fi

# Source shell
source "$HOME/.profile"

__bash_prompt="$XDG_CONFIG_HOME/bash.bash_prompt"

if [[ -f "$__bash_prompt" && \
      -r "$__bash_prompt" ]]; then
  source "$__bash_prompt"
fi

unset -v __bash_prompt

# Append to history instead of overwrite
shopt -s histappend

# vim: set ts=2 sw=2 et syn=sh:
