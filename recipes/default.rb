%w( git-core php5-common php5-curl php5-ldap php5-mysql php5-cli ssl-cert
  php5-gd php5-mcrypt libapache2-mod-php5 apache2 apache2-utils vim-nox ).each do |pkg|
  package pkg
end

group node["itdrc"]["snap-it"]["group"] do
  action :create
  gid node["itdrc"]["snap-it"]["gid"]
end

user node["itdrc"]["snap-it"]["user"] do
  comment node["itdrc"]["snap-it"]["gecos"]
  uid node["itdrc"]["snap-it"]["uid"]
  gid node["itdrc"]["snap-it"]["gid"]
  home node["itdrc"]["snap-it"]["home"]
  shell '/bin/sh'
end

include_recipe "#{cookbook_name}::install"
include_recipe "#{cookbook_name}::configure"
include_recipe "#{cookbook_name}::configure-webserver"
