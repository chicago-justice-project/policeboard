#!/bin/sh

mkdir -p ./deploy
rm deploy/policeboard.zip
zip deploy/policeboard.zip -r * .ebextensions/* .elasticbeanstalk/* -x 'deploy/*' -x 'tmp/*'