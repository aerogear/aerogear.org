--- 
layout: basic 
title: AeroGear UnifiedPush Server 
---

# AeroGear UnifiedPush Server

The _AeroGear UnifiedPush Server_ is a server that allows sending native push messages to different mobile operation systems. The initial version of the server supports [Apple's APNs](http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ApplePushService.html#//apple_ref/doc/uid/TP40008194-CH100-SW9), [Google Cloud Messaging](http://developer.android.com/google/gcm/index.html) and [Mozilla's Simple Push](https://wiki.mozilla.org/WebAPI/SimplePush).

## Motivation / Purpose
The _AeroGear UnifiedPush Server_ offers a _Notification Service API_ to different backend applications. This gives a server the ability to send _Push Notifications_ to mobile applications. The Notification Service API is a signalling mechanism, like Apple APNs, Google Cloud Messaging or Mozilla SimplePush for sending messages. It's not suitable to be used as a data carrying system (e.g. use in a chat application).

### Some Usage Scenarios
* MyWarehouseInc-backend can send "notification messages" to different "customer" groups (e.g. discounts for only iOS (or only Android) users).
* MyInsuranceCorp-backend can send "notification messages" to different variants of its mobile Applications:
  * App for the Customers
  * App for the employed Sales Agents
* Publishing Company:
  * MyPublishing-Company-backend sends _update_ "notification messages" to all of its apps (free and premium - regardless of the mobile OS).
  * The arrival of "advanced content" is only notified to the paying customers (e.g. those that run the _premium_ app).
* A company has different backends (small/simple apps for different tasks) - and these different backends could be able to reach all (or some) of the company's mobile apps.


**Goal**: To make any (JBoss/AeroGear powered) mobile application, that is backed by JBoss technology (e.g. admin console, Errai, drools, etc.), work easily with mobile push messages. For a JBoss "backend application" it should be as simple as possible to send messages to its different mobile clients.

## Definitions

Before we get into details, it's important that we have a good lexicon.

#### Push Application

A logical construct that represents an overall mobile application (e.g. ```Mobile HR```).

#### Variant

A variant of the _Push Application_. There can be multiple variants for a _Push Application_ (e.g. ```HR Android```, ```HR iPad```, ```HR iPhone free```,  ```HR iPhone premium``` or ```HR Mobile Web```). A _Variant_ contains platform specific properties, such as a _Google API key_ (```Android```) or a PushNetwork URL (```SimplePush```).

#### Installation

Represents an actual installation on a mobile device / client (e.g. _User1 connected via MobileWeb_ or _User2 runs **HR iPhone premium** on his phone_)

#### (Push) Notification Message

A simple message to be send to a mobile application, to notify it of a data change.

#### Sender API

Is a component that sends _Push Notification Messages_ to a ```Push Application``` or some of its different ```Variants```. 

#### Developer

A _Developer_ is in charge of enabling Push Notifications for his different backend systems. For that he has to create a ```Push Application``` and one or more ```Variants``` on the _AeroGear UnifiedPush Server_.

A _Developer_ will use the _Sender API_ to send "notification messages" to different ```Installations```.

#### User

A user of an AeroGear ```Installation```, which may consume notification messages.


## Overview

The _AeroGear UnifiedPush Server_ contains three different components:

* Registration: _Registry for ```Push Applications```, ```Variants``` and  ```Installations```_
* Storage: _A database, storing the registered applications and installations_
* Sender: _Receives messages and sends them to different ```Installations```_

The graphic below gives a little overview:

![components](./aerogear_unified_push_server.png)

## Functionality 

### Registration 

Three different registration types are provided by the _AeroGear UnifiedPush Server_.

#### Push Application Registration

Adds a logical construct, that represents an overall mobile application (e.g. Mobile HR). The _Push Application_ contains the following properties:

* Name
* Description
* A collection of ```Variant```s

The server offers an HTTP interfaces to apply a _Push Application_ registration:

    curl -3 -v -b cookies.txt -c cookies.txt
         -v -H "Accept: application/json" -H "Content-type: application/json"
         -X POST
         -d '{"name" : "MyApp", "description" :  "awesome app" }'

    https://SERVER:PORT/context/rest/applications

_The response returns a JSON map, representing the Push Application._

#### Variant Registration

Adds a _variant_ for an **existing** _Push Application_. There can be multiple variants for a _Push Application_ (e.g. HR Android, HR iPad, HR iPhone free, HR iPhone premium or HR Mobile Web).

The server supports the following variant types:

* iOS
* Android
* SimplePush

##### iOS Variant

An iOS variant represents a logical construct for one iOS application (e.g. ```HR for iPhone``` _or_ ```HR for iPad``` ). The iOS variant requires some APNs specific values:

* APNs Push Certificate file
* Passphrase

The server offers an HTTP interfaces to register an _iOS variant_:

    curl -3 -v -b cookies.txt -c cookies.txt 
         -i -H "Accept: application/json" -H "Content-type: multipart/form-data" 
         -F "certificate=@/path/to/the/cert.p12"
         -F "passphrase=TopSecret"
         -F "description=An iPhone variant"
         -F "name=HR for iPhone"
         -X POST

    https://SERVER:PORT/context/rest/applications/{pushApplicationID}/iOS

**NOTE:** The above is a _multipart/form-data_, since it is required to upload the "Apple Push certificate"!

_The response returns a JSON map, representing the iOS variant._

##### Android Variant

An Android variant represents a logical construct for one Android application (e.g. ```HR for Android```). The Android variant requires some Google specific values:

* Google API Key
* Google Project Number / Sender ID (optional)

The server offers an HTTP interfaces to register an _Android variant_:

    curl -3 -v -H "Accept: application/json" -H "Content-type: application/json"
     -X POST
     -d '{"googleKey" : "My Google API Key","projectNumber":"My Project Number / Sender ID", "name" : "HR for Android", "description" :  "Android variant" }'
  
     https://SERVER:PORT/context/rest/applications/{pushApplicationID}/android

_The response returns a JSON map, representing the Android variant._

##### SimplePush Variant

An SimplePush variant represents a logical construct for one SimplePush application (e.g. ```HR mobile Web```). The SimplePush variant requires some _Simple Push Network_ specific values:

* URL of the PushNetwork server

The server offers an HTTP interfaces to register an _SimplePush variant_:

    curl -3 -v -H "Accept: application/json" -H "Content-type: application/json"
      -X POST
      -d '{"name" : "HR mobile Web", "description" :  "SimplePush variant" }'

      https://SERVER:PORT/context/rest/applications/{pushApplicationID}/simplePush 

_The response returns a JSON map, representing the SimplePush variant._


#### Installation Registration

**Supported by Client SDKs:** Adds an _installation_ to an existing _variant_ (e.g. _User1 runs HR-iPad on his device_). It is possible that one user can have multiple devices. An _installation_ contains the following properties:

###### Required Data

- **deviceToken**

_Identifies the device/user-agent within its Push Network._

- **variantID**

_The ID of the variant, where the client belongs to._

- **variantSecret**

_Password of the actual variant._

###### Optional Data

- **deviceType:**

_The device type of the device or the user agent._

- **operatingSystem:**

_The name of the underlying Operating System._

- **osVersion:**

_The version of the used Operating System._

- **alias:**

_Application specific alias to identify users with the system. For instance an ```email address``` or a ```username```._

- **categories:**

_Used to apply one or more "tags" for the registered ```Installation```._

- **simplePushEndpoint:**

_SimplePush server endpoint which receives update requests for one SimplePush client/channel._


##### REST APIs

The server offers an HTTP interfaces to register an _installation_:

    curl -3 -u "{MobileVariantID}:{secret}"
        -v -H "Accept: application/json" -H "Content-type: application/json" 
        -X POST
        -d '{
          "deviceToken" : "someTokenString",
          "deviceType" : "iPad",
          "operatingSystem" : "iOS",
          "osVersion" : "6.1.2",
          "alias" : "someUsername or email adress...",
          "categories" : ["football", "sport"],
          "simplePushEndpoint" : "http://server.com/someEndpoint"
         }'

    https://SERVER:PORT/context/rest/registry/device

