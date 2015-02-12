define windows_clamav::scan (
  $enabled   = true,
  $scan = 'c:\\',
  $enable_email = 0,
  $every = 1,
  $start_time = '08:00',
  $email_from = undef,
  $email_to = undef,
  $smtp_pass = undef,
  $smtp_user = undef,
  $smtp_host = undef
){
  include windows_clamav
  $clam_path = 'C:\\Program Files (x86)\\ClamWin\\bin'

  scheduled_task { "ClamAV ${title}":
    ensure    => present,
    enabled   => $enabled,
    command   => "${clam_path}\\clamscan.exe",
    arguments => "${scan} -r",
    trigger   => {
      schedule   => daily,
      every      => $every,
      start_date => '2010-01-01',
      start_time => $start_time,
    }
  }
}
