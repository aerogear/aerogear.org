---
layout: basic
title: AeroGear Android
---

# AeroGear Android

 AeroGear's Android libraries make developing applications easier by simplifying common tasks including but not limited to   


 * [Connecting to RESTful Services](/docs/guides/aerogear-android/pipe/)
 * [Negotiating with OAuth 2 Providers](/docs/guides/aerogear-android/authz/)
 * [Managing Local Data Stores](/docs/guides/aerogear-android/store/)
 * [Uploading Selfies to Social Media](https://github.com/aerogear/aerogear-android-cookbook/tree/master/ShootAndShare)

# Usage

We have lots of [guides](https://aerogear.org/docs/guides/aerogear-android/) and [sample applications](https://github.com/aerogear/aerogear-android-cookbook) to help you get started with AeroGear and Android.

## Requirements and Recommendations

AeroGear 2.x supports Android 4.1 and higher.  If you need support for Android 2.3, please use [AeroGear Android 1.4](https://github.com/aerogear/aerogear-android/releases).  We recommend [Android Studio](http://developer.android.com/sdk/index.html) for application development. 

# Our Libraries 

Our library is broken up into modules and available from Maven Central and GitHub

## Core Module
[aerogear-android-core](https://github.com/aerogear/aerogear-android-core) contains some common packages and utilities shared across all our libraries.  

* Version 2.0.0
* [Maven Central](http://search.maven.org/#artifactdetails%7Corg.jboss.aerogear%7Caerogear-android-core%7C2.0.0%7Caar)
* [Zip Release](https://github.com/aerogear/aerogear-android-core/archive/2.0.0.zip)


## Security Module
[aerogear-android-security](https://github.com/aerogear/aerogear-android-security) provides some basic encryption and key management utilities.

* Version 2.0.0
* Requires -core
* [Maven Central](http://search.maven.org/#artifactdetails%7Corg.jboss.aerogear%7Caerogear-android-security%7C2.0.0%7Caar)
* [Zip Release](https://github.com/aerogear/aerogear-android-security/archive/2.0.0.zip)

## Store Module
[aerogear-android-store](https://github.com/aerogear/aerogear-android-store)  is a simple data storage API. This API is useful for caching responses, sharing data among different systems, or providing some form of limited offline support.

* Version 2.0.0
* Requires -security
* [Maven Central](http://search.maven.org/#artifactdetails%7Corg.jboss.aerogear%7Caerogear-android-store%7C2.0.0%7Caar)
* [Zip Release](https://github.com/aerogear/aerogear-android-store/archive/2.0.0.zip)


## Pipe Module
[aerogear-android-pipe](https://github.com/aerogear/aerogear-android-pipe) is used to interact with RESTful services.

* Version 2.0.0
* Requires -core
* [Maven Central](http://search.maven.org/#artifactdetails%7Corg.jboss.aerogear%7Caerogear-android-pipe%7C2.0.0%7Caar)
* [Zip Release](https://github.com/aerogear/aerogear-android-pipe/archive/2.0.0.zip)

## Auth Module
[aerogear-android-auth](https://github.com/aerogear/aerogear-android-auth) provides Pipe modules for HTTP Basic and HTTP Digest authentication.

* Version 2.0.0
* Requires and -pipe
* [Maven Central](http://search.maven.org/#artifactdetails%7Corg.jboss.aerogear%7Caerogear-android-auth%7C2.0.0%7Caar)
* [Zip Release](https://github.com/aerogear/aerogear-android-auth/archive/2.0.0.zip)

## Authz Module
[aerogear-android-authz](https://github.com/aerogear/aerogear-android-authz) provides Pipe modules for connecting to OAuth 2 secured services as well as basic token management.

* Version 2.0.0
* Requires -pipe and -store
* [Maven Central](http://search.maven.org/#artifactdetails%7Corg.jboss.aerogear%7Caerogear-android-authz%7C2.0.0%7Caar)
* [Zip Release](https://github.com/aerogear/aerogear-android-authz/archive/2.0.0.zip)


## Push Module
[aerogear-android-push](https://github.com/aerogear/aerogear-android-push) connects to the Unified Push Server and Google Cloud Messaging to enable push notification in AeroGear applications.

* Version 2.0.0
* Requires -pipe
* [Maven Central](http://search.maven.org/#artifactdetails%7Corg.jboss.aerogear%7Caerogear-android-push%7C2.0.0%7Caar)
* [Zip Release](https://github.com/aerogear/aerogear-android-push/archive/2.0.0.zip)

# Roadmap

Keep an eye on our [JIRA](https://jira.jboss.org/browse/AGDROID) page for upcoming releases as well as what we are currently working on.


## Sync

We've started working on a sync library to work with the [aerogear-sync-server](https://github.com/aerogear/aerogear-sync-server). This is scheduled to be the big new feature of 2.1.  You can track our progress in our [JIRA](https://issues.jboss.org/issues/?jql=fixVersion%20%3D%202.1.0%20AND%20project%20%3D%20AGDROID).

And as a [sneak peek](https://plus.google.com/103442292643366117394/posts/2Eusx4tPY9c)


## More OAuth2

For 2.2 we are going to enhance our authorization support.  We will include more OAuth2 providers, better KeyCloak support, better Android account integration, and support for custom authentication and authorization through intents in addition to our current WebView approach.  Again, you can follow our [Jira](https://issues.jboss.org/issues/?jql=fixVersion%20%3D%202.2.0%20AND%20project%20%3D%20AGDROID).

# Involvement

We hope that you will take some time to look at AeroGear, provide feedback, and build awesome apps. As always you can reach us via:

* Our mailing lists 
   * [aerogear-dev](https://lists.jboss.org/mailman/listinfo/aerogear-dev)
   * [aerogear-users](https://lists.jboss.org/mailman/listinfo/aerogear-users)
* IRC (#aerogear on FreeNode)
* Twitter(@aerogears).
