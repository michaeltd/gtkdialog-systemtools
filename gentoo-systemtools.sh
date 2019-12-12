#!/bin/bash

export FILE1=/etc/X11/xorg.conf.d
export FILE2=/etc/fstab
export FILE3=/etc/default/grub
export FILE4=/etc/portage/repos.conf
export FILE5=/etc/portage/make.conf
export FILE6=/etc/rc.conf
export FILE7=/etc/sudoers
export FILE8=/etc/bash/bashrc

export GTKDIALOG="$(which gtkdialog)"
export TMP_FILE="/tmp/${$}.txt"
[[ -z "${EDITOR}" ]] && export EDITOR="$(which vi||which vim||which nano)"
[[ -z "${SUDO_ASKPASS}" ]] && export SUDO_ASKPASS="$(which x11-ssh-askpass||which ssh-askpass-fullscreen)"
[[ -z "${PAGER}" ]] && export PAGER="$(which most 2> /dev/null || which less 2> /dev/null || which more 2> /dev/null)"

[[ -z "${GTKDIALOG}" ]] && echo "You need gtkdialog installed." >&2 && exit 1
[[ -z "${EDITOR}" ]] && echo "You need vim|nano installed." >&2 && exit 1
[[ ! -x "$(which xterm)" ]] && echo "You need xterm installed." >&2 && exit 1
[[ -z "${SUDO_ASKPASS}" ]] && echo "You need x11-ssh-askpass|ssh-askpass-fullscreen installed." >&2 && exit 1

export QUESTION_INSTALL='
<vbox>
<text wrap="false" xalign="0">
<label>To be able to perform all the operations,</label>
</text>
<text wrap="false" xalign="0">
<label>the following apps must be installed:</label>
</text>
<text wrap="false" xalign="0">
<label>dmidecode lm_sensors lshw mesa-demos xdpyinfo usbutils.</label>
</text>
<text wrap="false" xalign="0">
<label>Do you want to install them?</label>
</text>
<hbox>
<button ok></button>
<button cancel></button>
</hbox>
</vbox>'

export QUESTION_SEARCH='
<vbox>
<text wrap="false" xalign="0">
<label>Enter search term:</label>
</text>
<entry>
<default>SEARCH_TERM</default>
<variable export="true">SEARCH</variable>
</entry>
<hbox>
<button ok></button>
<button cancel></button>
</hbox>
</vbox>'

export MAIN_DIALOG='
<window window_position="1" title="GENTOO System Tools">
<vbox>
<hbox homogeneous="True">
<frame>
<hbox homogeneous="True">
<hbox>
<button>
<input file stock="gtk-network"></input>
<action>xterm &</action>
</button>
</hbox>

<vbox homogeneous="True">
<button>
<label>TOP</label>
<action>xterm -e top &</action>
</button>

<button>
<input file stock="gtk-dialog-warning"></input>
<action>sudo -A xterm -e top &</action>
</button>
</vbox>
</hbox>
</frame>

<vbox>
<frame Kernel messages>
<button>
<label>View messages</label>
<action>dmesg > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</button>

<entry><variable export="true">VAR2</variable></entry>

<hbox>
<button>
<label>search</label>
<input file stock="gtk-find"></input>
<action>dmesg | grep ${VAR2} > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE} </action>
</button>

</hbox>
</frame>
</vbox>
</hbox>

<frame Commands Information>
<hbox>
<text> <label>Command:</label> </text>
<entry><variable export="true">VAR1</variable></entry>
</hbox>

<hbox>
<button>
<label>Help</label>
<action>${VAR1} --help > ${TMP_FILE} && xterm -e ${EDITOR} ${TMP_FILE}</action>
</button>

<button>
<label>Whereis</label>
<action>whereis ${VAR1} > ${TMP_FILE} && xterm -e ${EDITOR} ${TMP_FILE}</action>
</button>

<button>
<label>Which</label>
<action>which ${VAR1} > ${TMP_FILE} && xterm -e ${EDITOR} ${TMP_FILE}</action>
</button>

<button>
<label>Version</label>
<action>${VAR1} --version > ${TMP_FILE} && xterm -e ${EDITOR} ${TMP_FILE}</action>
</button>

<button>
<label>Manual</label>
<action>man ${VAR1} > ${TMP_FILE} && xterm -e ${EDITOR} ${TMP_FILE}</action>
</button>
</hbox>
</frame>
<hbox homogeneous="True">

<frame>
<vbox>
<button homogeneous="true">
<input file stock="gtk-index"></input>
<label>Sensors</label>
<action>sensors > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</button>

<button homogeneous="true">
<input file stock="gtk-connect"></input>
<label>Ethernet Interfaces</label>
<action>ifconfig > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</button>

<button homogeneous="true">
<input file stock="gtk-disconnect"></input>
<label>Wireless Interfaces</label>
<action>iwconfig > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</button>

<button homogeneous="true">
<input file stock="gtk-save"></input>
<label>emerge logs</label>
<action>sudo -A xterm -e ${PAGER} /var/log/emerge.log</action>
</button>

<button homogeneous="true">
<input file stock="gtk-floppy"></input>
<label>Hardware information </label>
<action>sudo -A lshw > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</button>

<button homogeneous="true">
<input file stock="gtk-print-preview"></input>
<label>BIOS information</label>
<action>sudo -A dmidecode | head -15 > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</button>

<button homogeneous="true">
<input file stock="gtk-page-setup"></input>
<label>PCI devices</label>
<action>lspci > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</button>
</vbox>
</frame>

