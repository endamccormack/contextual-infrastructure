class mysql5 {

  exec { 'mysql config for password input':
    command       => 'echo "mysql-server-5.5 mysql-server/root_password password 1Password2" | debconf-set-selections',
    unless        => 'test -e /usr/bin/mysql',
    user          => 'root'
  }

  exec { 'mysql config for password confirm input':
    command       => 'echo "mysql-server-5.5 mysql-server/root_password_again password 1Password2" | debconf-set-selections',
    unless        => 'test -e /usr/bin/mysql',
    user          => 'root'
  }

  exec { 'install mysql':
    command       => 'sudo apt-get -f install mysql-server-5.5 -y',
    creates       => '/usr/bin/mysql',
    require       => [EXEC['mysql config for password input'],
                      EXEC['mysql config for password confirm input']]
  }
  
}