**NOTE**: Platform specific Client SDKs are provided to submit the require data to the _AeroGear UnifiedPush Server_.

### Sender

The RESTful APIs for sending Push Notifications to different Mobile Push Networks:

#### RESTful Sender

Sends a push message to a selected list of devices/clients, or all, based on different query criterias:

    curl -3 -u "{PushApplicationID}:{MasterSecret}"
         -v -H "Accept: application/json" -H "Content-type: application/json" 
         -X POST
       -d '{
           "variants" : ["c3f0a94f-48de-4b77-a08e-68114460857e", "444939cd-ae63-4ce1-96a4-de74b77e3737" ....],
           "alias" : ["user@account.com", "someone@aerogear.org", ....],
           "categories" : ["someCategory", "otherCategory"],
           "deviceType" : ["iPad", "AndroidTablet"],
           "ttl" : 3600,
           "message": {
               "alert":"HELLO!",
               "sound":"default",
               "badge":7,
               "content-available" : true,
               "someKey":"some value",
               "anotherCustomKey":"some other value"
           },
           "simple-push": "version=123"
        }'

    https://SERVER:PORT/context/rest/sender

The ```variants``` is a filter for notifying certain variants (e.g. HR Android, HR iPad etc.) of the PushApplication with the respective IDs. The ```alias``` value is used to identify the desired users, while the ```categories``` is more a semantical tag, of a registered ```Installation```. The ```deviceType``` is a filter for notifying only users, running a certain device. The ```ttl``` is supported on GCM/APNs to specify how long the supported networks should try to deliver the notification. The payload (```message``` and ```simple-push```) are standard JSON objects. If platform specific key words (e.g. alert for APNs) are used, they are honored for the specific platform. This transformation is done by the _AeroGear UnifiedPush Server_.

