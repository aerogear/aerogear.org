---
layout: index
title: Documentation Library
section: docs
---

<h2 class="section-header" id="core"><i class="fa fa-rocket"></i> AeroGear<strong>SDK</strong> Docs</h2>

<style>
span.version {
   color: gray;
   font-size: 0.8em;
}
</style>

<h4 id="coreAndroid">Android</h4>

{% for item in site.data.sdk['android']['modules'] %} {% assign module = item[1] %} 
* [{{ module.name | capitalize }}](http://www.javadoc.io/doc/org.jboss.aerogear/aerogear-android-{{ module.name }}/) <span class="version">{{ module.version }}</span>{% endfor %}

<h4 id="coreIOS">iOS</h4>
* [Http](aerogear-ios-http) <span class="version">0.2.0</span>
* [OAuth2](aerogear-ios-oauth2) <span class="version">0.2.0</span>
* [JsonSZ](aerogear-ios-jsonsz) <span class="version">0.1.0</span>
* [Sync](aerogear-ios-sync) <span class="version">1.0.0-alpha.1</span>
* [Sync client](aerogear-ios-sync-client) <span class="version">1.0.0-alpha.1</span>
* [Push](aerogear-ios-push) <span class="version">1.1.0-beta.1-swift</span>
* [OTP](aerogear-otp-ios) <span class="version">1.0.0</span>
* [Crypto](aerogear-ios-crypto) <span class="version">0.2.3</span>

<h4 id="coreCordova">Cordova</h4>
* [AeroGear Cordova](aerogear-cordova)

<h4 id="coreJs">JavaScript</h4>
* [AeroGear.js](aerogear-js) <span class="version">2.1.0</span>

<h4>Deprecated</h4>
* [Pipe API](aerogear-client-pipe)
* [Paging API](aerogear-client-paging)
* [Paging API usage examples](aerogear-client-paging-usage)

---

<h2 class="section-header" id="push"><i class="fa fa-paper-plane"></i> AeroGear<strong>Push</strong> Docs</h2>

<h4 id="unifiedpush">UnifiedPush</h4>

* [UnifiedPush Message Format](../unifiedpush/push-message-format/)
* [UnifiedPush Client Registration](../unifiedpush/client-registration/)
* [UnifiedPush RESTful APIs](aerogear-unifiedpush-rest/index.html)  <span class="version">1.1.0</span>
* [UnifiedPush RESTful APIs](aerogear-unifiedpush-rest-1.0.x/overview-index.html)  <span class="version">1.0.3</span>
* [UnifiedPush Java Client](aerogear-unifiedpush-java-client) <span class="version">1.1.0</span>
* [UnifiedPush Node.js Client](aerogear-unifiedpush-nodejs-client) <span class="version">0.13.0</span>

<h4>SimplePush</h4>

* [SimplePush Java Client](aerogear-simplepush-java-client)

<h4>Client Libs</h4>

* [Android Push](/docs/specs/aerogear-android-push/) <span class="version">2.0.0</span>
* [Push iOS](aerogear-ios-push) <span class="version">1.0.0</span>
* [Cordova Push](aerogear-cordova/Push.html)

---

<h2 class="section-header" id="security"><i class="fa fa-shield"></i> AeroGear<strong>Security</strong> Specifications</h2>

<h4 id="securityAuthentication">Authentication</h4>
* [Android Auth](/docs/specs/aerogear-android-auth/) <span class="version">2.0.0</span>
* [Android Authz](/docs/specs/aerogear-android-authz/) <span class="version">2.0.0</span>
* [iOS OAuth2](aerogear-ios-oauth2) <span class="version">0.2.0</span>
* [Cordova OAuth2](/docs/specs/aerogear-cordova/OAuth2.html)


<h4 id="securityOTP">One-Time Password</h4>
* Android OTP
* [iOS OTP](aerogear-otp-ios) <span class="version">1.0.0</span>
* [Cordova OTP](/docs/specs/aerogear-cordova/AeroGear.Totp.html)

<h4 id="securityCryptography">Cryptography</h4>
* [Crypto API Specification](aerogear-crypto)
* Android Crypto
* [iOS Crypto](aerogear-ios-crypto) <span class="version">0.2.3</span>
* [Cordova Crypto](/docs/specs/aerogear-cordova/AeroGear.Crypto.html)
* [JS Crypto](/docs/specs/aerogear-js/AeroGear.Crypto.html)

<h4 id="securityGeneral">General</h4>
* [AeroGear Android Security](/docs/specs/aerogear-android-security/) <span class="version">2.0.0</span>

---

<h2 class="section-header" id="sync"><i class="fa fa-refresh"></i> AeroGear<strong>Sync</strong> Specifications <sub><span class="label label-warning">Experimental</span></sub></h2>
* [Data Sync Specification](aerogear-data-sync)
* [Data Sync Message Format](aerogear-sync-data-format)

<h4 id="securityGeneral">Sync Server</h4>
* [Java Server API](aerogear-sync-server-java-api/org/jboss/aerogear/sync/server/ServerSyncEngine.html)
* [Java Client API](aerogear-sync-server-java-api/org/jboss/aerogear/sync/client/ClientSyncEngine.html)

<h4 id="securityGeneral">Proposals</h4>
* [Client API Proposals](aerogear-sync-client-api)


---

<h2 class="section-header" id="digger"><i><img src="/img/aerogeardigger_icon_32px_cropped.png"></i> AeroGear<strong>Digger</strong> Docs</h2>

<h4>Guides</h4>
* [Installation Guide](/docs/digger/installation)
* [Admin Guide](/docs/digger/admin)
* [Developer Guide](/docs/digger/developer)

<h4>Specs</h4>
* [Node client specs](/docs/specs/aerogear-digger-node-client)

---

<h5>...are you looking for more?</h5>
<p>
   <a href="/getstarted/guides" class="btn btn-primary"><i class="fa fa-book"></i> Guides! Learn more</a>
   <a href="/getstarted/demos" class="btn btn-primary"><i class="fa fa-cogs"></i> Demo Applications</a>
   <a href="/getstarted/downloads" class="btn btn-primary"><i class="fa fa-download"></i> Downloads and Snippets</a>
</p>
