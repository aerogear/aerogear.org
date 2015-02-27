---
layout: landing-page
title: AeroGear.js
section: platforms
---

<article class="push">

  <h1><i class="fa fa-html5"></i> AeroGear.js</h1>
  <p class="alt">Light-weight performant JavaScript library for mobile and hybrid development.</p>

  <p>
    <a href="/docs/specs/aerogear-js/" class="btn btn-primary"><i class="fa fa-file-text-o"></i> API Documentation</a>
    <a href="/getstarted/demos/#js" class="btn btn-primary"><i class="fa fa-cogs"></i> Demos</a>
    <a href="https://github.com/aerogear/aerogear-js/" class="btn btn-primary"><i class="fa fa-github-alt"></i> GitHub Repo</a>
  </p>

  <p>When building mobile web apps, it is important to have lightweight, performant code that gives a great experience to your users no matter what device they might be using. That is where AeroGear.js comes in. This library provides everything from a simple persistence layer to a security API and everything in between.</p>

</article><!-- feature -->

# Downloads and Snippets

{% include downloads/aerogear-js.html excludeSource=true %}

---

# JavaScript Modules

## <i class="fa fa-refresh"></i> Diff Sync

The Diff Sync client and server are based on an implementation of Google's Differential Synchonrization by Neil Fraser.

The DiffSyncClient connects to the AeroGear Sync Server

The DiffSyncEngine is responsible for the algorithm logic.

<a href="/docs/specs/aerogear-js/AeroGear.DiffSyncClient.html" class="btn btn-primary"><i class="fa fa-file-text-o"></i> API Documentation</a>

## <i class="fa fa-shield"></i> Crypto

The AeroGear.Crypto namespace provides a straightforward API to provide an easy to use cryptography interface for data encryption and decryption. This API is also adopted by Cordova Plugin (where native platform is used for cryptography functions) so that no changes are required between web and hybrid application.

<a href="/docs/specs/aerogear-js/AeroGear.Crypto.html" class="btn btn-primary"><i class="fa fa-file-text-o"></i> API Documentation</a>

## <i class="fa fa-database"></i> DataManager

A collection of data connections (stores) and their corresponding data models. This object provides a standard way to interact with client side data no matter the data format or storage mechanism used.

<a href="/docs/specs/aerogear-js/AeroGear.DataManager.html" class="btn btn-primary"><i class="fa fa-file-text-o"></i> API Documentation</a>

## <i class="fa fa-paper-plane"></i> SimplePush Client

SimplePushClient is a client implementation and polyfill for the Mozilla SimplePush specification. SimplePush allows for simple push notification support in web, as well as Firefox OS, applications. This implementation does differ slightly from the specification in that it only works in applications that are "online" and active in the browser. This implementation also supports connecting to both Mozilla's SimplePush server as well as the AeroGear project's server.

<a href="/docs/specs/aerogear-js/AeroGear.SimplePushClient.html" class="btn btn-primary"><i class="fa fa-file-text-o"></i> API Documentation</a>

## <i class="fa fa-paper-plane"></i> UnifiedPush Client

UnifiedPushClient is used in conjunction with AeroGear's UnifiedPush server to register web applications for push notifications. Using the SimplePushClient, a web application can register for push notifications from a SimplePush network and then inform the UnifiedPush server as to where it should send those push notifications.

See the UnifiedPushClient API docs for more info.

<a href="/docs/specs/aerogear-js/AeroGear.UnifiedPushClient.html" class="btn btn-primary"><i class="fa fa-file-text-o"></i> API Documentation</a>