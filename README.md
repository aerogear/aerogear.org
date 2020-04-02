# aerogear.org

## Cloning the repo
Before you can run the site, you need to clone the repo:

```bash 
git clone https://github.com/aerogear/aerogear.org.git
cd aerogear.org
```

## Running locally with `docker`

A `docker-compose.yml` is provided so running the website using it is very simple:

```bash
docker-compose up
```

When docker will finish, point your browser to http://localhost:3000.

## Running locally with `node`

To run the website with node, you will need to enter the website folder:

```bash
cd website
npm install
npm run start
```

Finally point your browser to http://localhost:3000.

## Publishing Changes
1. Make changes in aerogear.org repo on a custom branch starting from the **source** branch
1. Create a PR against the **master** branch
1. Get the changes reviewed and verified
1. Merge to the **master** branch
1. Contact a team member on #unified-push on [Discord](https://discord.gg/mJ7j84m) to trigger the build and publish 
to https://aerogear.org