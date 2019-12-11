#!/bin/bash

export GTKDIALOG="$(command -v gtkdialog)"

export FILE1=/etc/X11/xorg.conf.d
export FILE2=/etc/fstab
export FILE3=/etc/default/grub
export FILE4=/etc/portage/repos.conf
export FILE5=/etc/portage/make.conf
export FILE6=/etc/rc.conf
export FILE7=/etc/sudoers
export FILE8=~/.bashrc
export FILE9=/root/.bashrc

export tf="/tmp/${$}.txt"
export ed="$(which vi||which vim||which nano)"

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
    <default>search for ...</default>
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
          <action>dmesg > ${tf} && xterm -e ${ed} ${tf}</action>
        </button>

        <entry><variable export="true">VAR2</variable></entry>

        <hbox>
          <button>
            <label>search</label>
            <input file stock="gtk-find"></input>
            <action>dmesg | grep ${VAR2} > ${tf} && xterm -e ${ed} ${tf} </action>
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
        <action>${VAR1} --help > ${tf} && xterm -e ${ed} ${tf}</action>
      </button>

      <button>
        <label>Whereis</label>
        <action>whereis ${VAR1} > ${tf} && xterm -e ${ed} ${tf}</action>
      </button>

      <button>
        <label>Which</label>
        <action>which ${VAR1} > ${tf} && xterm -e ${ed} ${tf}</action>
      </button>

      <button>
        <label>Version</label>
        <action>${VAR1} --version > ${tf} && xterm -e ${ed} ${tf}</action>
      </button>

      <button>
        <label>Manual</label>
        <action>man ${VAR1} > ${tf} && xterm -e ${ed} ${tf}</action>
      </button>
    </hbox>
    </frame>
    <hbox homogeneous="True">

    <frame>
      <vbox>
        <button homogeneous="true">
        <input file stock="gtk-index"></input>
        <label>Sensors</label>
        <action>sensors > ${tf} && xterm -e ${ed} ${tf}</action>
        </button>

        <button homogeneous="true">
        <input file stock="gtk-connect"></input>
        <label>Ethernet Interfaces</label>
        <action>ifconfig > ${tf} && xterm -e ${ed} ${tf}</action>
        </button>

        <button homogeneous="true">
        <input file stock="gtk-disconnect"></input>
        <label>Wireless Interfaces</label>
        <action>iwconfig > ${tf} && xterm -e ${ed} ${tf}</action>
        </button>

        <button homogeneous="true">
        <input file stock="gtk-save"></input>
        <label>emerge logs</label>
        <action>sudo -A xterm -e ${ed} /var/log/emerge.log</action>
        </button>

        <button homogeneous="true">
        <input file stock="gtk-floppy"></input>
        <label>Hardware information </label>
        <action>sudo -A lshw > ${tf} && xterm -e ${ed} ${tf}</action>
        </button>

        <button homogeneous="true">
        <input file stock="gtk-print-preview"></input>
        <label>BIOS information</label>
        <action>sudo -A dmidecode | head -15 > ${tf} && xterm -e ${ed} ${tf}</action>
        </button>

        <button homogeneous="true">
        <input file stock="gtk-page-setup"></input>
        <label>PCI devices</label>
        <action>lspci > ${tf} && xterm -e ${ed} ${tf}</action>
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
              <action>uname -a > ${tf} && xterm -e ${ed} ${tf}</action>
            </menuitem>

            <menuitem>
              <label>Show Path</label>
              <action>echo "${PATH}" > ${tf} && xterm -e ${ed} ${tf}</action>
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
                <label>View Installed Applications</label>
                <action>sudo -A cat /var/lib/portage/world &> ${tf} && xterm -e ${ed} ${tf}</action>
              </menuitem>
              <menuitem>
                <label>Open list of Installed Ebuilds</label>
                <action>cd /var/db/pkg/ && /bin/ls -d1 */* > ${tf} && xterm -e ${ed} ${tf}</action>
              </menuitem>
              <menuitem>
                <label>Search in list of installed Applications</label>
                <action>gtkout=$(${GTKDIALOG} --program=QUESTION_SEARCH 2> /dev/null) && export `echo ${gtkout}` && cd /var/db/pkg/ && /bin/ls -d1 */* | grep ${SEARCH} > ${tf} && xterm -e ${ed} ${tf}</action>
              </menuitem>
              <label>Installed Applications</label>
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
              <action>sudo -A fdisk -l &> /tmp/${$}.txt && xterm -e vim /tmp/${$}.txt</action>
            </menuitem>

            <menuitem>
              <label>Hard drive UUID</label>
              <action>blkid > ${tf} && xterm -e ${ed} ${tf}</action>
            </menuitem>

              <menuitem>
              <label>Current mount points</label>
              <action>mount > ${tf} && xterm -e ${ed} ${tf}</action>
            </menuitem>

            <menuitem>
              <label>Available disk space</label>
              <action>df -h > ${tf} && xterm -e ${ed} ${tf}</action>
            </menuitem>

            <menuitem>
              <label>Connected USB devices</label>
              <action>lsusb > ${tf} && xterm -e ${ed} ${tf}</action>
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
              <action>xdpyinfo > ${tf} && xterm -e ${ed} ${tf}</action>
            </menuitem>

            <menuitem>
              <label>GLX/OpenGL Information</label>
              <action>glxinfo > ${tf} && xterm -e ${ed} ${tf}</action>
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
              <action>groups > ${tf} && xterm -e ${ed} ${tf}</action>
            </menuitem>

            <menuitem>
              <label>Groups</label>
              <action>xterm -e ${ed} /etc/group</action>
            </menuitem>

          <label>Groups</label>
          </menu>
          </menubar>
        </hbox>

        <button>
          <label>Loaded modules</label>
          <action>lsmod > ${tf} && xterm -e ${ed} ${tf}</action>
        </button>

        <button>
          <label>Services</label>
          <action>rc-update > ${tf} && xterm -e ${ed} ${tf}</action>
        </button>

      </vbox>
    </frame>
    </hbox>

    <hbox>
      <frame System Files>
        <hbox>
          <button><label>'${FILE1}'</label><action>xterm -e ${ed} ${FILE1}</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${ed} ${FILE1}</action></button>
        </hbox>

        <hbox>
          <button><label>'${FILE2}'</label><action>xterm -e ${ed} ${FILE2}</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${ed} ${FILE2}</action></button>
        </hbox>

        <hbox>
          <button><label>'${FILE3}'</label><action>xterm -e ${ed} ${FILE3}</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${ed} ${FILE3}</action></button>
        </hbox>

        <hbox>
          <button><label>'${FILE4}'</label><action>xterm -e ${ed} ${FILE4}</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${ed} ${FILE4}</action></button>
        </hbox>
      </frame>

      <frame>
        <hbox>
          <button><label>'${FILE5}'</label><action>xterm -e ${ed} ${FILE5}</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${ed} ${FILE5}</action></button>
        </hbox>

        <hbox>
          <button><label>'${FILE6}'</label><action>xterm -e ${ed} ${FILE6}</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A xterm -e ${ed} ${FILE6}</action></button>
        </hbox>

        <hbox>
          <button>
            <label>'${FILE7}'</label>
            <action>sudo -A xterm -e ${ed} ${FILE7}</action>
          </button>

          <button>
            <input file stock="gtk-dialog-warning"></input>
            <action>sudo -A xterm -e ${ed} ${FILE7}</action>
          </button>

        </hbox>

        <hbox>
          <button>
            <label>'${FILE8}'</label>
            <action>xterm -e ${ed} ${FILE8}</action>
          </button>

          <button>
            <input file stock="gtk-dialog-warning"></input>
            <action>sudo -A xterm -e ${ed} ${FILE9}</action>
          </button>

        </hbox>
      </frame>
    </hbox>

    <frame>
    <hbox homogeneous="True">
      <button>
        <input file stock="gtk-info"></input>
        <action>gtkout=$(${GTKDIALOG} --program=QUESTION_INSTALL 2> /dev/null) && export `echo ${gtkout}` && [[ "${EXIT}" =~ "OK" ]] && sudo -A xterm -hold -e emerge --ask mesa-progs xdpyinfo lm-sensors dmidecode lshw usbutils</action>
      </button>
      <text><label>GENTOO System Tools</label></text>
      <button>
        <input file stock="gtk-quit"></input>
      </button>
    </hbox>
    </frame>
  </vbox>
  </window>
'

case "${1}" in
    -d | --dump) echo "${MAIN_DIALOG}";;
    *) "${GTKDIALOG}" --program=MAIN_DIALOG;;
esac
