#!/bin/bash 

set -ex

mkdir tmp
cd tmp

# Pharo image 32bit:
# wget -qb "https://files.pharo.org/get-files/70/pharo.zip"

# Pharo image 64bit:
# wget -qb "https://files.pharo.org/get-files/70/pharo64.zip"

# PharoVM 7.0 for Linux 32bit: 
wget -q "https://files.pharo.org/get-files/70/pharo-linux-stable.zip"

# PharoVM 7.0 for Linux 64bit: 
wget -q "https://files.pharo.org/get-files/70/pharo64-linux-stable.zip"

# PharoVM 7.0 for Windows 32bit: 
wget -q "https://files.pharo.org/get-files/70/pharo-win-stable.zip"

# PharoVM 7.0 for Mac OSX 32bit: 
wget -q "https://files.pharo.org/get-files/70/pharo-mac-stable.zip"

# PharoArmVM to Raspberry:
wget -q "http://files.pharo.org/vm/pharo-spur32/linux/armv6/latest.zip"
