--- 
layout: basic 
title: AeroGear UnifiedPush Message Format 
---

# AeroGear Unified Push Message Format (Draft 0.0.1)

The Unified Push Server allows two different ways to send message to the native Push API, of the supported devices:

* broadcast
  * to all ```MobileVariants``` and their ```MobileVariant Instances``` (devices) 
  * to one specific ```MobileVariant``` and its ```MobileVariant Instances``` (devices) 
* selective Send

## Broadcast

    curl -v -H "Accept: application/json" -H "Content-type: application/json" 
       -H "ag-push-application: {PushApplicationID}
       -H "ag-mobile-variant: {MobileVariantID}
       -X POST
       -d '{"key":"value", "alert":"HELLO!", "sound":"default", "badge":7,
           "simple-push":"version=123"}'

    http://localhost:8080/ag-push/rest/sender/broadcast 


If the ```ag-push-application``` header is used, a message is sent to a ```PushApplication``` and **ALL** MobileVariantInstances will receive the message.

If the ```ag-mobile-variant``` header is used, a message is sent to a particular ```MobileVariant``` and **ALL** of its MobileVariantInstances will receive the message.



### Message Format

The message format is very simple: A generic JSON map is used to sent messages to Android and iOS devices. The applications on the devices will receive the JSON map and are responsible for performing a lookup to read values of the given keys.

#### SimplePush special keys

Every AeroGear-SimplePush application can subscribe to a ```broadcast``` channel. If, on the above ```broadcast``` endpoint, you are providing the ```simple-push``` key, the version (that's what SimplePush is really about), is extracted and send to ALL "connected" broadcast channels, of the given SimplePush variant(s). **NOTE:** On all other platforms, the ```simple-push``` key will be simply :-) ignored. Also, for SimplePush, all **OTHER** keys are ignored (since that does not make sense for SP).

#### iOS special keys

If the JSON map contains one of the following reserved keywords, Apple specific hooks will be invoked on the device:
* ```alert``` (triggers a dialog, displaying the value - no iOS API needs to be invoked by the app developer)
* ```sound``` (plays a given sound  - no iOS API needs to be invoked by the app developer)
* ```badge``` (sets the value of the badge icon - no iOS API needs to be invoked by the app developer)

#### Android special keys

None! The JSON map is submitted as it is, directly to the device. There are no Android specific keywords.

## Selective Send

A message is sent to a restricted number of ```MobileVariantInstances```, based on a given criteria. The following example shows the corresponding HTTP interface:

    curl -v -H "Accept: application/json" -H "Content-type: application/json" 
       -X POST

       -d '{
          "alias" : ["user@account.com", "jay@redhat.org", ....],
      
          "deviceType" : ["iPad", "AndroidTablet"],
      
          "message": {"key":"value", "key2":"other value", "alert":"HELLO!",
            "simple-push": { "SomeCategory":"version=123", "anotherCategory":"version=456"}
    	  }
       }'

    http://localhost:8080/ag-push/rest/sender/selected/{PushApplicationID} 

### Message Format

Besides the actual payload the API accepts a few _classifiers_ to select a subset of registered devices.

#### Query component

Currently the Server will support the following query criteria:

* ```alias```: A list of one or more _identifiers_ (such as ```email``` or ```username```) to send messages to *ALL* devices of the user(s). The ```alias``` needs to be stored, when the device is registering itself with the server. See here for [details](https://github.com/matzew/ag-client-push-sdk/blob/master/push-sdk/AGClientDeviceInformation.h#L48-L52)
* ```deviceType```: A list of raw device types that should receive the message (e.g. Coupon only for iPad and AndroidTablets). The ```deviceType``` needs to be stored when the device is registering itself with the server. See here for [details](https://github.com/matzew/ag-client-push-sdk/blob/master/push-sdk/AGClientDeviceInformation.h#L43-L46). _**NOTE:**_ For SimplePush, the ```deviceType``` is **ONLY** ```web```. No specifics on the actual device are used due to general limitations on "user agent sniffing".

#### Message Payload

The message format is very simple: A generic JSON map is used to send messages to Android and iOS devices. The applications on the devices will receive the JSON map and are responsible for performing a lookup to read values of the given keys. Like above, iOS specific keywords are honored.


##### SimplePush

For SimplePush an extra ```simple-push``` object is provided. This key is only used for SimplePush variants (similar to broadcast case). However _HERE_ we use an object to send (selective) different versions to different channels.
