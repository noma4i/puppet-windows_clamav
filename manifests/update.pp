define windows_clamav::update (
  $enabled   = true,
  $schedule = daily,
  $every = 1,
  $start_time = '08:00',
){
  include windows_clamav
  $clam_path = 'C:\\Program Files (x86)\\ClamWin\\bin'

  scheduled_task { "Update ClamAV Database":
    ensure    => present,
    enabled   => $enabled,
    command   => "${clam_path}\\freshclam.exe",
    arguments => "",
    trigger   => {
      schedule   => $schedule,
      every      => $every,
      start_date => '2010-01-01',
      start_time => $start_time,
    }
  }
}
