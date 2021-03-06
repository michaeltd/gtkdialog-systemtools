#!/usr/bin/env bash
#
# michaeltd 2019-12-12
#shellcheck source=/dev/null disable=SC2155,SC2128

[[ "$(source /etc/os-release; echo "${ID}")" == "gentoo" ]] || { echo "This script is made for use on Gentoo systems!" >&2; exit 1; }

declare -rx FILE1=/etc/X11/xorg.conf.d
declare -rx FILE2=/etc/fstab
declare -rx FILE3=/etc/default/grub
declare -rx FILE4=/etc/portage/repos.conf
declare -rx FILE5=/etc/portage/make.conf
declare -rx FILE6=/etc/rc.conf
declare -rx FILE7=/etc/sudoers
declare -rx FILE8=/etc/bash/bashrc


declare -rx GTKDIALOG="$(type -P gtkdialog 2> /dev/null)"

export TMP_DIR="/tmp/${USER}/$(basename "${BASH_SOURCE[0]/\.bash/}")/${$}/"
mkdir -p "${TMP_DIR}" 

[[ -z "${TERMINAL}" ]] && export TERMINAL=("$(type -P gnome-terminal||type -P konsole||type -P xfce4-terminal||type -P terminology||type -P xterm)")

# DONT MESS WITH VOODOO!!!
if [[ "${TERMINAL##*/}" ==  "gnome-terminal" ]];then
    export TERMINAL+=( "-e" ) #gnome has no -h option
elif [[ "${TERMINAL##*/}" ==  "xterm" ]];then
    export TERMINAL+=( "-hold" "-e" ) #xterm has no --hold option
else
    export TERMINAL+=( "--hold" "-e" )
fi

[[ -z "${EDITOR}" ]] && export EDITOR="$(type -P gedit||type -P kate||type -P mousepad||type -P gvim)"
[[ -z "${SUDO_ASKPASS}" ]] && export SUDO_ASKPASS="$(type -P x11-ssh-askpass||type -P ssh-askpass-fullscreen)"
[[ -z "${PAGER}" ]] && export PAGER="$(type -P most||type -P less||type -P more)"

[[ -z "${GTKDIALOG}" ]] && echo "You need gtkdialog installed." >&2 && exit 1
[[ -z "${TERMINAL}" ]] && echo "You need to set a valid \$TERMINAL." >&2 && exit 1
[[ -z "${EDITOR}" ]] && echo "You need to set a valid \$EDITOR." >&2 && exit 1
[[ -z "${SUDO_ASKPASS}" ]] && echo "You need x11-ssh-askpass|ssh-askpass-fullscreen installed." >&2 && exit 1

for i in "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"/ui/*\.src; do
    source "${i}"
done

case "${1}" in
    -d|--debug) echo "${MAIN}";;
    *) "${GTKDIALOG}" --program=MAIN;;
esac
