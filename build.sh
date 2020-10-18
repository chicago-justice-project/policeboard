#!/bin/sh

mkdir deploy
zip deploy/policeboard.zip -r * .ebextensions/* .elasticbeanstalk/*  -x 'tmp/*' -x 'log/*'
cd deploy
unzip policeboard.zip
rm policeboard.zip