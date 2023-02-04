#!/bin/bash

git clone https://github.com/bats-core/bats-core.git /home/vagrant/bats/bats-core
git clone https://github.com/bats-core/bats-assert.git /home/vagrant/bats/bats-assert
git clone https://github.com/bats-core/bats-support.git /home/vagrant/bats/bats-support

sudo /home/vagrant/bats/bats-core/install.sh /usr/local