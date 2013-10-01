class postfix (
  $additional_destinations = $postfix::params::additional_destinations,
  $aliases = $postfix::params::aliases,
  $relayhost  = $postfix::params::relayhost',
  $smtpd_recipient_restrictions = $postfix::params::smtpd_recipient_restrictions

) inherits postfix::params {

  exec { 'newaliases':
    command     => 'newaliases',
    refreshonly => true,
  }

  postfix::aliases { '/etc/aliases':
    aliases => $aliases,
  }

  file { '/etc/mailname':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    alias   => 'mailname',
    content => "${::fqdn}\n",
    notify  => Service['postfix'],
    require => Package['postfix'],
  }

  postfix::relayhost { '/etc/postfix/main.cf':
    additional_destinations      => $additional_destinations,
    smtpd_recipient_restrictions => $smtpd_recipient_restrictions
    relayhost                    => $relayhost,
  }

  package { [
    'exim4',
    'exim4-base',
    'exim4-config',
    'exim4-daemon-light' ]:
    ensure => absent,
  }

  package { [
    'postfix',
    'swaks' ]:
    ensure => present,
  }

  service { 'postfix':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
    require    => [
      File['aliases'],
      File['mailname'],
      File['main.cf'],
      Package['postfix']
    ],
  }
}