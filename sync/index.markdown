---
layout: basic
title: AeroGear Data-Sync
---

# Data-Sync (under development)

Full real-time data sync where updates are initiated from both the client and server over a bi-directional channel. This feature provides both, a specific server side sync engine, as well as a client side sync engines for Android, iOS and JavaScript. The implementation is based on Google's [Differential Synchonrization](http://research.google.com/pubs/pub35605.html) by Neil Fraser.


## Roadmap

The AeroGear Data-Sync effort started out of a POC and we are now moving towards a first alpha release. 

[List of sync-1.0.0.alpha.1 JIRA tickets](https://issues.jboss.org/issues/?filter=12323088)

## Development

Below are the various GitHub repositories that are part of the Data-Sync feature in AeroGear.

### Data-Sync Server

Our Netty-based [Java Server](https://github.com/aerogear/aerogear-sync-server) exposes WebSocket and XMPP/GCM endpoint for our different clients.

### Android

An [XMPP-client library](https://github.com/aerogear/aerogear-sync-server/tree/master/client-xmpp) to receive sync updates over GCM.

### iOS 

For iOS we have two different libraries that are developed:

* [Differential Synchronization Client Engine](https://github.com/aerogear/aerogear-ios-sync)
* [WebSocket-based Diff-Sync client](https://github.com/aerogear/aerogear-ios-sync-client)

The initial releases of the libraries are available on [CocoaPods](http://cocoapods.org/?q=AeroGearSync) as well.

Besides the libraries we do already have a little [demo application](https://github.com/aerogear/aerogear-ios-sync-demo), which can be used against the above Java server.

### JavaScript

The JavaScript client comes with a WebSocket-based library as well. There is also a Node.js based demo, which can be used against the above Java server.

Currently our JS library and demo is located [here](https://github.com/aerogear/aerogear-sync-server/tree/master/js-client).

## Get involved

If you are interested, feel free to fork the repositories and get your hands dirty. Also, feel free to reach out to us if you have any [questions](/community)!
