#!/usr/bin/env sh
# installs the CLI and default node instance
set -e

# DOWNLOAD
gnodi="$HOME/gnodi/library/node/gnodi"
download_url="https://static.gnodi.org/node/linux/releases/1.9.20/gnodi"
curl $download_url -o $gnodi --create-dirs
chmod +x $gnodi

# ADD ALIAS
alias='alias gnodi="~/gnodi/library/node/gnodi"'
if ! grep -Fxq "$alias" ~/.bashrc; then
    echo $alias >> ~/.bashrc
fi
# source ~/.bashrc

$gnodi version

# INITIALIZE
set +e
$gnodi node init -e devnet
exit_code=$?
set -e
if [ "$exit_code" != 0 ] && [ $exit_code != 99 ]; then
  exit 1
fi

# ACTIVATE
$gnodi node activate

# INSTALL SERVICE
$gnodi node service install
$gnodi node service start
