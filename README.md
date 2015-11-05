# aerogear.org

## requirement

Before you can run the side, make sure you have [asciidoc](http://www.methods.co.nz/asciidoc/) installed on your machine!

## building

1. Install rvm (https://rvm.io/)
1. Run rvm install ruby 2.1.2
1. rvm gemset create aerogear
1. rvm use ruby-2.1.2@aerogear
1. run `bundle install --path vendor` to install the dependencies
1. run `bundle exec jekyll serve --watch`
1. go to <http://127.0.0.1:4000/>
1. profit

## deploy

Pushing to `master` branch, will trigger a Jenkins CI build, which will deploy to <http://staging.aerogear.org>.

Pushing to `production` branch, deploys the site to <http://aerogear.org>.
