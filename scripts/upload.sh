#!/bin/bash 

set -ex

git clone --depth=1 --branch=master https://github.com/pharo-iot/Ci.git
cp download/server.zip Ci/docs/
cp download/multi.zip Ci/docs/
cp download/client.zip Ci/docs/
cd Ci
git checkout master
git add docs/*.zip
git commit -m "Travis upload release files"
git push http://${GH}@github.com/pharo-iot/Ci.git 