class windows_clamav {
  $clam_path = 'C:\\Program Files (x86)\\ClamWin\\bin'
  download_file { "Download ClamAV Installer ${scan} ${every}" :
    url                   => 'http://bit.ly/1yc4QHW',
    destination_directory => 'c:\ProgramData',
    destination_file      => 'clamav.exe',
  }->
  exec { "Run ClamWin installer ${scan} ${every}":
    command   => 'iex "c:\ProgramData\clamav.exe /sp- /silent /norestart"',
    creates  => "${clam_path}\\ClamWin.exe",
    provider  => powershell,
  }->
  file { "${clam_path}\\freshclam.conf":
    ensure             => file,
    source_permissions => ignore,
    content             => template('windows_clamav/freshclam.conf.erb')
  }
}
