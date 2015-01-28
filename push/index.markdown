---
layout: basic
title: AeroGear Push
---

# AeroGear Push

AeroGear has support for different push notification technologies:

* [UnifiedPush Server (supports Android, iOS, Windows, FirefoxOS)](#unifiedpush-server)
* [SimplePush Server](#unifiedpush-server)
* [WebPush Server](#unifiedpush-server)

## UnifiedPush Server

The AeroGear UnifiedPush Server is server that allows sending native push messages to different mobile operating systems, such as Android, iOS, Windows or Firefox OS/SimplePush.

### See it in Action

To see it in action, watch the screencast below:

<p><center><iframe width="560" height="315" src="//www.youtube.com/embed/-hh-sEesocs" frameborder="0" allowfullscreen></iframe></center></p>

### Getting started

To get started with the UnifiedPush Server checkout one of our releases, or fork the [Github repo](https://github.com/aerogear/aerogear-unifiedpush-server)!

* [1.0.2 (stable)](https://github.com/aerogear/aerogear-unifiedpush-server/releases/tag/1.0.2)
* [1.1.0-alpha.1 (development)](https://github.com/aerogear/aerogear-unifiedpush-server/releases/latest)

For more information please checkout out our detailed [Documentation](/docs/unifiedpush).

## SimplePush Server

Our SimplePush Server represents an implementation of [Mozilla's SimplePush](https://wiki.mozilla.org/WebAPI/SimplePush), which is based on-top of WebSocket. It was created for Push Notifications delivery on FirefoxOS, but can also be used for different use-cases, like for the Internet-of-Things.

### See it in Action

Best way to see our SimplePush Server in action is using our [Quickstart example](https://github.com/aerogear/aerogear-js-cookbook/tree/master/simplepush-example).

### Getting started

To get started with the SimplePush Server checkout the last [0.12.1 releases](https://github.com/aerogear/aerogear-simplepush-server/zipball/0.12.1), or fork the [Github repo](https://github.com/aerogear/aerogear-simplepush-server)!

## WebPush Server

The [WebPush Specification](https://tools.ietf.org/html/draft-thomson-webpush-http2) is based on HTTP2 and currently in an early state. The AeroGear team sees it as the successor of SimplePush.

### Getting started

To get started with the WebPush Server fork the [Github repo](https://github.com/aerogear/aerogear-webpush-server)!

## Roadmap

Upcoming releases of these three push servers are tracked in our project [roadmap](/docs/planning/).

## Get involved

If you are interested, feel free to fork the repositories and get your hands dirty. Also, feel free to reach out to us if you have any [questions](/community)!
