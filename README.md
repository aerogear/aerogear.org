# aerogear.org

## Requirement

Before you can run the site, make sure you have [asciidoc](http://www.methods.co.nz/asciidoc/) installed on your machine!

## Running locally

Ruby & its ecosystem is difficult to install and manage, so we recommend running Jekyll & aerogear.org in via Docker.

### Building

Build and tag a local docker image via:

```
[sudo] docker build --tag aerogear.org .
```

*Note*: This will clone a fresh copy of the `aerogear.org` repo into the container.

### Running

To run Jekyll via Docker, and mount your local repo to serve content from, run:

```
docker run --rm -it -p 4000:4000 -v `pwd`:/home/aerogear/aerogear aerogear.org
```

This will setup a watch locally, and serve content locally via http://localhost:4000


### Deploying Changes

1. Make changes in aerogear.org repo on a custom branch
1. Create a PR against the `master` branch
1. Get the changes reviewed and verified
1. Merge to the `master` branch
1. Contact a team member on #aerogear on irc to trigger the build to publish the `master` branch to https://staging.aerogear.org
1. Get the changes verified
1. Merge to the `production` branch
1. Contact a team member on #aerogear on irc to trigger the build to publish the `production` branch to to https://aerogear.org
