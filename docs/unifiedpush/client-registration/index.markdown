---
layout: basic
title: AeroGear UnifiedPush Server - Client Registration
---

# Client registration with the UnifiedPush Server

This document describes the functionality of a client SDK that works with the AeroGear UnifiedPush Server.

## Motivation / Purpose

The [AeroGear UnifiedPush Server](https://github.com/aerogear/aerogear-unifiedpush-server) is accessible via HTTP. Instead of having to manually register a device (```Installation```) with the HTTP interface, a client library should be offered.

**Goal:** A client library to register a mobile application (```Installation```) with the UnifiedPush Server.

#### Background: Push Network Token

To receive native push notifications from a Push Network (e.g. APNs, GCM or SimplePush), the mobile device is identified with a unique ```device-token```, assigned by the actual Push Network. This ```device-token``` is passed, by the underlying Operating-System, to the mobile application. Details are different on each platform and  **not** part of this document.

The ```device-token``` needs to be registered with the _AeroGear UnifiedPush Server_, to indicate there is a new ```Installation``` for a ```Variant```.

## Functionality

**WARNING:** _The focus of this specification is to describe the generic minimum and not any platform-specific requirements_

The client SDK offers the following features:

* Registration and Updating of a ```Installation```
* Unregistration of a ```Installation``` (optional, due to platform specific restrictions)

### Registration and Updating of a Installation

Everytime when a mobile application launches it receives the above mentioned ```device-token```, via a _platform-specific_ method (or callback). Since the Push Network (e.g. APNs or GCM) _may_ assign a **new** token to a device, it is _recommended_ to _always_ (re)register the ```device-token``` with the _AeroGear UnifiedPush Server_.

The required metadata for an ```Installation```:

* **deviceToken:** _Identifies the device/user-agent within its Push Network._
* **variantID:** _The ID of the variant, where the client belongs to_
* **variantSecret:** _Password of the actual variant_

The _AeroGear UnifiedPush Server_ is able to store some user-specific metadata as well:

* **deviceType:** _The device type of the device or the user agent._
* **operatingSystem:** _The name of the underlying Operating System._
* **osVersion:** _The version of the used Operating System._
* **alias:** _Application specific alias to identify users with the system. For instance an ```email address``` or a ```username```._
* **categories:** _Used to apply one or more "tags"._
* **simplePushEndpoint:** _SimplePush specific Endpoint URL, which is used to send updates to the SimplePush server._

#### Reachability

Internally, the client SDK needs to check if the device can establish a connection to the internet (PushNetwork and UnifiedPush Server). It should make use of the platform-specific APIs to check the reachability of the services.

### Unregistration of client device information

_Optional_ method that helps to unregister the client device information with the Unified Push Server.

**Note:** The method is optional, since not all supported Push Networks recommend having a client application actively performing an _unregister_. Apple for instance has a ```Feedback Service```, which the _AeroGear Unified Push Server_ needs to frequently query for inactive tokens. Tokens, with Apple, are _inactive_ when the user:

* Disables Push (Settings)
* Deinstalls the app

#### Reachability

Internally, the client SDK needs to check if the device can establish a connection to the internet (PushNetwork and UnifiedPush Server). It should make use of the platform-specific APIs to check the reachability of the services.

## Platform specific details

Every client platform has it's own base APIs, to receive Push Message from it's Push Network. The AeroGear client SDK _may_ offer utilities to even more simplify this process.
_For example: In Android a custom ```Intent``` is required, therefore it would make sense if the "AeroGear Android Push Client Library" offers a convenience implementation for this class._
