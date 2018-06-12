#!/bin/bash

#scp -r _site/ aerogear@filemgmt.jboss.org:/www_htdocs/aerogear
rsync -r _site/ aerogear@filemgmt.jboss.org:/www_htdocs/aerogear