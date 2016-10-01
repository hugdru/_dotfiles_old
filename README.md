## Structure ##
#### dotfiles ####
User configuration files and some cool scripts are stored here. Respectively, some $HOME/.\*/\*\* , and $HOME/data/bin .

#### packages ####
Installed software be it from distro package manager or others.

#### system ####
System configuration files are kept here.

#### setup ####
A zsh script with functions to help save, create links and install the configuration.

## Setup ##
#### ./setup links ####
Creates symbolic links in $HOME with the same structure as what is inside the dotfiles dir. For example, $HOME/.config/awesome/rc.lua -> $HOME/configuration/dotfiles/.config/awesome/rc.lua.
I choose this structure cause this way I avoid adding/ignoring lots of files and slowing down my $HOME because of zsh git plugins and prompt.
This way it is almost impossible to add private files since I must move them explicitly to $HOME/configuration/dotfiles/.
#### ./setup save ####
Saves all the system files to the system folder and info about installed software to the respective files in packages.
#### ./setup install ####
Not tested since I don't use it, I normally restore my home from the borg backup.
But should create an user if needed, get private stuff from a backup, clone the repo, set up the links,
install the apps, load nvim pluggins and compile what is needed, install fonts, etc. I'll test it eventually.

## I use ##
#### distro ####
https://www.archlinux.org/

#### backups ####
https://borgbackup.readthedocs.io/en/stable/

#### dns server ####
https://www.unbound.net/
* https://raw.githubusercontent.com/hugdru/dotfiles/master/system/etc/dhclient.conf
* https://raw.githubusercontent.com/hugdru/dotfiles/master/system/etc/NetworkManager/NetworkManager.conf

#### wm manager ####
https://awesome.naquadah.org/ - My configuration is pretty simple I don't like to have too many things in the way.
  * Cheeky for easy application jump, shortcut: modkey /
  * Revelation for exposé, shortcut: modkey i
  * Added support for loading programs on boot from $HOME/.autostart with custom rules.
  * Move the tags creation up and created a table with mapping inverted, tag["name"]->index for easy reference in the programs table. 
  * Created a table of programs with custom rules and shortcuts for easy configuration.
  * Run or raise to jump to program with shortcut if it is already running.
  * I changed some other shortcuts but I no longer remember which ones exactly.
   * Modkey tab, switches between current and last window.
   * Alt tab, cycles the windows forward on a tag
   * Alt Shift tab, same but the other way
   * Modkey \, switches between current and last tag

#### keys ####
https://www.keepassx.org/ - to hold credentials for websites, etc.<br>
https://www.gnupg.org/ - to hold all keys including git keys
* https://spin.atomicobject.com/2013/09/25/gpg-gnu-privacy-guard/
* https://riseup.net/ru/security/message-security/openpgp/best-practices
* http://www.incenp.org/notes/2015/gnupg-for-ssh-authentication.html

## Partitioning ##
I am using mbr-bios because of the samsung_laptop bugs in efi. The two first partitions are for windows and the other one for linux.
For EFI add the ESP partition and change the partitioning scheme.
* https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS
* http://www.pavelkogan.com/2014/05/23/luks-full-disk-encryption/
![partitioning](https://github.com/hugdru/dotfiles/blob/master/partitioning.png)
