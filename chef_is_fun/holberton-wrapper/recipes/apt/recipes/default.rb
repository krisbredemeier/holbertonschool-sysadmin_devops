#
# Cookbook Name:: apt
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

apt_repository "dotdeb" do
  uri "http://packages.dotdeb.org"
  distribution "jessie"
  components ["all"]
  key "http://www.dotdeb.org/dotdeb.gpg"
end