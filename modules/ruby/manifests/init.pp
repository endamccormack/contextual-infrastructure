class ruby{

  file { "/vagrant/modules/ruby/dependencies":
      ensure => "directory",
  }

  file { "/vagrant/modules/ruby/dependencies/packages":
      ensure => "directory",
      require => File["/vagrant/modules/ruby/dependencies"]
  }

  exec{'get ruby-2.0.0-p451.zip':
    command => "/usr/bin/wget -q http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p451.zip -O /vagrant/modules/ruby/dependencies/packages/ruby-2.0.0-p451.zip",
    creates => "/vagrant/modules/ruby/dependencies/packages/ruby-2.0.0-p451.zip",
    require => File['/vagrant/modules/ruby/dependencies/packages']
  }

  exec { 'unpack ruby':
    command => 'unzip -o /vagrant/modules/ruby/dependencies/packages/ruby-2.0.0-p451.zip -d /opt',
    path => '/bin:/usr/bin',
    unless  => 'test -e /usr/local/bin/ruby',
    user    => 'root',
    require => Exec['get ruby-2.0.0-p451.zip']
  }

  exec { 'configure ruby':
    command => '/opt/ruby-2.0.0-p451/configure',
    cwd     => '/opt/ruby-2.0.0-p451',
    path    => '/bin:/usr/bin',
    unless  => 'test -e /usr/local/bin/ruby',
    user    => 'root',
    require =>  Exec["unpack ruby"]
  }

  exec { 'make ruby':
    command => 'make',
    cwd     => '/opt/ruby-2.0.0-p451',
    unless  => 'test -e /usr/local/bin/ruby',
    user    => 'root',
    require =>  Exec["configure ruby"],
    timeout => 600
  }

  exec { 'make install ruby':
    command => 'make install',
    cwd     => '/opt/ruby-2.0.0-p451',
    creates => '/usr/local/bin/ruby',
    user    => 'root',
    require =>  Exec["make ruby"]
  }

  exec { 'update gem':
    command => '/usr/local/bin/gem update --system',
    onlyif  => '/usr/local/bin/gem',
    user    => 'root',
    require =>  Exec["make install ruby"],
  }

}
