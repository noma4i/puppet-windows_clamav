define windows_clamav (
  $ensure   = 'enabled',
  $scan = 'c:\\',
  $enable_email = 0,
  $email_from = undef,
  $email_to = undef,
  $smtp_pass = undef,
  $smtp_user = undef,
  $smtp_host = undef
){
  case $ensure {
    'enabled', 'present': {
      $clam_path = 'C:\\Program Files (x86)\\ClamWin\\bin'
      download_file { "Download ClamAV Installer" :
        url                   => 'http://bit.ly/1yc4QHW',
        destination_directory => 'c:\ProgramData',
        destination_file      => 'clamav.exe',
      }->
      exec { 'Run ClamWin installer':
        command   => 'iex "c:\ProgramData\clamav.exe /sp- /silent /norestart"',
        creates  => "${clam_path}\\ClamWin.exe",
        provider  => powershell,
      }->
      file { "${clam_path}\\ClamWin.conf":
        ensure             => file,
        source_permissions => ignore,
        content             => template('windows_clamav/clamwin.conf.erb')
      }->
      file { "${clam_path}\\freshclam.conf":
        ensure             => file,
        source_permissions => ignore,
        content             => template('windows_clamav/freshclam.conf.erb')
      }->
      scheduled_task { 'ClamAV Scan':
        ensure    => present,
        enabled   => true,
        command   => "${clam_path}\\clamscan.exe",
        arguments => "${scan} -r",
        trigger   => {
          schedule   => daily,
          every      => 2,            # Specifies every other day. Defaults to 1 (every day).
          start_date => '2011-08-31', # Defaults to 'today'
          start_time => '08:00',      # Must be specified
        }
      }
    }
    default: {
      fail('Invalid ensure option!\n')
    }
  }
}