define windows_clamav (
  $ensure   = 'present',
){
  case $ensure {
    'enabled', 'present': {

    }
    default: {
      fail('Invalid ensure option!\n')
    }
  }
}