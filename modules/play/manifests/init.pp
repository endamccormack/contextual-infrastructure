class play {

  exec{'get play-2.2.2.zip':
    command => "/usr/bin/wget -q https://github.com/playframework/playframework/archive/2.2.2.zip -O /tmp/play-2.2.2.zip",
    creates => "/tmp/play-2.2.2.zip"
  }

  exec{'get sbt-0.13.7.zip':
    command => "/usr/bin/wget -q https://github.com/sbt/sbt/archive/v0.13.7.zip -O /tmp/sbt-0.13.7.zip",
    creates => "/vagrant/modules/play/dependencies/packages/sbt-0.13.7.zip"
  }

  exec{'get scala-2.11.4.deb':
    command => "/usr/bin/wget -q http://downloads.typesafe.com/scala/2.11.4/scala-2.11.4.deb -O /tmp/scala-2.11.4.deb",
    creates => "/vagrant/modules/play/dependencies/packages/scala-2.11.4.deb",
    timeout => 1800
  }

  exec { 'install scala':
    command => 'dpkg -i /tmp/scala-2.11.4.deb',
    creates => '/usr/bin/scala',
    user    => 'root',
    require => Exec['get scala-2.11.4.deb']
  }

  exec { 'install sbt':
    command => '/usr/bin/unzip -o /tmp/sbt-0.13.7.zip -d /opt',
    creates => '/usr/bin/sbt',
    user    => 'root',
    require => [Exec["install scala"], Exec['get sbt-0.13.7.zip']]
  }

  exec { 'install play':
    command => 'unzip -o /tmp/play-2.2.2.zip -d /opt',
    creates => '/usr/bin/play',
    user    => 'root',
    require => [Exec["install sbt"], Exec["get play-2.2.2.zip"]]
  }

}
