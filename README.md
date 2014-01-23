# aerogear.org

## Requirement

Before you can run the side, make sure you have:

* [asciidoc](http://www.methods.co.nz/asciidoc/) installed on your machine!
* [sass](http://sass-lang.com/install) installed

## Building

1. Install rvm (https://rvm.io/)
1. Run rvm install ruby 1.9.x
1. rvm gemset create aerogear
1. rvm use ruby-1.9.x@aerogear
1. run `bundle install --path vendor` to install the dependencies
1. run `bundle exec jekyll serve --watch`
1. go to http://127.0.0.1:4000/
1. profit

## Building CSS

CSS source code id in ```sass``` folder, generated CSS is into ```css``` folder.
When writing into sass folder run the folowing command to generate CSS on the fly:

  sass --watch sass:css

## deploy

Pushing to `master` branch, will trigger a CI build, which will deploy to <http://staging.aerogear.org>.

Pushing to `production` branch, deploys the site to <http://aerogear.org>.

