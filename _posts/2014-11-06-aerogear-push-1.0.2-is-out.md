---
layout: base
title: AeroGear UnifiedPush Server 1.0.2 is out!
nav-active-news: active
section-title: AeroGear News
section-class: news
section-description: Artciles, posts, events, videos and updates.
breadcrumbs-url: /news/
sub-section-title: News
author: matzew
module: push
---


We’re happy to announce the availability of AeroGear UnifiedPush Server 1.0.2!

## UnifiedPush Server

The [UnifiedPush Server](../../../../../push) supports different platforms for mobile push:

* Android and Google Cloud Messaging
* iOS and Apple Push Notification Service
* FirefoxOS and Mozilla’s SimplePush

Below is a list with a few highlights of this release:

* Keycloak 1.0.4 usage
* New developer role for multi user support
* SSLv3 version removed from docs
* User guide updates
* UI fixes and improvements

The complete release notes are available in our [JIRA instance](https://issues.jboss.org/secure/ReleaseNote.jspa?projectId=12313724&version=12325081).

## Docker

The 1.0.2 release of the UnifiedPush Server is also backed by various Docker images for [WildFly](https://github.com/aerogear/dockerfiles/tree/master/wildfly/unifiedpush-wildfly).

## Apache Cordova Push Plugin

With this release of Unified Push Server we are also releasing a new version (1.0.2) of our [Apache Cordova Push Plugin](http://plugins.cordova.io/#/package/org.jboss.aerogear.cordova.push).

## Demos and Examples

To get easily started using the UnifiedPush Server we have a bunch of demos, supporting various client platforms:

* Android
* Apache Cordova (supporting jQuery and Angular/Ionic)
* iOS

### Hello World Example

The HelloWorld is a set of simple clients that show how to register a device with the UnifiedPush Server. Using the Admin UI of the server you can use the _"Send Push"_ menu to send a message to the different applications, running on your phone.

Check out the source code on [Github](https://github.com/aerogear/aerogear-push-helloworld/releases/latest).

### Mobile Contacts Quickstart

The Mobile Contacts Quickstart is a Push-enabled CRUD example, containing several client applications (Android, Apache Corodva and iOS) and a JavaEE-based backend. The backend app is a secured (Picketlink) JAX-RS application which sends out push messages when a new contact has been created. Sometimes the backend (for a mobile application) has to run behind the firewall. For that the quickstart contains a Fabric8 based Proxy server as well.

Check out the source code on [Github](https://github.com/aerogear/aerogear-push-quickstarts/releases/latest).
