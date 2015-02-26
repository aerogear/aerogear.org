---
layout: post
section: news
title: Devoxx keynote Feedhenry AeroGear demo
author: matzew
module: push
---


For the Devoxx keynote we wanted to show off FeedHenry, because our libraries are server agnostic we thought it would be doable and thanks to some great help we got from the people at FeedHenry the integration with AeroGear was a breeze. Now it's even available in a generic form for all FH users to use (as a mBaas Service) it uses our [Node.js library](https://www.npmjs.org/package/unifiedpush-node-sender), read more about it on the [FeedHenry blog](http://www.feedhenry.com/pushing-ahead-with-integrations/).

For those who didn't have a chance to view the keynote demo, let me describe how it works. We create a mobile application that creates a photo and tweets it with a 'special' hash tag. People in the audience can tweet something and include these tags then a  [meme](http://en.wikipedia.org/wiki/Meme) is created with their tweet text. [Fuse](http://www.jboss.org/products/fuse/overview/) is listening to tweets that come in and puts them in a queue, the FeedHenry backend 'listens' to this queue and creates a meme out of the tweet. When a new meme has been created the UnifiedPush server is used to inform the mobile client about that. The payload of the push message includes a URL of the meme that was created so the mobile client can show it. If the meme is extremely funny the mobile client can 'retweet' it.

The demo uses 2 node.js services one which connects to JBoss A-MQ for xPaaS running on OSE via TCP/STOMP protocol and the other one connecting to our UnifiedPush Server instance running on OpenShift Online via REST.

![demo overview](https://4.bp.blogspot.com/-oEecCc0DIHA/VGHyoJDoUsI/AAAAAAAAwcs/0ZjA9_rLKzc/s1600/Bild2.png)

It's always hard to find a good idea for a keynote demo it should be fun and involve the public, but they should not have to install things before they can participate, so that is why twitter is an obvious choice. The mobile part of the demo was build using [Cordova](http://cordova.apache.org) this is very well supported by FH, from their application console you can create builds for iOS and Android, but also easily test it locally. We used the FH client side JavaScript that way we get statistics in the application management console, this can be very helpful when you have a production issue and try to diagnose the problem, for instance. Using cordova together with Node is really nice, no need to switch paradigms and you can rapidly try out new ideas.
