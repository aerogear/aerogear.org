# aerogear.org

## Requirement

Before you can run the site, make sure you have [asciidoc](http://www.methods.co.nz/asciidoc/) installed on your machine!

## Building

1. Install rvm (https://rvm.io/)
1. Run `rvm install ruby 2.2.2`
1. Run `rvm gemset create aerogear`
1. Run `rvm use ruby-2.2.2@aerogear`
1. Run `bundle install --path vendor` to install the dependencies
1. Run `bundle exec jekyll serve --watch`
1. go to <http://127.0.0.1:4000/>
1. profit!

### Development Steps

1. Make changes in aerogear.org repo on a custom branch
1. Create a pr against the `master` branch
1. Get the changes reviewed and verified
1. Merge to the `master` branch
1. Contact a team member on #aerogear on irc to trigger the build to publish the `master` branch to https://staging.aerogear.org
1. Get the changes verified
1. Merge to the `production` branch
1. Contact a team member on #aerogear on irc to trigger the build to publish the `production` branch to to https://aerogear.org
