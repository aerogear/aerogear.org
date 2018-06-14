#!/bin/bash

#scp -r _site/ aerogear@filemgmt.jboss.org:/stg_htdocs/aerogear
rsync -vr _site/ aerogear@filemgmt.jboss.org:/stg_htdocs/aerogear