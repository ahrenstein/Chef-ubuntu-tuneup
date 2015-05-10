Chef Cookbook - Linux Tweak
==============

This Chef recipe will perform a few tweaks on linux systems, and a few Ubuntu specific tweaks on Ubuntu systems.


Tweaks Performed
------------
1. Remove landscape packages (Ubuntu only)
2. Install some packages I commonly use
  1. vim
  2. curl (For some reason not always present on base systems)
  3. gnupg2 (I use gpg2 a lot)
3. Add some custom bash settings for all users
  1. Add aliases for ls -lh and ls -lhtr
  2. Add an alias to change rm into rm -i
  3. Change the history so it maintains 5000 entries and have date/time stamps
  4. Export a nice bash PS1
  5. Export vim as the default editor

Requirements
------------
1. Chef (Tested on Chef 12)
2. Linux chef-clients (Tested on Ubuntu 12.04, Ubuntu 14.04, Debian 7.6, CentOS 5.10 and CentOS 6.5 but kitchen will let you test anything you want)
3. The line cookbook from Chef Supermarket (tested and locked to 0.6.1)
4. The apt cookbook from Chef Supermarket

Installation Tips
------------

1. I personally use Berks to install this into my Chef server, because it's easier.

Limitations
------------
1. This recipe has been tested with Ubuntu 12.04, Ubuntu 14.04, Debian 7.6, CentOS 5.10 and CentOS 6.5 but you can test it with any other Linux distro using kitchen. The full spec test is there.
 1. Well sort of. I didn't spend the effort to escape the bash PS1 for spec testing so it only tests that the bashrc has a PS1 exported.

Use cases
------------
If you like the shell preferences I set (PS1, aliases, etc...) then you can use this module.
