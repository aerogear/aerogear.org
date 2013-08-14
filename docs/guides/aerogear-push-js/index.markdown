---
layout: basic
title: Using UnifiedPush with AeroGear SimplePush.
---

## Using UnifiedPush with AeroGear SimplePush.

The AeroGear UnifiedPush Server apart from providing support on pushing notifications to different mobile platforms (called variants), it also supports pushing notification to Web clients too. It provides an implementation of the [SimplePush protocol](https://wiki.mozilla.org/WebAPI/SimplePush/Protocol), Mozilla's new emerging standard for push notifications.

The AeroGear project provides a [Netty](http://netty.io)-based SimplePush server implementation, which integrates closely with the UnifiedPush Server.

The following step-by-step guides, will briefly introduce you to the concepts of SimplePush itself, howto setup the AeroGear SimplePush and UnifiedPush servers, and with the help of an example we will show you how to send notification messages to your web applications.

1. [SimplePush Protocol Primer](simplepush-primer)
2. [The AeroGear SimplePush Server](simplepush-server)
3. [The AeroGear Unified Push Server](unified-push-server)
4. [Web Example](web-app)
5. [Finally: Send a Push Notification](send-push)
