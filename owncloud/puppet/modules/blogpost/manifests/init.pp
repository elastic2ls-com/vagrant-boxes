class blogpost {

  class { '::mysql::server':
    root_password    => 'root',
    override_options => { 'mysqld' => { 'max_connections' => '1024' } }
  }

  mysql::db { 'owncloud':
    user     => 'owncloud',
    password => 'owncloud',
    host     => 'localhost',
    sql        => '/etc/puppet/modules/owncloud/files/owncloud.sql',
#    require => File[ '/etc/puppet/modules/owncloud/files/owncloud.sql' ],
    grant    => ['ALL'],
  }

  include apache
  include apache::mod::prefork
  include apache::mod::php  
  include apache::mod::ssl  
  include apache::mod::rewrite  

	$apachedebs = [ "php-gd", "php-JsonSchema", "php-mysql", "php-pear-Net-Curl", "php-intl", "php-mcrypt", "php-pecl-imagick", "php-mbstring" ]
        package { $apachedebs:
                ensure => present,
		notify => Service['httpd'],
        }


  apache::vhost { 'owncloud-http':    
    servername      => '172.28.128.6',    
    port            => '80',    
    docroot         => '/var/www/owncloud',    
    redirect_status => 'permanent',    
    redirect_dest   => 'https://owncloud/',  
  }  

  apache::vhost { 'owncloud-https':    
    servername      => '172.28.128.6',    
    port            => '443',    
    docroot         => '/var/www/owncloud',    
    ssl             => true,    
    ssl_cert        => '/etc/pki/tls/certs/localhost.crt',  
    ssl_key         => '/etc/pki/tls/private/localhost.key',
    #rewrite_cond    => '%{HTTP_USER_AGENT} Windows',    
    #rewrite_rule    => '^.*$ http://bing.com/ [R=301,L]'  
  }

  exec { 'download owncloud':
    command => 'cd /tmp && wget https://download.owncloud.org/community/owncloud-8.1.0.tar.bz2',
    path => ['/usr/local/bin', '/bin/', '/usr/sbin', '/usr/bin' ],
  }

  exec { 'extract owncloud':
    command => 'tar -xf /tmp/owncloud-8.1.0.tar.bz2 -C /var/www', 
    path => ['/usr/local/bin', '/bin/', '/usr/sbin', '/usr/bin' ],
    require => Exec['download owncloud'],
  }

  exec { 'chown owncloud':
    command => 'chown -R apache:apache /var/www',
    path => ['/usr/local/bin', '/bin/', '/usr/sbin', '/usr/bin' ],
    require => Exec['extract owncloud'],
  }

#  file {'/var/www/owncloud/config/config.php':
#    ensure => file,
#    source => '/etc/puppet/modules/owncloud/files/config.php',
#  }

}
