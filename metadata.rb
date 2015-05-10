name             'linux-tweak'
maintainer       'Matthew Ahrenstein'
maintainer_email '@ahrenstein'
license          'See LICENSE.txt'
description      'Performs various tweaks on fresh Linux installs'
long_description 'Removes Landscape garbage from Ubuntu systems, tweaks system-wide bashrc settings'
version          '0.2.1'
depends          'line', '0.6.1'

%w{ ubuntu debian centos }.each do |os|
  supports os
end

recipe 'linux-tweak::default', 'Call this recipe to run the various tweaks from the cookbook'
recipe 'linux-tweak::bashrc', 'Configure system-wide bashrc preferences so bash looks nice. Also adds some useful aliases'
recipe 'linux-tweak::packages', 'Adds some useful packages that aren\'t installed by default and removes landscape from Ubuntu systems'
