---
layout: basic
title: AeroGear UnifiedPush Server and Apache Cordova applications
---

## Apache Cordova and APNs Push Notifications with AeroGear's UnifiedPush Server

The following step-by-step guides, give you an introduction on how to use the AeroGear UnifiedPush Server for sending Push Notifications to your own Cordova-iOS Apps. The guide assumes you have an Apple developer account already setup as well as a real iOS device (not through emulator) for testing. So, let's get started:

### Apple Setup

The most complicated part of getting started with APNs is the creation of a proper SSL certificate and getting a working Provisioning Profile. These steps are similar to those that are required when using our native iOS library. The [Tutorial on native iOS Push Notifications](/docs/guides/aerogear-push-ios/) explains them:

* [Apple App ID and SSL Certificate for APNs](/docs/guides/aerogear-push-ios/app-id-ssl-certificate-apns)
* [Apple Provisioning Profile](/docs/guides/aerogear-push-ios/provisioning-profiles)

### AeroGear UnifiedPush Server

Once you have the required Apple bits, it's time to get started with the AeroGear UnifiedPush Server. Same to the _Apple Setup_, the [Tutorial on native iOS Push Notifications](/docs/guides/aerogear-push-ios/) covers the iOS specific setup steps:

* [The AeroGear UnifiedPush Server](/docs/guides/aerogear-push-ios/unified-push-server)

_If you want to use the AdminUI you can read about it [here](/docs/guides/AdminConsoleGuide/)_

### Apache Cordova

Now after the initial setup it's finally time to concentrate on the actual application:

* [Your first iOS-Push App with Apache Cordova](cordova-iOS-app)

### Sending a notification

With having a functional application, running on your device, it is time to finally send a message to it:

* [Sending Push Notification to Apache Cordova](send-push)
