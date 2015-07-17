class cloud {

        exec { 'install owncloud':
                command => 'cd ~','wget https://download.owncloud.org/community/owncloud-8.1.0.tar.bz2 &&tar xfv owncloud-8.1.0.tar.bz2 && mv owncloud/ /var/www/html && chown -R www-data:www-data /var/ww$
                path => ['/usr/local/bin', '/bin/', '/usr/sbin', '/usr/bin' ],
        }


        file {'/var/www/html/owncloud/config/config.php':
                ensure => file,
                source => '/etc/puppet/modules/cloud/files/config.php',
                notify => Service['apache2'],
        }

}
