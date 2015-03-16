---
layout: landing-page
title: AeroGear iOS
section: platforms
---

<article class="push">

  <h1><i class="fa fa-apple"></i> AeroGear iOS</h1>
  <p class="alt">The aim of the project is to provide a set of convenient and modular <a href="https://developer.apple.com/swift/">Swift based</a> iOS libraries.</p>

  <p>
    <a href="/getstarted/guides/" class="btn btn-primary"><i class="fa fa-book"></i> Guides</a>
    <a href="/getstarted/demos/#ios" class="btn btn-primary"><i class="fa fa-cogs"></i> Demos</a>
    <a href="/docs/specs/" class="btn btn-primary"><i class="fa fa-file-text-o"></i> Documentation</a>
    <a href="https://github.com/aerogear/?query=ios" class="btn btn-primary"><i class="fa fa-github-alt"></i> GitHub Repos</a>
  </p>

  <p>The library features are ranging from networking, authorization (and in particular OAuth2) , Storage and Crypto. We believe the iOS platform offers a solid  and extremely powerful foundation, but there are cases in which developer productivity can be improved by offering a much easier access to that foundation.  Please use the corresponding links below for more information of the features provided by each respective library.</p>

</article><!-- feature -->

# iOS SDK

{% for item in site.data.sdk['ios']['modules'] %}
{% assign moduleName = item[0] %}
{% assign module = item[1] %}

<!-- CAPTURE DESCRIPTION -->
{% capture description %}
{% case moduleName %}
{% when 'http' %}
[aerogear-ios-http](https://github.com/aerogear/aerogear-ios-http/) is a thin layer to take care of your http requests working with NSURLSession. Taking care of:

* Json serializer
* Multipart upload
* HTTP Basic/Digest authentication support
* Pluggable object serialization
* background processing support
{% when 'oauth2' %}
[aerogear-ios-oauth2](https://github.com/aerogear/aerogear-ios-oauth2/) is an OAuth2 Client based on aerogear-ios-http. Taking care of:

* account manager for multiple OAuth2 accounts,
* request access and refresh token,
* grant access through secure external browser and URI schema to re-enter app,
* (implicit or explicit) refresh tokens,
* revoke tokens,
* permanent secure storage,
* adaptable to OAuth2 specific providers. Existing extensions: Google, Facebook, Keycloak etc...
* openID Connect login
{% when 'push' %}
[aerogear-ios-push](https://github.com/aerogear/aerogear-ios-push/) is a small and handy library written in Swift that helps to register iOS applications with the AeroGear UnifiedPush Server.
{% when 'jsonsz' %}
[aerogear-ios-jsonsz](https://github.com/aerogear/aerogear-ios-jsonsz/) serializes 'Swift' objects back-forth from their JSON representation the 'easy way'.
{% when 'sync' %}
[aerogear-ios-sync](https://github.com/aerogear/aerogear-ios-sync/)  an iOS Sync Engine for AeroGear Differential Synchronization server
{% when 'sync-client' %}
[aerogear-ios-sync-client](https://github.com/aerogear/aerogear-ios-sync-client/) a client side implementation for AeroGear Differential Synchronization server based on websockets

{% endcase %}
{% endcapture %}
<!-- END DESCRIPTION -->

## <i class="fa {{ site.data.modules[module.module]['icon'] }}"></i> <strong>{{ module.name }}</strong> Module
{{ description }}
{% include downloads/ios-module.html moduleName=moduleName module=module %}

{% endfor %}