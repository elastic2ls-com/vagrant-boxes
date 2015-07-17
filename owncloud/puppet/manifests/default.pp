node "owncloud.t-mobile.de" {
	include "apache"
	include "mysql"
	include "cloud"
}

#exec  { 'path':
#                path => ['/usr/local/bin', '/bin/', '/usr/sbin', '/usr/bin' ],
#}

exec { 'apt-get update':
                path => '/usr/bin',
}

