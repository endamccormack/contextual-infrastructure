class jenkins {

  exec { 'get jenkins':
    command => 'wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -',
    unless  => 'test -e /usr/share/jenkins'
  }

  exec { 'set apt-get jenkins':
    command => "sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'",
    unless  => 'test -e /usr/share/jenkins',
    require => EXEC['get jenkins']
  }

  exec { 'update apt-get with jenkins':
    command => 'sudo apt-get update',
    unless  => 'test -e /usr/share/jenkins',
    require => EXEC['set apt-get jenkins']
  }

  exec { 'install jenkins':
    command => 'sudo apt-get install jenkins -y',
    creates => '/usr/share/jenkins',
    require => EXEC['update apt-get with jenkins'],
    timeout => 1800
  }

  exec { 'grant jenkins ruby folder access':
    command       => 'sudo chown -f -R jenkins:jenkins /usr/local/lib/ruby/gems/2.0.0 /usr/local/bin /opt/playframework-2.2.2',
    user          => 'root',
    require       => [
                        Exec["install jenkins"],
                        CLASS['rails'],
                        CLASS['play']
                     ]
  }

}
