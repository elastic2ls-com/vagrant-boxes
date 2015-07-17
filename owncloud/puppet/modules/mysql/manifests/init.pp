class mysql {

	# Install mysql
	package { ['mysql-server']:
    		ensure => present,
    		require => Exec['apt-get update'],
	}
	# Run mysql
	service { 'mysql':
    		ensure  => running,
    		require => Package['mysql-server'],
	}

	# We set the root password here
	exec { 'set-mysql-password':
    		unless  => 'mysqladmin -uroot -proot status',
    		command => 'mysqladmin -uroot password root',
    		require => Service['mysql'],
                path => [ '/usr/bin' ],
	}
	
	exec { 'create owncloud DB':
		command => 'mysql -uroot -proot</etc/puppet/modules/mysql/files/owncloud.sql',
		require => Service['mysql'],
                path => ['/usr/local/bin', '/bin/', '/usr/sbin', '/usr/bin' ],
	}
}
