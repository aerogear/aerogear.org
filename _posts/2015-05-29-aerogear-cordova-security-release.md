---
layout: news
section: news
title: AeroGear Cordova Security Release
author: abstractj
module: security, push
tags: CVE, security, Cordova
---

Today we would like to announce the critical security release for all Android developers using our AeroGear Cordova plugins and we strongly encourage you to update your apps immediately.

The Android plugins from Cordova were affected by [CVE-2015-1835](https://cordova.apache.org/announcements/2015/05/26/android-402.html) — announced earlier this week. As an added precaution, however, we have patched all the projects to ensure that our developers cannot be exploited.

## Plugins affected by CVE-2015-1835

|          Plugin         | Vulnerable |  Patched |
|:-----------------------:|:----------:|:--------:|
| aerogear-cordova-crypto |   < 0.0.2  | >= 0.0.2 |
|   aerogear-cordova-geo  |   < 0.0.2  | >= 0.0.2 |
| aerogear-cordova-oauth2 |   < 1.0.4  | >= 1.0.4 |
|   aerogear-cordova-otp  |   < 0.0.3  | >= 0.0.3 |
|  aerogear-cordova-push  |   < 1.1.1  | >= 1.1.1 |

For technical details regarding this flaw, refer to the [Apache security advisories for Cordova](http://www.openwall.com/lists/oss-security/2015/05/27/7).

Keep everything up to date is the only way to stay secure. Please make sure you're running the [latest version available](https://www.npmjs.com/~aerogear).









