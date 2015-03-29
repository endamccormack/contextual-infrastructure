class rails {

  exec { 'install bundler':
    command => '/usr/local/bin/gem install bundler',
    creates => '/usr/local/bin/bundler',
    user    => 'root',
    require =>  CLASS["ruby"]
  }

  exec { 'install rails':
    command => '/usr/local/bin/gem install rails',
    creates => '/usr/local/bin/rails',
    user    => 'root',
    require => Exec["install bundler"],
    timeout => 1200
  }

}
