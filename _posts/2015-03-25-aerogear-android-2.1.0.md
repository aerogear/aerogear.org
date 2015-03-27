---
layout: news
section: news
title: AeroGear Android 2.1 has been released
author: secondsun
module: sync
platform: android
releases: 2.1.0
---

We are pleased to announce the release of AeroGear Android 2.1.  This release includes the Sync alpha libraries, Pipe and GCM fixes, and minor updates to our demos.  


## What's New

### Sync  Alpha

AeroGear has released the first alpha of our data sync technology.  This includes the [AeroGear Sync Server](http://github.com/aerogear/aerogear-sync-server) and libraries for [iOS](https://github.com/aerogear/aerogear-ios-sync), [JavaScript](https://github.com/aerogear/aerogear-js), and of course [Android](https://github.com/aerogear/aerogear-android-sync/).  This technology allows for cross platform data synchronization as seen here : 

<iframe src="https://player.vimeo.com/video/121332828" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="https://vimeo.com/121332828">AeroGear SyncDemo</a> from <a href="https://vimeo.com/user3167819">Christos Vasilakis</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

If you followed the development of the Android library you will remember that we originally tried to use Google's XMPP services as the medium for data sync.  Because of technical limitations we dropped this idea and moved to wrapping the Netty client provided with AeroGear Sync Server in an Android service instead.  

To activate the service you need to add it to you AndroidManifest.xml file.  You will also need to provide properties for `serverHost`, `serverPort`, and `serverPath`.  These properties are defined by where you have deployed the sync server.  Here is an example connecting to the sync server running on the host of an emulated Android device:  

```xml
<service android:name="org.jboss.aerogear.android.sync.SyncService">
  <meta-data
  android:name="serverHost"
  android:value="10.0.2.2" />
  <meta-data
  android:name="serverPort"
  android:value="7777" />
  <meta-data
  android:name="serverPath"
  android:value="/sync" />
</service>
```

Any Activty you want to receive sync events needs to implement the `SyncServerConnectionListener` interface, bind itself to the `SyncService` instance, and then subscribe to events on connections.

Binding and subscribing example : 

```java
@Override
protected void onStart() {
 super.onStart();
 serviceConnection = new ServiceConnection() {
 
  @Override
  public void onServiceConnected(ComponentName name, IBinder service) {
   final SyncService syncService = ((SyncService.SyncServiceBinder) service).getService();
   SyncActivity.this.service = syncService;
   syncService.subscribe(SyncActivity.this);
  }
  
  @Override
  public void onServiceDisconnected(ComponentName name) {
   finish();
  }
 };
}

@Override
protected void onResume() {
 super.onResume();
 Intent syncServiceIntent = new Intent(this, SyncService.class);
 bindService(syncServiceIntent, serviceConnection, Context.BIND_AUTO_CREATE);
}
```


`SyncServerConnectionListener` implementation Example :  

```java
@Override
//Called when the SyncService instance is connected to the Sync server AND the Activity is subscribe to the service after binding.
public void onConnected() {
 /*clientId is a unique identifier which identifies the device connection*/
 clientId = getSyncService().getClientId();
 
 /*a client document is a document the sync APIs know how to synchronize and is managed by the sync libraries*/ 
 final ClientDocument<JsonNode> clientDocument = clientDoc(documentId, clientId, JsonUtil.toJsonNode(content));
 
 /*adding a document to the service causes it to send and receive updates*/
 getSyncService().addDocument(clientDocument);
}

@Override
//Called when the document is updated by an external source
public void patched(final ClientDocument data) {
 runOnUiThread(new Runnable() {
  @Override
  public void run() {
   final ClientDocument<JsonNode> document = (ClientDocument<JsonNode>) data;
   final Info updates = JsonUtil.fromJsonNode(document.content());
   //handle your updates here.
  }
 });
}
```

For a full implementation demo look at our [cookbook](https://github.com/aerogear/aerogear-android-cookbook/blob/master/SyncDemo/).

## Minor Changes

### Pipe improvements

After nearly two years we have implemented [AGDROID-7](https://issues.jboss.org/browse/AGDROID-7) by adding `Pipe.read(String id, Callback<T> callback)`.  Now fetching by id is as simple as the following:  

```java

private void retrieveData() {
  LoaderPipe<Data> pipe = application.getPipe(this);
  pipe.reset();
  pipe.read(String.valueOf(15), new MyCallback());
}

```

### GCM Push Configuration

We've added some extra validation to the GCM Push Registrar.  Now if you leave off properties such as variantId the library will throw an exception when you try to build the PushRegistrar as opposed to the registration method failing with an error callback.

### GCM Unregistration

Now the library will check to see if you have a registered client before it attempts unregistration.  Previously it would always make a call to the Push Server which would fail with a HTTP 404 error if you were not registered.  Now the method immediately fails without a network call.

### Demo Improvements

We've added a few demos to the official cookbook.
* [Sync Demo](https://github.com/aerogear/aerogear-android-cookbook/tree/master/SyncDemo) This is the demo for our sync libraries.
* [Two Factor](https://github.com/aerogear/aerogear-android-cookbook/tree/master/Two-Factor) This is an example of a Two-Factor One Time Password app using AeroGear.
* [Password Manager](https://github.com/aerogear/aerogear-android-cookbook/tree/master/PasswordManager) This demonstrates using encryption to secure a password store behind a passcode.  

We've also fixed some bugs in the Shoot and Share app as well as the AGReddit app.

## What's Next

For 2.2 and the future we are looking at improvements to our authz libraries as well as better offline resource management.  As per usual you can watch our [JIRA](https://jira.jboss.org/browse/AGDROID)

## About AeroGear

If you would like to learn more about AeroGear's Android libraries a great place to start is our [Android landing page](https://aerogear.org/android/).  If you would like to participate in development, have questions, or want to chat with us our [community section](https://aerogear.org/community/#contact) has all of our contact information.

##Changelog

* [AGDROID-362](https://issues.jboss.org/browse//browse/AGDROID-362) Migrate AeroDoc example to Gradle and move to cookbook repo  
* [AGDROID-156](https://issues.jboss.org/browse//browse/AGDROID-156) Update aerogear-crypto-android-demo and move to cookbook repo  
* [AGDROID-343](https://issues.jboss.org/browse//browse/AGDROID-343) AeroGearGCMPushConfiguration#buildRegistrar needs more validation  
* [AGDROID-361](https://issues.jboss.org/browse//browse/AGDROID-361) AGReddit should say Bad Password when you fail at logging in.  
* [AGDROID-7](https://issues.jboss.org/browse//browse/AGDROID-7) add pipe functionality to retrieve data by ID  
* [AGDROID-312](https://issues.jboss.org/browse//browse/AGDROID-312) Implement Android Client Sync Engine  
* [AGDROID-369](https://issues.jboss.org/browse//browse/AGDROID-369) Sync Android Demo app  
* [AGDROID-313](https://issues.jboss.org/browse//browse/AGDROID-313) Implement Android Sync Client  
* [AGDROID-368](https://issues.jboss.org/browse//browse/AGDROID-368) unregister fails with server returned the error code 405 android  
* [AGDROID-385](https://issues.jboss.org/browse//browse/AGDROID-385) Update AeroGear Sync README  
* [AGDROID-377](https://issues.jboss.org/browse//browse/AGDROID-377) Move DiffSync client into a android.app.Service  
* [AGDROID-386](https://issues.jboss.org/browse//browse/AGDROID-386) Deprecate and remove client-xmpp  
* [AGDROID-370](https://issues.jboss.org/browse//browse/AGDROID-370) XMPP Client NPE @ DiffSyncClientHandler.java:45  
* [AGDROID-364](https://issues.jboss.org/browse//browse/AGDROID-364) Package XMPP Sync Client to not include duplicate files  
* [AGDROID-363](https://issues.jboss.org/browse//browse/AGDROID-363) Refactor XMPP Sync Client to get below the 65k method limit  
* [AGDROID-371](https://issues.jboss.org/browse//browse/AGDROID-371) XMPP sync client should support json patch  
* [AGDROID-367](https://issues.jboss.org/browse//browse/AGDROID-367) Shoot-n-Share 401 error (invalid_client) on Google Drive upload   
* [AGDROID-366](https://issues.jboss.org/browse//browse/AGDROID-366) Shoot-n-Share does not offer keyboard for Keycloak redirected login screen  
* [AGDROID-365](https://issues.jboss.org/browse//browse/AGDROID-365) XMPP Sync Client does not handle multiple documents correctly  

