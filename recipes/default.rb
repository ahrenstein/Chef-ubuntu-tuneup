#
# Cookbook Name:: ubuntu-tuneup
# Recipe:: default
#
# Copyright (c) 2015 Ahrenstein, All Rights Reserved.

#Default is just going to call the other recipes in this cookbook where the acutal meat of the code is
#We check for the correct OS in the included recipes

#Purge landscape and install vim if needed
include_recipe 'ubuntu-tuneup::packages'

#Modify root's .profile
include_recipe 'ubuntu-tuneup::rootprofile'
