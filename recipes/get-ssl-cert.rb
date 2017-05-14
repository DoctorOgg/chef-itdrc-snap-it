include_recipe 'acme'
node.override['acme']['contact'] = node["itdrc"]["snap-it"]["letsencrypt"]["contact"]
node.override['acme']['endpoint'] = 'https://acme-v01.api.letsencrypt.org'
site=URI.parse(node["itdrc"]["snap-it"]["app_config"]["app_url"]).host

service 'apache2' do
  supports :status => true
  action [ :enable, :start ]
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
