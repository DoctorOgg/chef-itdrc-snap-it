include_recipe 'acme'
node.override['acme']['contact'] = node["itdrc"]["snap-it"]["letsencrypt"]["contact"]
node.override['acme']['endpoint'] = 'https://acme-v01.api.letsencrypt.org'
site=URI.parse(node["itdrc"]["snap-it"]["app_config"]["app_url"]).host

service 'apache2' do
  supports :status => true
  action [ :enable, :start ]
end

group 'ssl-cert' do
  members ['www-data']
  action :create
end

script 'remove default apache site' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOF
   a2dissite 000-default
  EOF
  notifies :restart, 'service[apache2]'
  only_if { File.exists?("/etc/apache2/sites-available/000-default.conf") }
end

# Generate a self-signed if we don't have a cert to prevent bootstrap problems
acme_selfsigned site do
    crt     "/etc/ssl/certs/#{site}.pem"
    key     "/etc/ssl/private/#{site}.key"
    chain    "/etc/ssl/certs/#{site}-chain.pem"
    owner   "root"
    group   "ssl-cert"
    notifies :restart, 'service[apache2]'
    not_if { File.exists?("/etc/ssl/certs/#{site}.pem") }
end

template '/etc/apache2/sites-available/itdrc-snapit.conf' do
  source 'apache-itdrc-snapit.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
  notifies :restart, 'service[apache2]'
end

script 'enable apache2 modrewrite' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOF
  a2enmod rewrite
  EOF
  notifies :restart, 'service[apache2]'
end

script 'enable apache2 mod ssl' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOF
  a2enmod ssl
  EOF
  notifies :restart, 'service[apache2]'
end

script 'enable itdrc-snapit.conf' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOF
  a2ensite itdrc-snapit.conf
  EOF
  notifies :restart, 'service[apache2]'
end

# Get and auto-renew the certificate from Let's Encrypt
acme_certificate site do
  crt     "/etc/ssl/certs/#{site}.pem"
  key     "/etc/ssl/private/#{site}.key"
  chain    "/etc/ssl/certs/#{site}-chain.pem"
  owner   "root"
  group   "ssl-cert"
  wwwroot  "#{node["itdrc"]["snap-it"]["install_dir"]}/public"
  notifies :restart, 'service[apache2]'
  not_if { node["itdrc"]["snap-it"]["letsencrypt"]["self-signed"] }
end
