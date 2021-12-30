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
zip deploy/policeboard.zip -r * .ebextensions/* .elasticbeanstalk/*  -x 'tmp/*' -x 'log/*' -x 'node_modules/*'
cd deploy
unzip policeboard.zip
mv policeboard.zip ../
