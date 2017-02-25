script 'clear php cache' do
  interpreter 'bash'
  user 'root'
  cwd node["itdrc"]["snap-it"]["install_dir"]
  code <<-EOF
  php artisan config:clear
  EOF
end

template "#{node["itdrc"]["snap-it"]["install_dir"]}/.env" do
  source 'env.erb'
  owner node["itdrc"]["snap-it"]["user"]
  group 'www-data'
  mode 00740
end

script 'Set Application Key`' do
  interpreter 'bash'
  user 'root'
  cwd node["itdrc"]["snap-it"]["install_dir"]
  code <<-EOF
  php artisan key:generate
  EOF
  only_if { node["itdrc"]["snap-it"]["app_config"]["set_app_key"] }
end
