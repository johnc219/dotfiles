#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# SSH agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 24h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

alias ls='ls -A --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias nv='nvim'
alias hx='helix'
alias dc='docker compose'
alias n='nnn -aeEA'
alias uhk='DESKTOPINTEGRATION=no /opt/appimages/UHK.Agent.AppImage --ozone-platform-hint=auto'

# https://bugzilla.mozilla.org/show_bug.cgi?id=1368063
# https://github.com/ammen99/wf-recorder/pull/202
alias wfr='wf-recorder -g "$(slurp)" -c libvpx'

# Add custom bin to path
export PATH="${PATH}:/home/john/bin"

# Customize prompt
source /usr/share/git/git-prompt.sh
PS1='\[\e[0;35m\][\W]$(__git_ps1 " (%s)") > \[\e[m\]'

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
prompt_marker() {
    printf '\e]133;A\e\\'
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }prompt_marker
