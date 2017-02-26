# ITDRC snap-it Cookbook

## Simple standalone server install

1. Provision a dedicated debian 8/8.5 64bit machine, this can be virtual or bare metal.

2. If this machine will be on the public internet, ensure it has a proper DNS name.

3. Run the install script.
```bash
wget -qO-  https://raw.githubusercontent.com/DoctorOgg/chef-itdrc-snap-it/master/chef-solo-install/install.sh  | sudo bash
```

4. Configure your chef settings stored in ```/root/itdrc-sanp-it-installer```

 NOTE: if your machine is accessible from the internet, you should configure the following.

 ```
 "letsencrypt": {
   "contact": "mailto:youre@email-address.com",
   "self-signed": false
 },
 ```
 This will enable us to ask for a signed SSL certificate from https://letsencrypt.org. If your machine is not on the public internet **you should set ```"self-signed": true```***, this will generate a self-signed SSL certificate instead.

 Additionally, it is **critical** to configure the app_url
 ```
 "app_url": "https://example.com",```
 ***if you do not have an DNS name use the servers IP address.***

5. Run Chef solo (as root)
```
(cd /root/itdrc-sanp-it-installer && ./run-chef.sh )
```
 NOTE: for a full list of settings you can set in solo.json, you can look at the [default attributes](attributes/default.rb) for this cookbook.



## Dev requirements
Here is a list of tools used to develop this cookbook.

* [Chef DK](https://downloads.chef.io/chefdk)
* [Vagrant](ttps://www.vagrantup.com)
* Vagrant plugins
```
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-berkshelf
vagrant plugin install vagrant-vbguest
vagrant plugin install chef
```
