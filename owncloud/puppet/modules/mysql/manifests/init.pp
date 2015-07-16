class mysql {

	exec { 'apt-get update':
  		path => '/usr/bin',
	}

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
    		command => "mysqladmin -uroot password root",
    		path    => ['/bin', '/usr/bin'],
    	require => Service['mysql'];
	}

}