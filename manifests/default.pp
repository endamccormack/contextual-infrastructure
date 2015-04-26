Exec { path => "/usr/local/rvm/gems/ruby-2.2.0/bin:/home/vagrant/bin:/usr/local/bin:/usr/local/rvm/gems/ruby-2.2.0@global/bin:/usr/local/rvm/rubies/ruby-2.2.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/rvm/bin" }

node default {

  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }

  Exec["apt-update"] -> Package <| |>

  #Install system packages
  $system_packages = [
    git,
    vim,
    openjdk-7-jdk,
    curl,
    unzip,
    language-pack-en,
    wget,
    openssl,
    libssl-dev,
    'g++'
  ]

  package { $system_packages:
    ensure => present,
    before => CLASS['play']
  }

  class { 'ohmyzsh': }

  # for a single user
  ohmyzsh::install {
    'vagrant':
  }
  ohmyzsh::plugins {
    'vagrant': plugins => 'git github'
  }
  ohmyzsh::theme {
    'vagrant': theme => 'robbyrussell'
  }

}

include mysql5
include play
include ruby
include rails
include jenkins
