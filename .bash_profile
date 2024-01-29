#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Run ssh-agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent` > /dev/null
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# Add ssh credentials
ssh-add -l > /dev/null || ssh-add

# Autostart sway on login in tty1
# https://wiki.archlinux.org/title/sway#Automatically_on_TTY_login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	echo "hi :)"
	export XDG_CURRENT_DESKTOP=sway
	exec sway
fi
