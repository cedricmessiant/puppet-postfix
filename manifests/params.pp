class postfix::params {
  case $::lsbdistcodename {
    'squeeze' {
      $additional_destinations  = hiera('additional_destinations', '')
      $aliases = hiera_hash('aliases')
      $relayhost  = hiera('relayhost', '')
      $smtpd_recipient_restrictions = hiera('smtpd_recipient_restrictions', 'permit_mynetworks, reject_unauth_destination')
    }
    'wheezy': {
      $additional_destinations  = hiera('additional_destinations', '')
      $aliases = hiera_hash('aliases')
      $relayhost  = hiera('relayhost', '')
      $smtpd_recipient_restrictions = hiera('smtpd_recipient_restrictions', 'permit_mynetworks, reject_unauth_destination')
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}
