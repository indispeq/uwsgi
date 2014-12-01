#!/bin/bash

puppet module install stankevich-python --target-dir /vagrant/puppet/modules
puppet module install puppetlabs-apt --target-dir /vagrant/puppet/modules
puppet module install puppetlabs-ntp --target-dir /vagrant/puppet/modules
puppet module install puppetlabs-postgresql --target-dir /vagrant/puppet/modules

