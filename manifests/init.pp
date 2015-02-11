define windows_clamav (
  $ensure   = 'present',
){
  case $ensure {
    'enabled', 'present': {
      download_file { "Download ClamAV Installer" :
        url                   => 'http://downloads.sourceforge.net/project/clamwin/clamwin/0.98.5/clamwin-0.98.5-setup.exe?r=http%3A%2F%2Fwww.clamwin.com%2Fcontent%2Fview%2F18%2F46%2F&ts=1423624211&use_mirror=jaist',
        destination_directory => 'c:\ProgramData',
        destination_file      => 'clamav.exe',
      }
    }
    exec { 'cmd /c c:\ProgramData\clamav.exe /sp- /silent /norestart  || exit /b 0':
      path => $::path,
      logoutput => false,
      creates  => 'C:\\Program Files (x86)\\ClamWin\\bin\\ClamWin.exe',
    }


    default: {
      fail('Invalid ensure option!\n')
    }
  }
}