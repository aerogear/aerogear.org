---
layout: basic
title: AeroGear Data-Sync
---

# Data-Sync (under development)

Full real-time data sync where updates are initiated from both the client and server over a bi-directional channel. This feature provides server side sync engines, as well as client side sync engines and clients for Android, iOS and JavaScript. The implementation is based on Google's [Differential Synchonrization](http://research.google.com/pubs/pub35605.html) by Neil Fraser.

## Roadmap

The AeroGear Data-Sync effort started out of a POC and we are now moving towards a first alpha release. 

[List of sync-1.0.0.alpha.1 JIRA tickets](https://issues.jboss.org/issues/?filter=12323088)

## Specification
The specification for AeroGear Data-Sync including client/server API, message format and more can be found here:  
[Data-Sync Specification](../docs/specs/aerogear-data-sync)

## Development

Below are the various GitHub repositories that are part of the Data-Sync feature in AeroGear.

### Data-Sync Server

* [Java Sync Server Engine](https://github.com/aerogear/aerogear-sync-server/tree/master/server/server-core#aerogear-server-differential-synchronization-server-core) the Server Sync Engine.
* [Netty Sync Server](https://github.com/aerogear/aerogear-sync-server/tree/master/server/server-netty#netty-differential-synchronization-server-implementation) which embeds the Java Server Sync Engine and exposes WebSocket and XMPP/GCM endpoint for our different clients.
* [Node Sync Server](https://github.com/aerogear/aerogear-nodejs-sync-server#aerogear-nodejs-sync-server-) which exposes WebSocket for our different clients.

### Android
* [Java Client Sync Engine](https://github.com/aerogear/aerogear-sync-server/tree/master/client/client-core#aerogear-server-differential-synchronization-client-core) a Java Client Sync Engine implementation.
* [Netty Sync Client](https://github.com/aerogear/aerogear-sync-server/tree/master/client/client-netty) a Netty based WebSocket Sync Client.
* [XMPP Client](https://github.com/aerogear/aerogear-android-sync#xmpp-differential-synchronization-client-implementation) to receive sync updates over GCM.
* [Demo application](https://github.com/aerogear/aerogear-android-cookbook) which can be used against the above Java server.

### iOS 

* [Sync Client Engine](https://github.com/aerogear/aerogear-ios-sync#aerogear-ios-differential-synchronization-client-engine--) a Swift based Client Sync Engine library.
* [Sync Client](https://github.com/aerogear/aerogear-ios-sync-client#aerogear-ios-differential-synchronization-client--) a Swift based WebSocket Sync Client.
* [Demo application](https://github.com/aerogear/aerogear-ios-cookbook/tree/master/Jedi#jedi) which can be used against the above Java server.

The initial releases of the libraries are available on [CocoaPods](http://cocoapods.org/?q=AeroGearSync) as well.

### JavaScript

* [Sync Library](https://github.com/aerogear/aerogear-js/tree/master/src/diff-sync) a JavaScript based Client Sync Engine implementation and WebSocket client library.
* [Demo application](https://github.com/aerogear/aerogear-js-cookbook/tree/diff-sync-json-patch/diff-sync#differential-syncronization) a Node.js based demo, which can be used againste the above Java Sync Server.

## Get involved

If you are interested, feel free to fork the repositories and get your hands dirty. Also, feel free to reach out to us if you have any [questions](/community)!
