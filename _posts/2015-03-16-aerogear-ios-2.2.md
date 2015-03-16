---
layout: post
title: AeroGear iOS SDK v2.2 is out !
---

Hello AeroGear Community,

The iOS team is happy to announce the next versions of AeroGear iOS libraries. Here is what's inside:

**1. Synchronisation *(new)*:**

With the [1.0.0-alpha1 sync release](/sync), AeroGear add a new feature to its tools belt: synchronization of data. Sync is declined server side: with Java and JavaScript libraries and client side: with Android and iOS platforms. To learn more about synchronisation, [read the sync announcement](/news/2015/02/17/aerogear-sync/index.html).

The work around synchronisation on iOS is covered with:

- [aerogear-ios-sync](https://github.com/aerogear/aerogear-ios-sync): the sync engine is where the algorithm is implemented. The sync algorithm is based on Google's [Differential Synchronisation](http://research.google.com/pubs/pub35605.html). We provide two implementations: one text-based [DiffMatchPatch](https://github.com/aerogear/aerogear-diffmatchpatch-ios) and a JsonPatch version based on [JSON Patch RFC6902](https://tools.ietf.org/html/rfc6902). 

- [aerogear-ios-sync-client](https://github.com/aerogear/aerogear-ios-sync-client): the client uses sync engine and a network implementation. Our libraries is based on WebSockets to provide real-time sync.

- [Jedi demo](https://github.com/aerogear/aerogear-ios-cookbook/tree/master/Jedi): Star war fan, rejoice in discovering our two Jedi hobbies demos (DiffMatchPatch and JsonPatch).
      
**2. House cleaning tasks:**

- Move to [cocoapods 0.36.0](http://blog.cocoapods.org/CocoaPods-0.36/) for using iOS dynamic framework.

- Deprecate [aerogear-ios-httpstub](https://github.com/aerogear/aerogear-ios-httpstub).

- and cookbook demos: Buddies is replaced by [ChuckNorris](https://github.com/aerogear/aerogear-ios-cookbook/tree/master/ChuckNorrisJokes) to remove backend dependency. [AeroDoc repo](https://github.com/aerogear/aerogear-aerodoc-ios) has moved to [cookbook 1.6.x branch](https://github.com/aerogear/aerogear-ios-cookbook/tree/1.6.x) to better gather together all demos.

#### What's next?
We will carry on our effort on sync and to provide a better Swift implementation of [JSON Pointer RFC6901](https://tools.ietf.org/html/rfc6901) and [JSON Patch RFC6902](https://tools.ietf.org/html/rfc6902). Stay tuned!

Give our libraries and demos a spin and let us know what you think!  If you run into any problems, please [file an issue](http://issues.jboss.org/browse/AGIOS)  and/or ask our [dev](https://lists.jboss.org/mailman/listinfo/aerogear-dev) and [user](https://lists.jboss.org/mailman/listinfo/aerogear-users) mailing list or join us on IRC  [#aerogear channel](irc://irc.freenode.net/aerogear)

Have fun!

AeroGear iOS team