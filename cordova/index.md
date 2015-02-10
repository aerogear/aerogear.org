---
layout: basic
title: Hybrid with Cordova
---

![Cordova logo](/img/cordova-logo.png)

# AeroGear Cordova
AeroGear Cordova makes developing apps with Cordova easier by adding plugins for thing that are hard to do right.

# Usage
We have lots of [guides](/docs/guides/aerogear-cordova/) and [sample applications](https://github.com/aerogear/aerogear-cordova-cookbook) to help you get started with AeroGear Cordova.

## Push Plugin
The Push Plugin works together with the [Unified Push Server](/docs/unifiedpush/) and because of this your javascript code can be
platform independent and [easy to setup](/docs/guides/aerogear-cordova/AerogearCordovaPush/).

## OTP (One time Password) Plugin
This plugin makes it easier to have a OTP in a secure way on Cordova. It supports QR-code reading of the secret and storing it secure on the [device natively](/docs/guides/aerogear-cordova/AerogearCordovaOTP/). 

## Crypto Plugin
Another security based plugin, because javascript by nature is less secure and crypto algorythms take a lot of power this plugin supports basic [crypto functions natively](/docs/guides/aerogear-cordova/AerogearCordovaCrypto/).

## Geofencing Plugin
Creating [geo fences](/docs/specs/aerogear-cordova/geofencing.html) is a cool way to inform you users that he is getting close to a place of intrest, this plugin creates geo fences in a battery efficient way using platform specific api.

## OAuth2 Plugin
Last but not least is our OAuth2 Plugin that lets you do [OAuth2 based Authorization](https://github.com/aerogear/aerogear-oauth2-cordova)

# Roadmap
Keep an eye on our [JIRA](https://jira.jboss.org/browse/AGCORDOVA) page for upcoming releases as well as what we are currently working on.

## Platforms
Right now iOS and Android are the supported platforms and we are working on supporting windows as well the Push Plugin already has windows support. See [JIRA](https://issues.jboss.org/browse/AGCORDOVA/?selectedTab=com.atlassian.jira.jira-projects-plugin:roadmap-panel) for things we are working on at the moment.
