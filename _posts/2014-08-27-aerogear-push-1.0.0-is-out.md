---
layout: post
title: AeroGear Mobile Push 1.0.0 is out!

---

We’re happy to announce the availability of AeroGear Mobile Push 1.0.0!

## UnifiedPush Server

The core of this release is the 1.0.0 version of our [UnifiedPush Server](../../../../../push), which supports different platforms for mobile push:

* Android and Google Cloud Messaging
* iOS and Apple Push Notification Service
* FirefoxOS and Mozilla’s SimplePush

Below is a list with a few highlights of the server:

* [Keycloak SSO](http://keycloak.org) integration for user management
* New AdminUI, based on Angular.js
* Metrics and Dashboard for some Analytics around Push Messages
* iOS8 interactive notification support
* increased APNs payload (2k)
* WildFly 8.x support

In our new [User Guide](../../../../../docs/unifiedpush/ups_userguide/) you can find more details about the UnifiedPush Server!

### Openshift Online

The 1.0.0 release of the UnifiedPush Server is available on [Openshift](https://openshift.redhat.com/app/console/application_type/quickstart!15549).

### Docker

The 1.0.0 release of the UnifiedPush Server is also backed by various Docker images for [WildFly](https://registry.hub.docker.com/u/abstractj/unifiedpush-wildfly/) and [AS7](https://registry.hub.docker.com/u/abstractj/unifiedpush-as7/).

## Client SDKs

On the client side we have tiny SDKs which help to register the device from within your app with the UnifiedPush Server. Below is a list of supported platforms

* [Apache Cordova Push Plugin 1.0.0](http://plugins.cordova.io/#/package/org.jboss.aerogear.cordova.push)
* [Android Push 1.0.0](http://search.maven.org/#browse%7C1791667920)
* [iOS Push](http://cocoapods.org/?q=AeroGear-Push)
* [JavaScript/FirefoxOS, part of AeroGear.js 1.5.2](https://github.com/aerogear/aerogear-js-dist/releases/tag/1.5.2)

### iOS 8 and Swift

Since the server is already supporting coming features of iOS8, we are also happy to announce a [Swift branch](https://github.com/aerogear/aerogear-ios-push/tree/swift) of the aerogear-io-push library.

If you want to read more on iOS and Swift side, read Corinne Krych's [code & chat blog](http://corinnekrych.blogspot.fr/2014/08/aerogear-ios8-and-swift-push-happiness.html).

## Backend integration

For backend integration we fully support two libraries:

* [Java Sender, 1.0.0](https://github.com/aerogear/aerogear-unifiedpush-java-client/releases/tag/1.0.0)
* [Node.js Sender, 0.6.0](https://github.com/aerogear/aerogear-unifiedpush-nodejs-client/releases/latest)

However due to the RESTful architecture of the server you are not limited to these two languages. Our [API docs](../../../../../docs/specs/aerogear-unifiedpush-rest/sender/index.html) discuss how to send a push notification, using curl.

## Demos and Examples

To get easily started using the UnifiedPush Server we have a bunch of demos, supporting various client platforms:

* Android
* Apache Cordova (supporting jQuery and Angular/Ionic)
* iOS

### Hello World Example

The HelloWorld is a set of simple clients that show how to register a device with the UnifiedPush Server. On the Admin UI of the server you can use the _"Send Push"_ menu to send a message to the different applications, running on your phone.

Check out the source code on [Github](https://github.com/aerogear/aerogear-push-helloworld).

### Mobile Contacts Quickstart

The Mobile Contacts Quickstart is a Push-enabled CRUD example, containing several client applications (Android, Apache Corodva and iOS) and a JavaEE-based backend. The backend app is a secured (Picketlink) JAX-RS application which sends out push messages when a new contact has been created. Sometimes the backend (for a mobile application) has to run behind the firewall. For that the quickstart contains a Fabric8 based Proxy server as well.

Check out the source code on [Github](https://github.com/aerogear/aerogear-push-quickstarts).

## Documentation

Last but not least we did an overhaul of our [documentation](../../../../../docs/unifiedpush/), containing several tutorials and guides.
