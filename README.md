Chef Cookbook - Linux Tweak
==============

This Chef recipe will perform a few tweaks on linux systems, and a few Ubuntu specific tweaks on Ubuntu systems.


Tweaks Performed
------------
1. Added EPEL repos (rhel-based systems only)
2. Remove the following packages;
  1. puppet (Since we are using Chef)
  2. landscape-client-ui (Ubuntu only)
  3. landscape-client-ui-install (Ubuntu only)
  4. landscape-client (Ubuntu only)
  5. landscape-common (Ubuntu only)
3. Install some packages I commonly use
  1. vim
  2. curl (For some reason not always present on base systems)
  3. gnupg2 (I use gpg2 a lot)
  4. atop
  5. bmon (Not on rhel-based systems)
  6. git
4. Add some custom bash settings for all users
  1. Add aliases for ls -lh and ls -lhtr
  2. Add an alias to change rm into rm -i
  3. Change the history so it maintains 5000 entries and have date/time stamps
  4. Export a nice bash PS1
  5. Export vim as the default editor
  6. Delete the .bashrc for root and uids 500-900

Requirements
------------
1. Chef (Tested on Chef 12)
2. Linux chef-clients (Tested on Ubuntu 12.04, Ubuntu 14.04, Debian 7.6, CentOS 5.10 and CentOS 6.5 but kitchen will let you test anything you want)
3. The line cookbook from Chef Supermarket
4. The apt cookbook from Chef Supermarket
5. The yum-epel cookbook from Chef Supermarket

Installation Tips
------------

1. I personally use Berks to install this into my Chef server, because it's easier.

Limitations
------------
1. This recipe has been tested with Ubuntu 12.04, Ubuntu 14.04, Debian 7.6, CentOS 5.10 and CentOS 6.5 but you can test it with any other Linux distro using kitchen. The full spec test is there.
 1. Well sort of. I didn't spend the effort to escape the bash PS1 for spec testing so it only tests that the bashrc has a PS1 exported.

Bug Fixes & Changes
------------

1. v0.2.7
  1. Added dependency on yum-epel from Supermarket for installing git, atop, and bmon from EPEL repo on rhel-based systems
  1. Removed line cookbook version requirement
  2. Remove Puppet if installed since we use Chef (Assists with migrations from Puppet to Chef)
  3. Make sure atop is installed
  4. Make sure bmon is installed on non-rhel systems
  5. Make sure git is installed
2. v0.2.6
  1. Changed the range of UIDs bashrc is customized for to be 500-2000
3. v0.2.5
  1. CentOS users were not sourcing the /etc/bashrc automatically. This was fixed
4. v0.2.4
  1. Alias for l used a pattern match for ll so every time it ran, it would replace ll, and ll would be recreated by its resource. This led to repeating l aliases. This has been fixed.

Use cases
------------
If you like the shell preferences I set (PS1, aliases, etc...) then you can use this module.
