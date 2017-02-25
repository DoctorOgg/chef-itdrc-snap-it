directory node["itdrc"]["snap-it"]["install_dir"] do
  owner node["itdrc"]["snap-it"]["user"]
  group 'www-data'
  mode 00750
  recursive true
  action :create
end

git node["itdrc"]["snap-it"]["install_dir"] do
  repository node["itdrc"]["snap-it"]["git-repo"]
  reference node["itdrc"]["snap-it"]["version"]
  action :sync
end

script 'update ownership:group' do
  interpreter 'bash'
  user 'root'
  cwd node["itdrc"]["snap-it"]["install_dir"].split('/')[0..-2].join('/')
  code <<-EOF
  chown -R #{node["itdrc"]["snap-it"]["user"]}:www-data #{node["itdrc"]["snap-it"]["install_dir"].split('/')[-1]}
  chmod -R g+rwX #{node["itdrc"]["snap-it"]["install_dir"].split('/')[-1]}
  EOF
end

include_recipe 'composer::default'

composer_project node["itdrc"]["snap-it"]["install_dir"] do
    dev false
    action :install
end
