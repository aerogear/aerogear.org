--- 
layout: basic 
title: AeroGear UnifiedPush Message Format 
---

# AeroGear Unified Push Message Format

The Unified Push Server allows two different ways to send message to the native Push API, of the supported devices:

* Broadcast
  * to all ```Variants``` and their ```Installations```
* Selective Send
  * to some ```Installations```, based on given criterias

## Broadcast

    curl -u "{PushApplicationID}:{MasterSecret}"
       -v -H "Accept: application/json" -H "Content-type: application/json" 
       -X POST
       -d '{
             "key":"value",
             "alert":"HELLO!",
             "sound":"default",
             "badge":7,
             "simple-push":"version=123"
           }'

    http://localhost:8080/ag-push/rest/sender/broadcast 


### Message Format

The message format is very simple: A generic JSON map is used to sent messages to Android and iOS devices. The applications on the devices will receive the JSON map and are responsible for performing a lookup to read values of the given keys.

#### SimplePush special keys

Every AeroGear-SimplePush application can subscribe to a ```broadcast``` channel. If, for ```broadcast```, the ```simple-push``` key is provided, the version is extracted and send to ALL "connected" broadcast channels, of the given SimplePush variant(s). **NOTE:** On all other platforms, the ```simple-push``` key will be ignored. Also, for SimplePush, all **OTHER** keys are ignored (since they have no meaning on SimplePush).

#### iOS special keys

If the JSON map contains one of the following reserved keywords, Apple specific hooks will be invoked on the device:
* ```alert``` (triggers a dialog, displaying the value - no iOS API needs to be invoked by the app developer)
* ```sound``` (plays a given sound  - no iOS API needs to be invoked by the app developer)
* ```badge``` (sets the value of the badge icon - no iOS API needs to be invoked by the app developer)

#### Android special keys

None! The JSON map is submitted as it is, directly to the device. There are no Android specific keywords.

## Selective Send

A message is sent to a restricted number of ```Installations```, based on a given criteria. The following example shows the corresponding HTTP interface:

    curl  -u "{PushApplicationID}:{MasterSecret}"
       -v -H "Accept: application/json" -H "Content-type: application/json" 
       -X POST
       -d '{
           "alias" : ["user@account.com", "someone@aerogear.org", ....],
           "deviceType" : ["iPad", "AndroidTablet"],
           "message": {
             "alert":"HELLO!",
             "sound":"default",
             "badge":7,
             "simple-push":"version=123",
             "someKey":"some value",
             "anotherCustomKey":"some other value"
           },
           "simple-push": {
             "SomeCategory":"version=123",
             "anotherCategory":"version=456"
           }
         }'

    http://localhost:8080/ag-push/rest/sender/selected

### Message Format

Besides the actual payload the API accepts a few _classifiers_ to select a subset of registered devices.

#### Query component

Currently the Server will support the following query criteria:

* ```alias```: A list of one or more _identifiers_ (such as ```email``` or ```username```) to send messages to *ALL* devices of the user(s). The ```alias``` needs to be stored, when the device is registering itself with the server.
* ```deviceType```: A list of raw device types that should receive the message (e.g. Coupon only for iPad and AndroidTablets). The ```deviceType``` needs to be stored when the device is registering itself with the server. _**NOTE:**_ For SimplePush, the ```deviceType``` is **ONLY** ```web```. No specifics on the actual device are used due to general limitations on "user agent sniffing".

#### Message Payload

The message format is very simple: A generic JSON map is used to send messages to Android and iOS devices. The applications on the devices will receive the JSON map and are responsible for performing a lookup to read values of the given keys. Like above, iOS specific keywords are honored.


##### SimplePush

For SimplePush an extra ```simple-push``` object is provided. This key is only used for SimplePush variants (similar to broadcast case). However, _HERE_ we use an object to send (selective) different versions to different channels.
