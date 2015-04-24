---
layout: news
section: news
title: AeroGear iOS SDK v2.3 is out!
author: corinnekrych
module: sync
platform: ios
tags: swift
---

The iOS team is happy to announce the version 2.3 of the AeroGear iOS libraries. This version revisit all Swift libs to update them to Swift 1.2.

## What's inside

### 1. Ready for iOS 8.3

With Watch released today, it's time to get ready for iOS 8.3! 

Our 2.3 release brings iOS 8.3 support and compile against Xcode 6.3 with Swift 1.2. This is the list of released pods as part of iOS 2.3:

- [aerogear-ios-sync](https://github.com/aerogear/aerogear-ios-sync) with pod [1.0.0-alpha.2](http://cocoadocs.org/docsets/AeroGearSync/1.0.0-alpha.2/). 
- [aerogear-ios-sync-client](https://github.com/aerogear/aerogear-ios-sync-client) with pod [1.0.0-alpha.2](http://cocoadocs.org/docsets/AeroGearSyncClient/1.0.0-alpha.2/).
- [aerogear-ios-push](https://github.com/aerogear/aerogear-ios-push) with pod [1.1.0-swift](http://cocoadocs.org/docsets/AeroGear-Push-Swift/1.1.0).
- [aerogear-ios-http 0.3.0](https://github.com/aerogear/aerogear-ios-http) with pod [0.3.0](http://cocoadocs.org/docsets/AeroGearHttp/0.3.0).
- [aerogear-ios-oauth2](https://github.com/aerogear/aerogear-ios-oauth2) with pod [0.3.0](http://cocoadocs.org/docsets/AeroGearOAuth2/0.3.0).    
- [aerogear-ios-jsonsz](https://github.com/aerogear/aerogear-ios-jsonsz) with pod [0.2.0](http://cocoadocs.org/docsets/AeroGearJsonsz/0.2.0).

### 2. Embedded WebVew option for OAuth2

With [AGIOS-414](https://issues.jboss.org/browse/AGIOS-414), [aerogear-ios-oauth2](https://github.com/aerogear/aerogear-ios-oauth2) adds the option to use an embedded WebView rather than triggering an external browser when doing the OAuth2 danse.

### 3. House cleaning tasks

All 1.6.x demo repos have been moved to [cookbook 1.6.x branch](https://github.com/aerogear/aerogear-ios-cookbook/tree/1.6.x): 
- [aerogear-aerodoc-ios](https://github.com/aerogear/aerogear-aerodoc-ios) is deprecated, new location is [aerogear-ios-cookbook/AeroDoc](https://github.com/aerogear/aerogear-ios-cookbook/tree/1.6.x/AeroDoc).
- [aerogear-otp-ios-demo](https://github.com/aerogear/aerogear-otp-ios-demo) is deprecated, new location is [aerogear-ios-cookbook/Two-Factor](https://github.com/aerogear/aerogear-ios-cookbook/tree/1.6.x/Two-Factor).
- [aerogear-crypto-ios-demo](https://github.com/aerogear/aerogear-crypto-ios-demo) is deprecated, new location is [aerogear-ios-cookbook/PasswordManager](https://github.com/aerogear/aerogear-ios-cookbook/tree/1.6.x/PasswordManager).

## What's next?

Next release will focus on offline mode. Watch out the mailing list for discussion and progress in that area. You can also expect some house cleaning tasks around deprecated 1.6.x branch. Stay tuned!

Give our libraries and demos a spin and let us know what you think!  If you run into any problems, please [file an issue](http://issues.jboss.org/browse/AGIOS)  and/or ask our [dev](https://lists.jboss.org/mailman/listinfo/aerogear-dev) and [user](https://lists.jboss.org/mailman/listinfo/aerogear-users) mailing list or join us on IRC  [#aerogear channel](irc://irc.freenode.net/aerogear)

Have fun!

AeroGear iOS team