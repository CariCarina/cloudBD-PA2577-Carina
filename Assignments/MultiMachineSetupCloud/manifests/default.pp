node /^appserver/{
  package { curl:
   ensure => "installed",
   require => Exec['init'],
  }

  exec { 'init':
    path => ['/usr/bin', '/usr/sbin', '/bin'],
    command => 'apt-get update',
  }

  exec {'before node':
    path => ['/usr/bin', '/usr/sbin', '/bin'],
    command => "curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -",
    require => Package['curl']
  }

  package { 'nodejs':
     ensure => 'installed',
     require => [ 
	Exec['init'],
	Exec['before node']
   ],
 }
}

node /^dbserver/{
  include mysql
}