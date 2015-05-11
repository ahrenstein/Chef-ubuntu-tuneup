#
# Cookbook Name:: linux-tweak
# Recipe:: bashrc
#
# Copyright (c) 2015 Ahrenstein, All Rights Reserved.

# This recipe will customize system-wide bashrc with some very nice aliases and a few other good settings

# This if block checks if the OS is rhel based and sets the rhel based bashrc path if it is. (Returns as "redhat" in Serverspec code)
case node['platform_family']
  when 'rhel'
    bash_path = '/etc/bashrc'
  # If not we assume the OS is Debian based
  else
    bash_path = '/etc/bash.bashrc'
end

# Add the l alias
replace_or_add 'l alias' do
  path "#{bash_path}"
  pattern '^alias l=.*$'
  line 'alias l=\'ls -lh\''
end

# Add the ll alias
replace_or_add 'll alias' do
  path "#{bash_path}"
  pattern '^alias ll=.*$'
  line 'alias ll=\'ls -lhtr\''
end

# Make rm safer
replace_or_add 'rm alias' do
  path "#{bash_path}"
  pattern '^alias rm=.*$'
  line 'alias rm=\'rm -i\''
end

# Configure my favorite bash prompt
replace_or_add 'bash prompt' do
  path "#{bash_path}"
  pattern '^export PS1.*$'
  line 'export PS1="\[\e[00;31m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;34m\]\H\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[00;32m\]\w\[\e[0m\]\[\e[00;37m\] \t \\$ \[\e[0m\]"'
end

# Add a timestamp to history with the format MM/DD/YYYY HH:MM:SS
replace_or_add 'history timestamp' do
  path "#{bash_path}"
  pattern '^export HISTTIMEFORMAT=.*$'
  line 'export HISTTIMEFORMAT="%m/%d/%G %H:%M:%S "'
end

# Set the history command to display 5000 lines
replace_or_add 'history display limit' do
  path "#{bash_path}"
  pattern '^export HISTSIZE=.*$'
  line 'export HISTSIZE=5000'
end

# Set the history file to save 5000 lines
replace_or_add 'history file limit' do
  path "#{bash_path}"
  pattern '^export HISTFILESIZE=.*$'
  line 'export HISTFILESIZE=5000'
end

# Set vim as the default editor
replace_or_add 'history file limit' do
  path "#{bash_path}"
  pattern '^export EDITOR=.*$'
  line 'export EDITOR=vim'
end

# Loop through the max amount of local users we expect to have on the system and remove their personal .bashrc files
node['etc']['passwd'].each do |user, data|
  if (data['uid'].to_i >= 500) and (data['uid'].to_i <=900)

    # Remove each user's .bashrc
    file "#{user} bashrc" do
      path "#{data['dir']}/.bashrc"
      action :delete
    end

    # CentOS machines need /etc/bashrc sourced via a custom .bash_profile
    case node['platform_family']
      when 'rhel'
        template "#{user} bash_profile" do
          source 'bash_profile.erb'
          path "#{data['dir']}/.bash_profile"
          owner "#{user}"
          mode '644'
        end
      else
        # Do nothing
    end
  end
end

# Remove the local .bashrc for root
file '/root/.bashrc' do
  path '/root/.bashrc'
  action :delete
end

# Also do the same bash_profile template for root
case node['platform_family']
  when 'rhel'
    template 'root bash_profile' do
      source 'bash_profile.erb'
      path '/root/.bash_profile'
      owner 'root'
      group 'root'
      mode '644'
    end
  else
    # Do nothing
end