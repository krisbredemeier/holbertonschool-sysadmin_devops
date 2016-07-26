#
# Cookbook Name:: apt
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'nginx' do
  action :install
end

service 'nginx' do
  action [ :enable, :start ]
end

# the debian part of this config
# configure backports.debian.org
include_recipe "debian::backports"

# set apt-pinning rules
%w[thepackage and some dependencies].each do |pkg|
  apt_preference pkg do
    pin "release o=Debian Backports"
    pin_priority "700"
  end
end

# install the package
package "thepackage"


apt_repository "dotdeb" do
	uri "http://packages.dotdeb.org"
	distribution "jessie"
	components ["all"]
	key "http://www.dotdeb.org/dotdeb.gpg"
end