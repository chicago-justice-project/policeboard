#!/bin/sh

zip policeboard.zip -r * .ebextensions/* .elasticbeanstalk/*  -x 'tmp/*' -x 'log/*'