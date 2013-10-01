define postfix::aliases($aliases) {
  file { $name:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    alias   => 'aliases',
    content => template('postfix/common/etc/aliases.erb'),
    notify  => Exec['newaliases'],
    require => Package['postfix'],
  }
}