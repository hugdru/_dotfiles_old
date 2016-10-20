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
This way it is almost impossible to add private files since I must move them explicitly to $HOME/configuration/, the git repository.
#### ./setup save ####
Saves all the system files to the system folder and info about installed software to the respective files in packages.
#### ./setup install ####
Not tested since I don't use it, I normally restore my home from the borg backup.
But should create an user if needed, get private stuff from a backup, clone the repo, set up the links,
install the apps, load nvim pluggins and compile what is needed, install fonts, etc. I'll test it eventually.
#### ./setup fonts ####
Installs some beautiful fonts

## I use ##
#### keymap ####
I use two layouts, Option "XkbLayout" "pt,gb". I only use pt for chatting, everything else I do with gb. Meaning, all shortcuts are configured with gb in mind. Coding and using vim with an english layout is much better :)

#### distro ####
https://www.archlinux.org/

#### backups ####
https://borgbackup.readthedocs.io/en/stable/

#### dns server ####
https://www.unbound.net/
* https://raw.githubusercontent.com/hugdru/dotfiles/master/system/etc/dhclient.conf
* https://raw.githubusercontent.com/hugdru/dotfiles/master/system/etc/NetworkManager/NetworkManager.conf

#### colors, themes and icons, filemanager ####
I use solarized everywhere, consistency :). Numix and Faenza-Darkest. PCManFM.

#### terminal and shell ####
urxvt, zsh with zplug.

#### editor ####
https://github.com/neovim/neovim <br>
I use neovim, dotfiles/.vimrc is outdated and I no longer use "normal" vim. vim and vimdiff are aliased to nvim and nvim -d.
* https://github.com/hugdru/dotfiles/blob/master/dotfiles/.config/nvim/init.vim

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
   * Modkey f, to set window to maximize.
   * Modkey shift f, to set window to full screen.

#### keys ####
https://www.keepassx.org/ - to hold credentials for websites, etc.<br>
https://www.gnupg.org/ - to hold all keys including git keys
* https://spin.atomicobject.com/2013/09/25/gpg-gnu-privacy-guard/
* https://riseup.net/ru/security/message-security/openpgp/best-practices
* http://www.incenp.org/notes/2015/gnupg-for-ssh-authentication.html

## Partitioning and User dirs ##
I am using mbr-bios because of the samsung_laptop bugs in efi. The two first partitions are for windows and the other one for linux.
For EFI add the ESP partition and change the partitioning scheme.
* https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS
* http://www.pavelkogan.com/2014/05/23/luks-full-disk-encryption/
![partitioning](https://github.com/hugdru/dotfiles/blob/master/partitioning.png) <br>
I changed the default user-dirs environment variables because I keep all important files like projects, pictures, and so on on a separate partition. Namely the data partition. I do this so I can mount it easily on windows, other distros, etc without carrying distro specific configurations, temp files, etc. <br>
Check https://github.com/hugdru/dotfiles/blob/master/dotfiles/.config/user-dirs.dirs