<frame>
<vbox>
<hbox>
<pixmap>
<input file stock="gtk-about"></input>
</pixmap>

<menubar>
<menu>
<menuitem>
<label>Running kernel</label>
<action>uname -a > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>

<menuitem>
<label>Show Path</label>
<action>echo "${PATH}" > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>
<label>System Information</label>
</menu>
</menubar>
</hbox>

<hbox>
<pixmap>
<input file stock="gtk-preferences"></input>
</pixmap>

<menubar>
<menu>
<menuitem>
<label>List @world contents</label>
<action>sudo -A cat /var/lib/portage/world &> ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>
<menuitem>
<label>List Installed Ebuilds</label>
<action>cd /var/db/pkg/ && /bin/ls -d1 */* > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>
<menuitem>
<label>Search Installed Ebuilds</label>
<action>${GTKDIALOG} --program=QUESTION_SEARCH > ${TMP_FILE} && source ${TMP_FILE} && [[ "${EXIT}" == "OK" ]] && cd /var/db/pkg/ && /bin/ls -d1 */* | grep ${SEARCH} > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>
<menuitem>
<label>Search Gentoo tree</label>
<action>${GTKDIALOG} --program=QUESTION_SEARCH > ${TMP_FILE} && source ${TMP_FILE} && [[ "${EXIT}" == "OK" ]] && xterm -hold -e emerge -sS ${SEARCH}</action>
</menuitem>
<label>Gentoo tree</label>
</menu>
</menubar>
</hbox>

<hbox>
<pixmap>
<input file stock="gtk-harddisk"></input>
</pixmap>

<menubar>
<menu>
<menuitem>
<label>Hard drive partitions</label>
<action>sudo -A fdisk -l > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>

<menuitem>
<label>Hard drive UUID</label>
<action>blkid > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>

<menuitem>
<label>Current mount points</label>
<action>mount > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>

<menuitem>
<label>Available disk space</label>
<action>df -h > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>

<menuitem>
<label>Connected USB devices</label>
<action>lsusb > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>

<label>Devices</label>
</menu>
</menubar>
</hbox>

<hbox>
<pixmap>
<input file stock="gtk-cancel"></input>
</pixmap>

<menubar>
<menu>
<menuitem>
<label>X-Server information</label>
<action>xdpyinfo > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>

<menuitem>
<label>GLX/OpenGL Information</label>
<action>glxinfo > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>

<label>X-Server</label>
</menu>
</menubar>
</hbox>

<hbox>
<pixmap>
<input file stock="gtk-orientation-portrait"></input>
</pixmap>

<menubar>
<menu>
<menuitem>
<label>Group memberships</label>
<action>groups > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</menuitem>

<menuitem>
<label>Groups</label>
<action>xterm -e ${PAGER} /etc/group</action>
</menuitem>

<label>Groups</label>
</menu>
</menubar>
</hbox>

<button>
<label>Loaded modules</label>
<action>lsmod > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</button>

<button>
<label>Services</label>
<action>rc-update > ${TMP_FILE} && xterm -e ${PAGER} ${TMP_FILE}</action>
</button>

</vbox>
</frame>
</hbox>

<hbox>
<frame System Files>
<hbox>
<button><label>'${FILE1}'</label><action>xterm -e ${PAGER} ${FILE1}</action></button>
<button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${EDITOR} ${FILE1}</action></button>
</hbox>

<hbox>
<button><label>'${FILE2}'</label><action>xterm -e ${PAGER} ${FILE2}</action></button>
<button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${EDITOR} ${FILE2}</action></button>
</hbox>

<hbox>
<button><label>'${FILE3}'</label><action>xterm -e ${PAGER} ${FILE3}</action></button>
<button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${EDITOR} ${FILE3}</action></button>
</hbox>

<hbox>
<button><label>'${FILE4}'</label><action>xterm -e ${PAGER} ${FILE4}</action></button>
<button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${EDITOR} ${FILE4}</action></button>
</hbox>
</frame>

<frame>
<hbox>
<button><label>'${FILE5}'</label><action>xterm -e ${PAGER} ${FILE5}</action></button>
<button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${EDITOR} ${FILE5}</action></button>
</hbox>

<hbox>
<button><label>'${FILE6}'</label><action>xterm -e ${PAGER} ${FILE6}</action></button>
<button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${EDITOR} ${FILE6}</action></button>
</hbox>

<hbox>
<button><label>'${FILE7}'</label><action>sudo -A xterm -e ${PAGER} ${FILE7}</action></button>
<button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${EDITOR} ${FILE7}</action></button>
</hbox>

<hbox>
<button><label>'${FILE8}'</label><action>xterm -e ${PAGER} ${FILE8}</action></button>
<button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${EDITOR} ${FILE8}</action></button>
</hbox>
</frame>
</hbox>

<frame>
<hbox homogeneous="True">
<button>
<input file stock="gtk-info"></input>
<action>${GTKDIALOG} --program=QUESTION_INSTALL > ${TMP_FILE} && source ${TMP_FILE} && [[ "${EXIT}" == "OK" ]] && sudo -A xterm -hold -e emerge --ask mesa-progs xdpyinfo lm-sensors dmidecode lshw usbutils</action>
</button>
<text><label>GENTOO System Tools</label></text>
<button>
<input file stock="gtk-quit"></input>
</button>
</hbox>
</frame>
</vbox>
</window>'

case "${1}" in
    -d | --dump) echo "${MAIN_DIALOG}";;
    *) "${GTKDIALOG}" --program=MAIN_DIALOG;;
esac
