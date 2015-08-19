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
  end

  # Verify Puppet is not installed
  describe package('puppet') do
    it { should_not be_installed }
  end

  # Check for bmon on non-rhel systems
  if os[:family] != 'rhel'
    do
    describe package('bmon') do
      it { should be_installed }
    end
  end

  # This if block checks if the OS is redhat based and sets the redhat based bashrc path and vim package name if it is. (Returns as "rhel" in Chef code)
  if os[:family] == 'redhat'
    bash_path = '/etc/bashrc'
    vim_package = 'vim-enhanced'
    # If not we assume the OS is Debian based
  else
    bash_path = '/etc/bash.bashrc'
    vim_package = 'vim'
  end

  describe package("#{vim_package}") do
    it { should be_installed }
  end

  describe package('curl') do
    it { should be_installed }
  end

  describe package('gnupg2') do
    it { should be_installed }
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
    its(:content) { should match /export HISTTIMEFORMAT="%m\/%d\/%G %H:%M:%S / }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /export HISTSIZE=5000/ }
  end

  describe file("#{bash_path}") do
    its(:content) { should match /export HISTFILESIZE=5000/ }
  end

  # I haven't properly escaped the complicated PS1 yet so I'm just checking for the export to exist for now
  describe file("#{bash_path}") do
    its(:content) { should match /export PS1=/ }
  end

  # Test if .bash_profile has been modified for root
  if os[:family] == 'redhat'
    describe file('/root/.bash_profile') do
      its(:content) { should match /\/etc\/bashrc/ }
    end

    # Now test in vagrant to see if the uid search works
    describe file('/home/vagrant/.bash_profile') do
      its(:content) { should match /\/etc\/bashrc/ }
    end
  end
end