#!/bin/sh

if [ -d deploy ]
then
  echo "Removing old deploy directory"
  rm -rf deploy
fi
if [ -f policeboard.zip ]
then
  rm policeboard.zip
fi
mkdir deploy
rm -rf public/packs public/assets public
rails assets:precompile # need to precompile assets as Beanstalk can't handle it
zip deploy/policeboard.zip -r * .ebextensions/* .elasticbeanstalk/* .platform/* -x 'tmp/*' -x 'log/*' -x 'node_modules/*' -x 'package-lock.json'
cd deploy
unzip policeboard.zip
mv policeboard.zip ../
