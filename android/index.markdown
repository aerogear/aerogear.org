---
layout: landing-page
title: AeroGear Android
section: platforms
---

<article class="push">

  <h1><i class="fa fa-android"></i> AeroGear Android</h1>
  <p class="alt">Android libraries that makes developing native applications easier.</p>

  <p>
    <a href="/getstarted/guides/" class="btn btn-primary"><i class="fa fa-book"></i> Guides</a>
    <a href="/getstarted/demos/#android" class="btn btn-primary"><i class="fa fa-cogs"></i> Demos</a>
    <a href="/docs/specs/" class="btn btn-primary"><i class="fa fa-file-text-o"></i> Documentation</a>
    <a href="https://github.com/aerogear/?query=android" class="btn btn-primary"><i class="fa fa-github-alt"></i> GitHub Repos</a>
  </p>

  <p>AeroGear's Android libraries simplifies common tasks including but not limited to</p>

  <ol>
    <li><a href="/docs/guides/aerogear-android/pipe/">Connecting to RESTful Services</a></li>
    <li><a href="/docs/guides/aerogear-android/authz/">Negotiating with OAuth 2 Providers</a></li>
    <li><a href="/docs/guides/aerogear-android/store/">Managing Local Data Stores</a></li>
    <li><a href="https://github.com/aerogear/aerogear-android-cookbook/tree/master/ShootAndShare">Uploading Selfies to Social Media</a></li>
  </ol>
</article><!-- feature -->

## Requirements and Recommendations

AeroGear 2.x supports Android 4.1 and higher.  If you need support for Android 2.3, please use [AeroGear Android 1.4](https://github.com/aerogear/aerogear-android/releases).  We recommend [Android Studio](http://developer.android.com/sdk/index.html) for application development. 

---

# Android SDK

Android library is broken up into modules and available from Maven Central and GitHub

## <i class="fa fa-rocket"></i> Core Module
[aerogear-android-core](https://github.com/aerogear/aerogear-android-core) contains some common packages and utilities shared across all our libraries.  

{% include downloads/android-module.html module='core' %}


## <i class="fa fa-shield"></i> Security Module
[aerogear-android-security](https://github.com/aerogear/aerogear-android-security) provides some basic encryption and key management utilities.

{% include downloads/android-module.html module='security' %}

## <i class="fa fa-database"></i> Store Module
[aerogear-android-store](https://github.com/aerogear/aerogear-android-store)  is a simple data storage API. This API is useful for caching responses, sharing data among different systems, or providing some form of limited offline support.

{% include downloads/android-module.html module='store' %}


## <i class="fa fa-exchange"></i> Pipe Module
[aerogear-android-pipe](https://github.com/aerogear/aerogear-android-pipe) is used to interact with RESTful services.

{% include downloads/android-module.html module='pipe' %}

## <i class="fa fa-key"></i> Auth Module
[aerogear-android-auth](https://github.com/aerogear/aerogear-android-auth) provides Pipe modules for HTTP Basic and HTTP Digest authentication.

{% include downloads/android-module.html module='auth' %}

## <i class="fa fa-shield"></i> Authz Module
[aerogear-android-authz](https://github.com/aerogear/aerogear-android-authz) provides Pipe modules for connecting to OAuth 2 secured services as well as basic token management.

{% include downloads/android-module.html module='authz' %}


## <i class="fa fa-paper-plane"></i> Push Module
[aerogear-android-push](https://github.com/aerogear/aerogear-android-push) connects to the Unified Push Server and Google Cloud Messaging to enable push notification in AeroGear applications.

{% include downloads/android-module.html module='push' %}

---

# Roadmap

Keep an eye on our [JIRA](https://jira.jboss.org/browse/AGDROID) page for upcoming releases as well as what we are currently working on.


## <i class="fa fa-refresh"></i>  Sync

We've started working on a sync library to work with the [aerogear-sync-server](https://github.com/aerogear/aerogear-sync-server). This is scheduled to be the big new feature of 2.1.  You can track our progress in our [JIRA](https://issues.jboss.org/issues/?jql=fixVersion%20%3D%202.1.0%20AND%20project%20%3D%20AGDROID).

And as a [sneak peek](https://plus.google.com/103442292643366117394/posts/2Eusx4tPY9c)


## <i class="fa fa-shield"></i> More OAuth2

For 2.2 we are going to enhance our authorization support.  We will include more OAuth2 providers, better KeyCloak support, better Android account integration, and support for custom authentication and authorization through intents in addition to our current WebView approach.  Again, you can follow our [Jira](https://issues.jboss.org/issues/?jql=fixVersion%20%3D%202.2.0%20AND%20project%20%3D%20AGDROID).

# Involvement

We hope that you will take some time to look at AeroGear, provide feedback, and build awesome apps. As always you can reach us via:

* Our mailing lists 
   * [aerogear-dev](https://lists.jboss.org/mailman/listinfo/aerogear-dev)
   * [aerogear-users](https://lists.jboss.org/mailman/listinfo/aerogear-users)
* IRC (#aerogear on FreeNode)
* Twitter(@aerogears).
