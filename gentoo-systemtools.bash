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
export TMP_FILE="/tmp/${$}.txt"
#shellcheck disable=SC2155
[[ -z "${EDITOR}" ]] && export EDITOR="$(type -P vi 2> /dev/null||type -P vim 2> /dev/null||type -P nano 2> /dev/null)"
#shellcheck disable=SC2155
[[ -z "${SUDO_ASKPASS}" ]] && export SUDO_ASKPASS="$(type -P x11-ssh-askpass 2> /dev/null||type -P ssh-askpass-fullscreen 2> /dev/null)"
#shellcheck disable=SC2155
[[ -z "${PAGER}" ]] && export PAGER="$(type -P most 2> /dev/null||type -P less 2> /dev/null||type -P more 2> /dev/null)"

[[ -z "${GTKDIALOG}" ]] && echo "You need gtkdialog installed." >&2 && exit 1
[[ -z "${EDITOR}" ]] && echo "You need vim|nano installed." >&2 && exit 1
[[ ! -x "$(type -P xterm 2> /dev/null)" ]] && echo "You need xterm installed." >&2 && exit 1
[[ -z "${SUDO_ASKPASS}" ]] && echo "You need x11-ssh-askpass|ssh-askpass-fullscreen installed." >&2 && exit 1

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/INSTALL"

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/SEARCH"

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/MAIN"

case "${1}" in
    -d | --dump) echo "${MAIN}";;
    *) "${GTKDIALOG}" --center --program=MAIN;;
esac
