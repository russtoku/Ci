#!/bin/bash 

set -ex

git clone --depth=1 --branch=master https://github.com/oliveiraallex/pharothings-ci.git
cp download/server.zip pharothings-ci/docs/
cp download/multi.zip pharothings-ci/docs/
cp download/client.zip pharothings-ci/docs/
cd pharothings-ci
git checkout master
git add docs/*.zip
git commit -m "Travis upload"
git push http://oliveiraallex:${GH}@github.com/oliveiraallex/pharothings-ci.git > /dev/null 2>&1