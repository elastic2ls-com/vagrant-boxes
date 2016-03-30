class ssh{
package { 'openssh-server':
ensure  => installed,
require => Exec['apt-get update'],
}
file { '/etc/ssh/sshd_config':
owner   => 'root',
group   => 'root',
mode    => '0644',
source  => '/etc/puppet/modules/ssh/files/sshd_config',
require => Package['openssh-server'],
notify  => Service['ssh'];
}
service { 'ssh':
ensure  => running,
enable  => true,
require => File['/etc/ssh/sshd_config'];
}
}
