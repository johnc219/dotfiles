#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -A --color=auto'
alias nv='nvim'
alias hx='helix'
alias dc='docker compose'

# Add custom bin to path
export PATH="${PATH}:/home/john/bin"

# https://bugzilla.mozilla.org/show_bug.cgi?id=1368063
# https://github.com/ammen99/wf-recorder/pull/202
alias wfr='wf-recorder -g "$(slurp)" -c libvpx'

# Customize prompt
PS1='\[\e[0;35m\][\W]> \[\e[m\]'

# Run Firefox in wayland
export MOZ_ENABLE_WAYLAND=1

export XDG_CONFIG_HOME=$HOME/.config

# Set default editor
export EDITOR=helix

# Use rbenv for ruby version management
eval "$(rbenv init -)"
