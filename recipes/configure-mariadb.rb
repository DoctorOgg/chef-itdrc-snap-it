apt_repository 'mariadb' do
  uri 'http://downloads.mariadb.com/MariaDB/mariadb-10.1.21/repo/debian/'
  trusted true
  components ['main']
end

package 'mariadb-server' do
  action :install
end

package 'mariadb-client' do
  action :install
end

script 'UPDATE maria db root passwords' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOF
  mysql -h #{node["itdrc"]["snap-it"]["app_config"]["db"]["host"]} -u root  -e "UPDATE mysql.user SET Password=PASSWORD('#{node["itdrc"]["snap-it"]["mysql"]["root_pw"]}') WHERE User='root'; FLUSH PRIVILEGES;"
  /etc/init.d/mysql restart
  touch /root/.irdc-mariadb-pw-set
  EOF
  not_if do ::File.exists?('/root/.irdc-mariadb-pw-set') end
end

script 'create db and user' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOF
  mysql -h #{node["itdrc"]["snap-it"]["app_config"]["db"]["host"]} -u root --password='#{node["itdrc"]["snap-it"]["mysql"]["root_pw"]}' -e "CREATE USER IF NOT EXISTS '#{node["itdrc"]["snap-it"]["app_config"]["db"]["user"]}'@'%' IDENTIFIED BY '#{node["itdrc"]["snap-it"]["app_config"]["db"]["password"]}'; \
  CREATE DATABASE IF NOT EXISTS #{node["itdrc"]["snap-it"]["app_config"]["db"]["name"]}; \
  GRANT ALL ON #{node["itdrc"]["snap-it"]["app_config"]["db"]["name"]}.* TO '#{node["itdrc"]["snap-it"]["app_config"]["db"]["user"]}'@'%'; \
  FLUSH PRIVILEGES; \
  SHOW DATABASES; \
  SELECT USER,lpad(right(PASSWORD,4),length(PASSWORD),'x'),HOST FROM mysql.user;"
  EOF
end
