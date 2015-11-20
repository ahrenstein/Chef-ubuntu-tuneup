require 'spec_helper'

describe 'linux-tweak::default' do

  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  # Only test for landscape removal on Ubuntu systems
  if os[:family] == 'ubuntu'
    describe package('landscape-client-ui') do
      it { should_not be_installed }
    end

    describe package('landscape-client-ui-install') do
      it { should_not be_installed }
    end

    describe package('landscape-client') do
      it { should_not be_installed }
    end

    describe package('landscape-common') do
      it { should_not be_installed }
    end
    describe package('apparmor') do
      it { should_not be_installed }
    end

    describe package('ufw') do
      it { should_not be_installed }
    end
  end

  # Verify Puppet is not installed
  describe package('puppet') do
    it { should_not be_installed }
  end

  # Check for bmon on non-rhel systems
  if os[:family] != 'redhat'
    describe package('bmon') do
      it { should be_installed }
    end
  end

  # This if block checks if the OS is redhat based and sets the redhat based bashrc path and vim package name if it is. (Returns as "rhel" in Chef code)
  if os[:family] == 'redhat'
    bash_path = '/etc/bashrc'
    vim_package = 'vim-enhanced'
  elsif os[:family] == 'freebsd'
    bash_path = '/etc/bashrc'
    vim_package = 'vim'
    # If not we assume the OS is Debian based
  else
    bash_path = '/etc/bash.bashrc'
    vim_package = 'vim'
  end

  describe package("#{vim_package}") do
    it { should be_installed }
  end

  describe package('bash') do
    it { should be_installed }
  end

  describe package('curl') do
    it { should be_installed }
  end

  # Only check for gnupg2 if not FreeBSD
  if os[:family] != 'freebsd'
    describe package('gnupg2') do
      it { should be_installed }
    end
  end

  describe package('atop') do
    it { should be_installed }
  end

  describe package('git') do
    it { should be_installed }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /export EDITOR=vim/ }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /alias l=\'ls -lh\'/ }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /alias ll=\'ls -lhtr\'/ }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /alias rm=\'rm -i\'/ }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /alias ssh=\'ssh -A\'/ }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /alias root=\'ssh -A -lroot\'/ }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /export HISTTIMEFORMAT="%m\/%d\/%G %H:%M:%S / }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /export HISTSIZE=5000/ }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /export HISTFILESIZE=5000/ }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /export PS1=/ }
    its(:content) { should match /00;31m/ } # Look for a partial match of the default PS1
  end

  # Test if .bash_profile has been modified for root on rhel
  if os[:family] == 'redhat'
    describe file('/root/.bash_profile') do
      its(:content) { should match /\/etc\/bashrc/ }
    end

    # Now test in vagrant to see if the uid search works
    describe file('/home/vagrant/.bash_profile') do
      its(:content) { should match /\/etc\/bashrc/ }
    end

  elsif os[:family] == 'freebsd' # Test if .bashrc and .bash_profile have been modified for root on freebsd
    describe file('/root/.bashrc') do
      its(:content) { should match /\/etc\/bashrc/ }
    end

    describe file('/root/.bash_profile') do
      its(:content) { should match /\/etc\/bashrc/ }
    end

    # FreeBSD systems are being run as root only boxes so we don't check the vagrant user
  end
end
