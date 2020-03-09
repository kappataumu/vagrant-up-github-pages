#!/usr/bin/env bash

set -eo pipefail

: ${1?"No repo. Set the REPO environment variable and try again!"}
clonerepo=${1}
clonedir="/srv/www/$(basename $clonerepo)"

start_seconds="$(date +%s)"
echo "Welcome to the initialization script."
echo "Github Pages repository to serve: $clonerepo"

apt_packages=(
    vim
    curl
    git-core
    nodejs
    libgmp3-dev
)

ping_result="$(ping -c 2 8.8.4.4 2>&1)"
if [[ $ping_result != *bytes?from* ]]; then
    echo "Network connection unavailable. Try again later."
    exit 1
fi

# Needed for nodejs.
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -

sudo add-apt-repository -y ppa:git-core/ppa
# sudo apt-add-repository -y ppa:rael-gc/rvm

sudo apt-get -y update
sudo apt-get -y upgrade

echo "Installing apt-get packages..."
sudo apt-get install -y ${apt_packages[@]}
sudo apt-get clean

# http://rvm.io/rvm/install
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /home/vagrant/.rvm/scripts/rvm
ruby --version

# https://github.com/github/pages-gem
gem install github-pages

# Preemptively accept Github's SSH fingerprint, but only
# if we previously haven't done so.
fingerprint="$(ssh-keyscan -H github.com)"
if ! grep -qs "$fingerprint" ~/.ssh/known_hosts; then
    echo "$fingerprint" >> ~/.ssh/known_hosts
fi

# Vagrant should've created /srv/www according to the Vagrantfile,
# but let's make sure it exists even if run directly.
if [[ ! -d '/srv/www' ]]; then
    sudo mkdir '/srv/www'
    sudo chown vagrant:vagrant '/srv/www'
fi

# Time to pull the repo. If the directory is there, we do nothing,
# since git should be used to push/pull commits instead.
if [[ ! -d "$clonedir" ]]; then
    git clone "$clonerepo" "$clonedir"
fi

log="/home/vagrant/jekyll.log"

end_seconds="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in "$(expr $end_seconds - $start_seconds)" seconds"
echo "You can now use 'less -S +F $log' to monitor Jekyll."
