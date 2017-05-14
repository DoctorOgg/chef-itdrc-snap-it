include_recipe 'firewall'

firewall 'default' do
  action :install
end

firewall_rule 'ssh' do
  port     22
  command  :allow
end

firewall_rule 'http' do
  port     80
  protocol :tcp
  position 1
  command   :allow
end

firewall_rule 'https' do
  port     443
  protocol :tcp
  position 1
  command   :allow
end


node.override['fail2ban']['services'] = {
  'ssh' => {
        "enabled" => "true",
        "port" => "ssh",
        "filter" => "sshd",
        "logpath" => node['fail2ban']['auth_log'],
        "maxretry" => "6"
     }
}

include_recipe 'fail2ban'
