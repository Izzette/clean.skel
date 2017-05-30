# ~/etc/bash.bash_profile

unalias -a

__bashrc="$HOME/.bashrc"

if [[ -f "$__bashrc" && \
      -r "$__bashrc" ]]; then
  source "$__bashrc"
fi

unset -v __bashrc

# vim: set ts=2 sw=2 et syn=sh:
