name             'mo_collectd'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures mo_collectd'
long_description 'Installs/Configures mo_collectd'
version          '1.0.18'

depends 'collectd-lib',     '~> 3.0.1'

depends 'chef-sugar',       '~> 2.5.0'
depends 'mysql2_chef_gem',  '~> 1.0.1'
depends 'database',         '~> 4.0.3'
