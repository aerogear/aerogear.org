---
layout: news
section: news
title: Red Hat JBoss Unified Push Server and xPaaS
author: matzew
module: push
tags: xpaas
---


We are happy to announce that the [JBoss Unified Push Server](http://www.jboss.org/unifiedpush/) is officially available as a Developer Preview as part of the [JBoss xPaaS Services for OpenShift](https://developers.openshift.com/en/xpaas.html#_mobile_services)!

## What is your "x" ?

Being listed as a Mobile Service on xPaaS, the [JBoss Unified Push Server](https://developers.openshift.com/en/xpaas-unified-push.html) allows developers to send native push messages to Apple’s Push Notification Service (APNS) and Google’s Cloud Messaging (GCM). It features a built-in [administration console](http://docs.jboss.org/unifiedpush/unifiedpush.pdf) that makes it easy for developers to create and manage the push related aspects of their applications for any mobile development environment. Includes [client SDKs](https://www.jboss.org/download-manager/file/jboss-unified-push-1.0.0.Beta1-clients.zip) (iOS, Android, & Cordova), and a REST based sender service with available Node.js and Java sender libraries.

## Unified Push Quickstarts

To get started using the JBoss Unified Push Server there are a series of [quickstarts](https://github.com/jboss-developer/jboss-unifiedpush-quickstarts/archive/1.0.0.Beta1.zip), from the basics, to business logic integration. Each quickstart comes with multiple client options (Android, iOS, and Apache Cordova (jQuery Mobile & Angular/Ionic)).

## Try it on Openshift

Deploying the Unified Push Server on Openshift is simple, just follow the instructions in [this document](https://developers.openshift.com/en/xpaas-unified-push.html#getting-started).

## FeedHenry integration

If you are curious about our [FeedHenry integration](/news/2014/11/11/aerogear-feedhenry-integration/index.html), please check out our previous blog for the [Devoxx Keynote demo](/news/2014/11/12/aerogear-feedhenry-devoxx-demo/index.html).

## What's next for the Unified Push Server? 

In the AeroGear community we are working hard to improve feature set of our Unified Push Server. The upstream project is plans to add support for more Push-Network services, like [Microsoft Push Notification Service (MPNS)](http://msdn.microsoft.com/en-us/library/windows/apps/ff402558.aspx), [Windows Push Notification Services (WNS)](http://msdn.microsoft.com/en-us/library/windows/apps/hh913756.aspx), [SimplePush for Firefox OS](https://wiki.mozilla.org/WebAPI/SimplePush), [APNs for Safari Browser](https://developer.apple.com/notifications/safari-push-notifications/) and [GCM for Chrome Apps](https://developer.chrome.com/extensions/cloudMessaging)

_Stay tuned!_