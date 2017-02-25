# Cookbook Settings
default["itdrc"]["snap-it"]["git-repo"]                                 = "https://github.com/snipe/snipe-it"
default["itdrc"]["snap-it"]["version"]                                  = "v3.6.4"
default["itdrc"]["snap-it"]["home"]                                     = "/srv/snipe-it"
default["itdrc"]["snap-it"]["install_dir"]                              = node["itdrc"]["snap-it"]["home"]+"/webapp"
default["itdrc"]["snap-it"]["user"]                                     = "snipe-it"
default["itdrc"]["snap-it"]["uid"]                                      = 50000
default["itdrc"]["snap-it"]["group"]                                    = "snipe-it"
default["itdrc"]["snap-it"]["gid"]                                      = 50000
default["itdrc"]["snap-it"]["gecos"]                                    = "ITDRC Snap-IT"

# Lets Encrypt Settings
default["itdrc"]["snap-it"]["letsencrypt"]["contact"]                   = "mailto:your@email-address.com"
default["itdrc"]["snap-it"]["letsencrypt"]["self-signed"] = true

# Maria DB settings
default["itdrc"]["snap-it"]["mysql"]["root_pw"]                         = "SETME"

# General App settings
default["itdrc"]["snap-it"]["app_config"]["app_key"]                    = "SETME"
default["itdrc"]["snap-it"]["app_config"]["set_app_key"]                = true
default["itdrc"]["snap-it"]["app_config"]["app_url"]                    = "http://localhost"
default["itdrc"]["snap-it"]["app_config"]["timezone"]                   = "UTC"
default["itdrc"]["snap-it"]["app_config"]["locale"]                     = "en"
default["itdrc"]["snap-it"]["app_config"]["filesytem_disk"]             = "local"
default["itdrc"]["snap-it"]["app_config"]["trusted_proxies"]            = ["192.168.1.1","10.0.0.1"]
default["itdrc"]["snap-it"]["app_config"]["allow_iframe"]               = false
default["itdrc"]["snap-it"]["app_config"]["app_locked"]                 = false
default["itdrc"]["snap-it"]["app_config"]["app_log"]                    = "single"
default["itdrc"]["snap-it"]["app_config"]["max_login_attempts"]         = 5
default["itdrc"]["snap-it"]["app_config"]["lockout_durration"]          = 60
default["itdrc"]["snap-it"]["app_config"]["cache_driver"]               = "file"
default["itdrc"]["snap-it"]["app_config"]["queue_driver"]               = "sync"
default["itdrc"]["snap-it"]["app_config"]["app_env"]                    = "production"
default["itdrc"]["snap-it"]["app_config"]["app_debug"]                  = false

# Session Settings
default["itdrc"]["snap-it"]["app_config"]["session"]["driver"]          = "file"
default["itdrc"]["snap-it"]["app_config"]["session"]["lifetime"]        = 12000
default["itdrc"]["snap-it"]["app_config"]["session"]["expire_on_close"] = false
default["itdrc"]["snap-it"]["app_config"]["session"]["encrypt"]         = false
default["itdrc"]["snap-it"]["app_config"]["session"]["cookie_name"]     = "itdrc_snapit"
default["itdrc"]["snap-it"]["app_config"]["session"]["cookie_domain"]   = "null"
default["itdrc"]["snap-it"]["app_config"]["session"]["secure_cookies"]  = false

# Database Settings
default["itdrc"]["snap-it"]["app_config"]["db"]["driver"]               = "mysql"
default["itdrc"]["snap-it"]["app_config"]["db"]["host"]                 = "127.0.0.1"
default["itdrc"]["snap-it"]["app_config"]["db"]["name"]                 = "snapit"
default["itdrc"]["snap-it"]["app_config"]["db"]["user"]                 = "snapit"
default["itdrc"]["snap-it"]["app_config"]["db"]["password"]             = "SETME"
default["itdrc"]["snap-it"]["app_config"]["db"]["prefix"]               = "null"
default["itdrc"]["snap-it"]["app_config"]["db"]["ssl"]["enable"]        = false
default["itdrc"]["snap-it"]["app_config"]["db"]["ssl"]["key_path"]      = "null"
default["itdrc"]["snap-it"]["app_config"]["db"]["ssl"]["cert_path"]     = "null"
default["itdrc"]["snap-it"]["app_config"]["db"]["ssl"]["ca_path"]       = "null"
default["itdrc"]["snap-it"]["app_config"]["db"]["ssl"]["cypher"]        = "null"

# Mail Settings
default["itdrc"]["snap-it"]["app_config"]["mail"]["driver"]             = "smtp"
default["itdrc"]["snap-it"]["app_config"]["mail"]["host"]               = "email-smtp.us-west-2.amazonaws.com"
default["itdrc"]["snap-it"]["app_config"]["mail"]["port"]               = 587
default["itdrc"]["snap-it"]["app_config"]["mail"]["username"]           = "SETME"
default["itdrc"]["snap-it"]["app_config"]["mail"]["password"]           = "SETME"
default["itdrc"]["snap-it"]["app_config"]["mail"]["from_address"]       = "SETME"
default["itdrc"]["snap-it"]["app_config"]["mail"]["from_name"]          = "ITDRC SNAP-IT"

# AWS S3 Settings
default["itdrc"]["snap-it"]["app_config"]["s3"]["secret"]               = "null"
default["itdrc"]["snap-it"]["app_config"]["s3"]["key"]                  = "null"
default["itdrc"]["snap-it"]["app_config"]["s3"]["region"]               = "null"
default["itdrc"]["snap-it"]["app_config"]["s3"]["bucket"]               = "null"
