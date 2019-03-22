---
layout: news
section: news
title: AeroGear Mobile Services version 2.0.0 is here
author: aerogear
tag: community
---

About 7 months ago, we announced [the 1.0.0 release](/news/2018/07/04/aerogear-mobile-services-announcement/index.html) of the AeroGear Mobile Services. Since then we have been working very hard to continue the development work. Today we are delighted to announce the availability of AeroGear Mobile Services version 2.0.0.

## What's New

* A new [Data Sync](/services/data-sync/) framework is now available. It is built on top of the popular [Apollo GraphQL framework](https://www.apollographql.com/). We added a set of new features like offline support, conflict handling etc to make it easier for developers to create mobile applications that need to sync data between clients and server. To learn more, please check the [Voyager server](https://github.com/aerogear/voyager-server) and the [Voyager client](https://github.com/aerogear/aerogear-js-sdk/tree/master/packages/sync) repos.
* A new [Cordova showcase app](https://github.com/aerogear/ionic-showcase) was created to demonstrate the new data sync capabilities and how to use it with other services.
* The APIs of the [AeroGear JS SDK](https://github.com/aerogear/aerogear-js-sdk) core module have been refactored to make it easier for developers to consume.
* A new [installer repo](https://github.com/aerogear/mobile-services-installer) is created to make it easier for developers to install AeroGear Mobile Services. You can also find out which versions of each service are included in a given release. For example, the 2.0.0 release contains [these services](https://github.com/aerogear/mobile-services-installer/blob/2.0.0/versions.yml).
* Bug fixes and improvements for the existing services.


## Try It Out

If you would like to try out the new features, please follow our [getting-started guide](https://docs.aerogear.org/aerogear/latest/getting-started.html) with the new [Cordova showcase app](https://github.com/aerogear/ionic-showcase). If you would like to know more about Data Sync, please check the [documentations](https://docs.aerogear.org/aerogear/latest/data-sync.html).

Please remember, feedback is always welcome and we can't wait to hear what you think!

Thanks.

\- *The AeroGear Team*


