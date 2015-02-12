define windows_clamav::setup (
  $enable_email = 0,
  $email_from = undef,
  $email_to = undef,
  $smtp_pass = undef,
  $smtp_user = undef,
  $smtp_host = undef
){
  include windows_clamav
  $clam_path = 'C:\\Program Files (x86)\\ClamWin\\bin'
  file { "${clam_path}\\ClamWin.conf":
    ensure             => file,
    source_permissions => ignore,
    content             => template('windows_clamav/clamwin.conf.erb'),
    require => Class['windows_clamav']
  }
}
