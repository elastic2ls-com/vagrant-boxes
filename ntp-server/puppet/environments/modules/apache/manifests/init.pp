class apache {                 

        # Install apache
	$apachedebs = [ "apache2", "php5", "libapache2-mod-php5", "php5-gd", "php5-json", "php5-mysql", "php5-curl", "php5-intl", "php5-mcrypt", "php5-imagick" ]
        package { $apachedebs:
                ensure => installed,
                require => Exec['apt-get update'],
        }
	

        # Run apache
        service { 'apache2':
                ensure  => running,
                require => Package['apache2'],
        }
	
	file {'/etc/apache2/sites-enabled/default-ssl.conf':
		ensure => file,
		source => '/etc/puppet/modules/apache/files/default-ssl.conf',
                notify => Service['apache2'],
	}

	exec { 'enable-ssl':
		command => '/usr/sbin/a2enmod ssl',
                notify => Service['apache2'],
                path => ['/usr/local/bin', '/bin/', '/usr/sbin', '/usr/bin' ],
	}



}
