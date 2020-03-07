#!/bin/bash
#
# michaeltd 2019-12-12
#shellcheck source=/dev/null

export FILE1=/etc/X11/xorg.conf.d
export FILE2=/etc/fstab
export FILE3=/etc/default/grub
export FILE4=/etc/portage/repos.conf
export FILE5=/etc/portage/make.conf
export FILE6=/etc/rc.conf
export FILE7=/etc/sudoers
export FILE8=/etc/bash/bashrc

#shellcheck disable=SC2155
export GTKDIALOG="$(type -P gtkdialog 2> /dev/null)"
export TMP_DIR="/tmp/${USER}/$(basename ${BASH_SOURCE[0]/\.bash/})/${$}/"

mkdir -vp "${TMP_DIR}" 

export TMP_FILE="/tmp/${$}.txt"

#shellcheck disable=SC2034 # GO HOME SHELLCHECK, YOU'RE DRUNK!!!
#[[ -z "${EDITOR}" ]] && export EDITOR="$(type -P vi 2> /dev/null||type -P vim 2> /dev/null||type -P nano 2> /dev/null)"
#shellcheck disable=SC2155
[[ -z "${TERMINAL}" ]] && export TERMINAL=( "$(type -P gnome-terminal||type -P konsole||type -P xfce4-terminal||type -P terminology||type -P xterm)" )

# DONT MESS WITH VOODOO!!!
if [[ "${TERMINAL##*/}" ==  "gnome-terminal" ]];then
    export TERMINAL+=( "-e" ) #gnome has no -h option
elif [[ "${TERMINAL##*/}" ==  "xterm" ]];then
    export TERMINAL+=( "-hold" "-e" ) #xterm has no --hold option
else
    export TERMINAL+=( "--hold" "-e" )
fi

#shellcheck disable=SC2155
[[ -z "${EDITOR}" ]] && export EDITOR="$(type -P gedit||type -P kate||type -P mousepad||type -P gvim)"
#shellcheck disable=SC2155
[[ -z "${SUDO_ASKPASS}" ]] && export SUDO_ASKPASS="$(type -P x11-ssh-askpass||type -P ssh-askpass-fullscreen)"
#shellcheck disable=SC2155
[[ -z "${PAGER}" ]] && export PAGER="$(type -P most||type -P less||type -P more)"

[[ -z "${GTKDIALOG}" ]] && echo "You need gtkdialog installed." >&2 && exit 1
[[ -z "${TERMINAL}" ]] && echo "You need to set a valid \$TERMINAL." >&2 && exit 1
[[ -z "${EDITOR}" ]] && echo "You need to set a valid \$EDITOR." >&2 && exit 1
[[ -z "${SUDO_ASKPASS}" ]] && echo "You need x11-ssh-askpass|ssh-askpass-fullscreen installed." >&2 && exit 1

for i in "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"/*\.src; do
    source "${i}"
done

case "${1}" in
    -d|--debug) echo "${MAIN}";;
    *) "${GTKDIALOG}" --program=MAIN;;
esac
