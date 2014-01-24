--- 
layout: basic 
title: AeroGear UnifiedPush Message Format 
---

# AeroGear UnifiedPush Message Format

The UnifiedPush Server allows sending messages to the native and non-native Push APIs:

## Sender

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
             "someKey":"some value",
             "anotherCustomKey":"some other value"
           },
           "simple-push": "version=123"
         }'

    https://SERVER:PORT/CONTEXT/rest/sender

### Message Format
The message format is very simple: A generic JSON map is used to sent messages to Android and iOS devices. 

* ```ttl``` Specifies in seconds the ```time-to-live``` for the submitted notification. This value is supported by APNs and GCM. If a device is offline for a longer time than specified by the ```ttl``` value, the supported Push Networks may not deliver the notification.



#### Message Object

The applications on the devices will receive the JSON map and are responsible for performing a lookup to read values 
of the given keys.

##### iOS special keys

If the JSON map contains one of the following reserved keywords, Apple specific hooks will be invoked on the device:

* ```alert``` (triggers a dialog, displaying the value - no iOS API needs to be invoked by the app developer)
* ```sound``` (plays a given sound  - no iOS API needs to be invoked by the app developer)
* ```badge``` (sets the value of the badge icon - no iOS API needs to be invoked by the app developer)

##### Android special keys

None! The JSON map is submitted as it is, directly to the device. There are no Android specific keywords.


#### SimplePush Object

For SimplePush an extra ```simple-push``` object is provided. This key is only used for SimplePush variants. The version is submitted to all connected client, that are subscribed on their matching channels.

#### Query component

Currently the Server will support the following query criteria:

* ```variants```: A list of one or more _mobile variant ID's_ to identify a particular PushApplication variant (e.g. HR Android, HR iPad).
* ```alias```: A list of one or more _identifiers_ (such as ```email``` or ```username```) to send messages to *ALL* devices of the user(s). The ```alias``` needs to be stored, when the device is registering itself with the server.
* ```categories```: Helps to _tag_ the current client with multiple categories. Gives a semantic meaning to a registered ```Installation```.
* ```deviceType```: A list of raw device types that should receive the message (e.g. Coupon only for iPad and AndroidTablets). The ```deviceType``` needs to be stored when the device is registering itself with the server.

_**NOTE:**_ All these query criterias are optionnal. If no criterias are passed it will act as a  _broadcast_ send, where _all_ clients are notified. 
