#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -A --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias nv='nvim'
alias hx='helix'
alias dc='docker compose'
alias n='nnn -aeE'

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

# nnn config
export NNN_PLUG='f:fzcd;c:!echo "$PWD/$nnn" | wl-copy -n*'

# Use rbenv for ruby version management
eval "$(rbenv init -)"

# Set up volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Use bat as a colorizing pager for man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# source: https://codeberg.org/dnkl/foot/wiki#shell-integration
osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd
