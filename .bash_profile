#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart sway on login in tty1
# https://wiki.archlinux.org/title/sway#Automatically_on_TTY_login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	echo "hi :)"
	export XDG_CURRENT_DESKTOP=sway
	exec sway
fi
