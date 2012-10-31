# aerogear.org

## building

1. Have ruby 1.9.x installed
1. run `bundle install --path vendor` to install the dependencies
1. run `bundle exec jekyll --server --auto`
1. go to http://127.0.0.1:4000/
1. profit

## deploy

Pushing to `master` branch, will trigger a CI build, which will deploy to <http://staging.aerogear.org>.

Pushing to `production` branch, deploys the site to <http://aerogear.org>.