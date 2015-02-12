define windows_clamav::setup (
  $enabled   = true,
  $schedule = daily,
  $every = 1,
  $start_time = '08:00',
){
  include windows_clamav
  file { "${clam_path}\\ClamWin.conf":
    ensure             => file,
    source_permissions => ignore,
    content             => template('windows_clamav/clamwin.conf.erb')
  }
}
