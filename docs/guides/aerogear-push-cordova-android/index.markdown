---
layout: basic
title: AeroGear UnifiedPush Server and Apache Cordova applications
---

## Apache Cordova and GCMs Push Notifications with AeroGear's UnifiedPush Server

The following step-by-step guides, give you an introduction on how to use the AeroGear UnifiedPush Server for sending Push Notifications to your own Cordova-android Apps.

### Google Setup

First you'll need to setup the Google Cloud Messaging Service API access. The steps are the same as those that are required for native android. The [GCM Push Notifications with AeroGear’s UnifiedPush Server](/docs/guides/aerogear-push-android/) explains them:

* [Setup Google Cloud Messaging Service](/docs/guides/aerogear-push-android/google-setup/)

### AeroGear UnifiedPush Server

Once you have the required Google bits, it's time to get started with the AeroGear UnifiedPush Server.

* [The AeroGear UnifiedPush Server](/docs/guides/aerogear-push-android/register-device)

_If you want to use the AdminUI you can read about it [here](/docs/guides/AdminConsoleGuide/)_

### Apache Cordova

Now after the initial setup it's finally time to concentrate on the actual application:

* [Your first android-Push App with Apache Cordova](cordova-android-app)

### Sending a notification

With having a functional application, running on your device, it is time to finally send a message to it:

* [Sending Push Notification to Apache Cordova](send-push)
