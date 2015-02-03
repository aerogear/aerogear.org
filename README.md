# aerogear.org

## requirement

Before you can run the side, make sure you have [asciidoc](http://www.methods.co.nz/asciidoc/) installed on your machine!

## building

1. Install rvm (https://rvm.io/)
1. Run `rvm install ruby 1.9.x` (such as `1.9.3`)
1. `rvm gemset create aerogear`
1. `rvm use ruby-1.9.x@aerogear`
1. run `bundle install --path vendor` to install the dependencies
1. run `bundle exec jekyll serve --watch --baseurl ''`
1. go to <http://127.0.0.1:4000/>
1. profit

## deploy

Pushing to `master` branch, will trigger a CI build, which will deploy to <http://staging.aerogear.org>.

Pushing to `production` branch, deploys the site to <http://aerogear.org>.

## deploy to staging

Staging mechanism allows you to push any of your branches to the <https://staging-aerogearsite.rhcloud.com/>
and allows anyone review your changes in the site before you push them to master.

In order to push to the staging server, you must have a SECRET_KEY provided by one of team members.

1. with Ruby installed (see building)
1. `gem install travis`
1. `travis encrypt ACCESS_KEY_<GITHUB_NAME>='<SECRET_KEY>' --add`
    - `GITHUB_NAME` is your personal github nick as appears in https://github.com/<GITHUB_NAME>/
    - `SECRET_KEY` must be provided by team members
1. enable Travis CI hook
    1. go to <https://travis-ci.org/profile>
    1. sign in using your github account
    1. find your fork of `aerogear.org` repository in the listing, such as `<GITHUB_NAME>/aerogear.org`
    1. turn the switch ON for this repository
    1. go to `Repository settings` (a gear icon)
    1. **!!!make sure `Build pull requests` is `OFF`!!!**
    1. make sure `Build only if .travis.yml is present` and `Build pushes` are `ON`