## Use Cases

Below are the BASIC use-cases, that the _AeroGear UnifiedPush Server_ needs to _initially_ support. 

* Enroll ```Developer```
* Remove ```Developer```
* Developer can register a ```Push Application```
  * Developer can add a ```Variant``` for different operation systems
  * Developer can remove a ```Variant```
* Developer can remove ```Push Application```
* User registers his ```Installation```
* User unregisters his ```Installation``` (e.g. app got deinstalled, user deleted etc)
* User receives _Push Notification Messages_ (handled by the native OS, once accepted to receive messages) 
* Developer send _Push Notification Messages_
* Developer can disable Push Notifications to selected ```Installation```s.

### Enroll

##### Developer

The **Developer** role is always registered with the _AeroGear UnifiedPush Server_ and a username/password combination is required.

##### User

Not all mobile applications define the concept of a registered user (e.g. Sport Broadcast apps), but others do (e.g. Twitter). The ```User``` is never registered with the _AeroGear UnifiedPush Server_. The ```User``` lives in the ```Business Database```. In cases where the mobile app requires a ```User```, it is highly recommend to register an _alias_ with the ```Installation```.

### Remove

##### Developer

It should be possible to remove ```Developers``` from the Server.

##### User

It should be possible to remove a ```Installation```, so that it can no longer receive _Push Notification Messages_.


### Register Push Applications

A ```Developer``` can register multiple ```Push Applications```. Each ```Push Application``` can have several ```Variants```.

#### Add Variant

A ```Developer``` can add a ```Variant``` to an existing ```Push Application```.

### Remove Push Application

A ```Developer``` should be able to remove a ```Push Application``` (including its ```Variant```).

### Remove Variant

A ```Developer``` should be able to remove a ```Variant```, of an existing ```Push Application```.

### Installation Registration

The mobile application needs to send his ```device-token``` (and some more metadata) to the _AeroGear UnifiedPush Server_, in order to be able to receive Push Notification Messages.

### Remove Installation

#### uninstall
If an app gets uninstalled, the phone is no longer able to receive push messages. Therefore inactive ```Installation``` should be removed, on the server. However... there is no harm if invalid keys are used, on the server, when trying to send push messages. They are ignored by the actual Push Networks.

#### access removed
Admin can disable push notifications for a specific ```Installation```.

### Receives Push Notification Messages

Every installed app, is able to receive Push Notification Messages through the APIs, offered by the platforms (iOS, Android, SimplePush).

_**Note:** On iOS the user as to agree to receive push messages_

### Sending Push Notification Messages

#### Sender
The _AeroGear UnifiedPush Server_ acts as a broker to deliver _Push Notification Messages_ to several ```Installations```. A ```developer``` can send _Push Notification Messages_ to a specific ```Installations```, using query criterias, such as ```alias``` or ```deviceType```, or all (aka _broadcast_) when no criteria is provided.

### API access

#### PushApplications and Variants

The AeroGear Security Module is used to secure the endpoints for:

* Working with PushApplications
* Working with Variants

#### Installation Registration API

HTTP Basic is used to secure the endpoint. Credentials: ```variantID:variantSecret```

#### Sender API

HTTP Basic is used to secure the endpoint. Credentials: ```pushApplicationID:masterSecret```


### Client SDK / API

The Client SDKs for ```Installation Registration``` are tracked [here](http://aerogear.org/docs/specs/aerogear-client-push/)