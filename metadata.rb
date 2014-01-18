name             'graphite'
maintainer       'Heavy Water Software Inc.'
maintainer_email 'ops@hw-ops.com'
license          'Apache 2.0'
description      'Installs/Configures graphite'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.7'

supports 'ubuntu'
supports 'debian'
supports 'redhat'
supports 'centos'
supports 'amazon'
supports 'scientific'
supports 'oracle'
supports 'fedora'

depends  'python'
depends  'apache2'
depends  'runit', '~> 1.0'
depends  'memcached'

suggests 'systemd'
suggests 'graphiti'
