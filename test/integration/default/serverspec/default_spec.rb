require 'spec_helper'

describe 'ubuntu-tuneup::default' do

  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  describe package('landscape-client-ui') do
    it {should_not be_installed}
  end

  describe package('landscape-client-ui-install') do
    it {should_not be_installed}
  end

  describe package('landscape-client') do
    it {should_not be_installed}
  end

  describe package('landscape-common') do
  it {should_not be_installed}
  end

  describe package('vim') do
    it {should be_installed}
  end

  describe file('/root/.profile') do
    its(:content) {should match /export EDITOR=vim/}
  end

  describe file('/root/.profile') do
    its(:content) {should match /alias l=\'ls -lh\'/}
  end

  describe file('/root/.profile') do
    its(:content) {should match /alias ll=\'ls -lhtr\'/}
  end

  describe file('/root/.profile') do
    its(:content) {should match /alias rm=\'rm -i\'/}
  end

  describe file('/root/.profile') do
    its(:content) {should match /export HISTTIMEFORMAT="%m\/%d\/%G %H:%M:%S /}
  end

  describe file('/root/.profile') do
    its(:content) {should match /export HISTSIZE=5000/}
  end

  describe file('/root/.profile') do
    its(:content) {should match /export HISTFILESIZE=5000/}
  end

  #I haven't properly escaped the complicated PS1 yet so I'm just checking for the export to exist for now
  describe file('/root/.profile') do
    its(:content) {should match /export PS1=/}
  end
end