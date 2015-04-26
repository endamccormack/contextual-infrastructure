class ruby{
  
  exec{'get ruby-2.0.0-p451.zip':
    command => "/usr/bin/wget -q http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p451.zip -O /tmp/ruby-2.0.0-p451.zip",
    creates => "/tmp/ruby-2.0.0-p451.zip"
  }

  exec { 'unpack ruby':
    command => 'unzip -o /tmp/ruby-2.0.0-p451.zip -d /opt',
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
    timeout =>  1200
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
