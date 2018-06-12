#!/bin/bash

#scp -r _site/ aerogear@filemgmt.jboss.org:/stg_htdocs/aerogear
rsync -r _site/ aerogear@filemgmt.jboss.org:/stg_htdocs/aerogear