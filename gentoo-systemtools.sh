#! /bin/bash
Encoding="UTF-8"

# cd /var/db/pkg/ && ls -d */*
# cd /var/db/pkg/ && ls -d */*|sed 's/\/$//'
# ls -d /var/db/pkg/*/*| cut -f5- -d/
# cat /var/lib/portage/world

export FILE1=/etc/X11/xorg.conf.d/30-keyboard.conf
export FILE2=/etc/fstab
export FILE3=/boot/grub/grub.cfg
export FILE4=/etc/apt/sources.list
export FILE5=/etc/conky/conky.conf
export FILE6=/etc/rc.conf
export FILE7=/etc/sudoers
export FILE8=~/.bashrc
export FILE9=/root/.bashrc
export tf="/tmp/${$}.txt"
export ed="$(which vi||which vim||which nano)"

export MAIN_DIALOG='
<window window_position="1" title="System Tools">

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
              <action>uname -a | zenity --text-info --title "Current running kernel" &</action>
            </menuitem>

            <menuitem>
              <label>KDE Version</label>
              <action>kde-config --version | grep KDE | zenity --text-info --title "KDE Version" &</action>
            </menuitem>

            <menuitem>
              <label>Show Path</label>
              <action>echo "${PATH}" | zenity --text-info  --title "PATH" &</action>
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
                <action>searchKey=($(zenity --entry --text "Enter search term:")) && cd /var/db/pkg/ && /bin/ls -d */* | grep "${searchKey[@]}" > ${tf} && xterm -e ${ed} ${tf}</action>
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
              <action>blkid | zenity --text-info  --width=700 --height=500 --title "Hard Drive UUID" &</action>
            </menuitem>

              <menuitem>
              <label>Current mount points</label>
              <action>mount | zenity --text-info  --width=700 --height=500 --title "Current mount points" & </action>
            </menuitem>

            <menuitem>
              <label>Available disk space</label>
              <action>df -h | zenity --text-info  --width=700 --height=500 --title "Available disk space"  &</action>
            </menuitem>

            <menuitem>
              <label>Connected USB devices</label>
              <action>lsusb | zenity --text-info  --width=700 --height=500 --title $"Connected USB devices" &</action>
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
              <action>xdpyinfo | zenity --text-info  --width=700 --height=500 --title $"Information about the X-server" &</action>
            </menuitem>

            <menuitem>
              <label>GLX/OpenGL Information</label>
              <action>glxinfo | zenity --text-info  --width=700 --height=500 --title $"Information about glx and opengl" & </action>
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
              <action>groups | zenity --text-info  --width=700 --height=100 --title $"View group memberships" &</action>
            </menuitem>

            <menuitem>
              <label>Groups</label>
              <action>cat /etc/group | zenity --text-info  --width=700 --height=500 --title $"View Groups" &</action>
            </menuitem>

          <label>Groups</label>
          </menu>
          </menubar>
        </hbox>

        <button>
          <label>Loaded modules</label>
          <action>lsmod | zenity --text-info  --width=700 --height=500 --title $"View loaded modules" &</action>
        </button>

        <button>
          <label>Services</label>
          <action>chkconfig --list | zenity --text-info  --width=900 --height=600 --title $"View Services" &</action>
        </button>

      </vbox>
    </frame>
    </hbox>

    <hbox>
      <frame System Files>
        <hbox>
          <button><label>'${FILE1}'</label><action>zenity --title='"$FILE1"' --text-info --width 500 --height 400 --filename='"$FILE1"' &</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A gvim '"$FILE1"' &</action></button>
        </hbox>

        <hbox>
          <button><label>'${FILE2}'</label><action>zenity --title='"$FILE2"' --text-info --width 500 --height 400 --filename='"$FILE2"' &</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A gvim '"$FILE2"' &</action></button>
        </hbox>

        <hbox>
          <button><label>'${FILE3}'</label><action>zenity --title='"$FILE3"' --text-info --width 500 --height 400 --filename='"$FILE3"' &</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A gvim '"$FILE3"' &</action></button>
        </hbox>

        <hbox>
          <button><label>'${FILE4}'</label><action>zenity --title='"$FILE4"' --text-info --width 500 --height 400 --filename='"$FILE4"' &</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A gvim '"$FILE4"' &</action></button>
</hbox>
      </frame>

      <frame>
        <hbox>
          <button><label>'${FILE5}'</label><action>zenity --title='"$FILE5"' --text-info --width 500 --height 400 --filename='"$FILE5"' &</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A gvim '"$FILE5"' &</action></button>
        </hbox>

        <hbox>
          <button><label>'${FILE6}'</label><action>zenity --title='"$FILE6"' --text-info --width 500 --height 400 --filename='"$FILE6"' &</action></button>
          <button><input file stock="gtk-dialog-warning"></input><action>sudo -A gvim '"$FILE6"' &</action></button>
        </hbox>

        <hbox>
          <button>
            <label>'${FILE7}'</label>
            <action>sudo -A "zenity --title='"$FILE7"' --text-info --width 500 --height 400 --filename='"$FILE7"'" &</action>
          </button>

          <button>
            <input file stock="gtk-dialog-warning"></input>
            <action>sudo -A xterm -e vim ${FILE7}</action>
          </button>

        </hbox>

        <hbox>
          <button>
            <label>'${FILE8}'</label>
            <action>xterm -e vim ${FILE8} &</action>
          </button>

          <button>
            <input file stock="gtk-dialog-warning"></input>
            <action>sudo -A xterm -e vim ${FILE9}</action>
          </button>

        </hbox>
      </frame>
    </hbox>

    <frame>
    <hbox homogeneous="True">
      <button>
        <input file stock="gtk-info"></input>
        <action>zenity --question --ellipsize --no-wrap --text "To be able to perform all the operations, \nthe following apps must be installed: \ndmidecode lm_sensors lshw mesa-demos xdpyinfo. \nDo you want to install them if they are not already installed?"; if [ "$?" = 0 ]; then sudo -A xterm -hold -e emerge --ask mesa-progs xdpyinfo lm-sensors dmidecode lshw; fi</action>
      </button>
      <text><label>System Tools</label></text>
      <button>
        <input file stock="gtk-quit"></input>
        <action type="exit">exit 0</action>
      </button>
    </hbox>
    </frame>
  </vbox>
  </window>
  '

gtkdialog --program=MAIN_DIALOG
