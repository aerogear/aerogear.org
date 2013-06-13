--- 
layout: basic 
title: AeroGear Unified Push Server 
---

# AeroGear UnifiedPush Registration Client Spec (DRAFT 0.0.3)

This document describes the functionality of a client SDK that works with the [AeroGear UnifiedPush Server](http://aerogear.org/docs/specs/aerogear-server-push/).

## Motivation / Purpose

The [AeroGear UnifiedPush Server](http://aerogear.org/docs/specs/aerogear-server-push/) is accessible via HTTP. Instead of having to manually register a device (```MobileVariantInstance```) with the HTTP interface, a client library should be offered.

**Goal:** A client library to register a mobile application (```MobileVariantInstance```) with the UnifiedPush Server.

#### Background: Push Network Token

To receive native push notifications from a Push Network (e.g. APNs, GCM or SimplePush), the mobile device is identified with a unique ```device-token```, assigned by the actual Push Network. This ```device-token``` is passed, by the underlying Operating-System, to the mobile application. Details are different on each platform and  **not** part of this document.

The ```device-token``` needs to be registered with the _AeroGear UnifiedPush Server_, to indicate there is a new ```MobileVariantInstance``` for a ```MobileVariant```. More details about the server-side part of this can be found in the _AeroGear Unified Push Server_ [spec](http://aerogear.org/docs/specs/aerogear-server-push/).

## Functionality 

**WARNING:** _The focus of this specification is to describe the generic minimum and not any platform-specific requirements_ 

The client SDK offers the following features:

* Registration and Updating of a ```MobileVariantInstance``` 
* Unregistration of a ```Mobile Variant Instance``` (optional, due to platform specific restrictions)

### Registration and Updating of a Mobile Variant Instance

Everytime when a mobile application launches it receives the above mentioned ```device-token```, via a _platform-specific_ method (or callback). Since the Push Network (e.g. APNs or GCM) _may_ assign a **new** token to a device, it is _recommended_ to _always_ (re)register the ```device-token``` with the _AeroGear UnifiedPush Server_.

Besides the ```device-token``` the _AeroGear UnifiedPush Server_ is able to store some of the below device- or user-specific metadata:

* **deviceToken:** _Identifies the device/user-agent within its Push Network._
* **deviceType:** _The device type of the device or the user agent._
* **mobileOperatingSystem:** _The name of the underlying Operating System._
* **osVersion:** _The version of the used Operating System._
* **alias:** _ Application specific alias to identify users with the system. For instance an ```email address``` or a ```username```._
* **category:** _Used tp apply a "tag". Mainly usful for the SimplePush channel(s)._

Besides the slight chance that the ```device-token`` may change, some of the above metadata is more likely to change. Therefore another reason to always send this metadata to the _AeroGear UnifiedPush Server_.

#### Reachability

The client SDK needs to check if the device can establish a connection to the internet (PushNetwork and UnifiedPush Server). It should make use of the platform-specific APIs to check the reachablility of the services.

### Unregistration of client device information

_Optional_ method that helps to unregister the client device information with the [AeroGear Unified Push Server](http://aerogear.org/docs/specs/aerogear-server-push/). **Note:** _The method is optional, since not all supported Push Networks recommend having a client application actively performing an _unregister_. Apple for instance has a ```Feedback Service```, which the _AeroGear Unified Push Server_ needs to freequently query for inactive tokens. Tokens, with Apple, are _inactive_ when the user:
* Disables Push (Settings)
* Deinstalls the app

#### Reachability

The client SDK needs to check if the device can establish a connection to the internet (PushNetwork and UnifiedPush Server). It should make use of the platform-specific APIs to check the reachablility of the services.

## Platform specific details 

Every client platform has it's own base APIs, to receive Push Message from it's Push Network. The AeroGear client SDK _may_ offer utilities to even more simplify this process.
_For example: In Android a custom ```Intent``` is required, therefore it would make sense if the "AeroGear Android Push Client Library" offers a convenience implementation for this class._
