# windows_clamav

Puppet module to install and manage ClamAV.

#### How to use

````puppet
    windows_clamav::setup { 'Perform Setup. It is Optional':
      enable_email => 1,
      email_to => 'alex@mail.com',
      smtp_pass => '123123',
      smtp_user => 'user',
      smtp_host => 'passw0rd'
    }

    windows_clamav::update { 'Update ClamAV DB':
      enabled => true,
      every => '1',
      start_time => '11:00'
    }

    windows_clamav::scan { 'Scan temp for viruses':
      enabled => true,
      scan => 'c:\temp',
      every => '2',
      start_time => '11:00'
    }
    windows_clamav::scan { 'Scan windows for viruses':
      enabled => true,
      scan => 'c:\windows',
      every => '2',
      start_time => '11:00'
    }
````