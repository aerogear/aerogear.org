---
layout: post
title: AeroGear UnifiedPush Message Format - Unstable
section: docs
toc_generate: true
---

The UnifiedPush Server allows sending messages to the native and non-native Push APIs. <span class="label label-warning">Development version</span>

### Links

* [UnifiedPush Message Format - 1.0.x](../push-message-format-1-0/)
* [Windows message format](./windows-document-format/)


## Sender

    curl -u "{PushApplicationID}:{MasterSecret}"
       -v -H "Accept: application/json" -H "Content-type: application/json" 
       -X POST
       -d '{
           "criteria": {
             "variants" : ["c3f0a94f-48de-4b77-a08e-68114460857e", "444939cd-ae63-4ce1-96a4-de74b77e3737" ....],
             "alias" : ["user@account.com", "someone@aerogear.org", ....],
             "categories" : ["someCategory", "otherCategory"],
             "deviceType" : ["iPad", "AndroidTablet"]
           },
           "message": {
             "alert":"HELLO!",
             "sound":"default",
             "badge":7,
             "content-available" : true,
             "action-category" : "some_category",
             "simple-push": "version=123",
             "user-data": {
                "someKey":"some value",
                "anotherCustomKey":"some other value"
             },
             "windows": {                                                
                "type": "tile",                                         
                "duration": "short",                                    
                "badge": "alert",                                       
                "tileType": "TileWideBlockAndText01",                   
                "images": ["Assets/test.jpg", "Assets/background.png"], 
                "textFields": ["foreground text"]                       
              },                                                           
           },
           "config": {
             "ttl" : 3600,
           }
         }'

    https://SERVER:PORT/CONTEXT/rest/sender

### Message Format
The message format is very simple: A generic JSON map is used to sent messages to Android, iOS and Windows devices. 

* ```ttl``` Specifies in seconds the ```time-to-live``` for the submitted notification. This value is supported by APNs and GCM. If a device is offline for a longer time than specified by the ```ttl``` value, the supported Push Networks may not deliver the notification.

* ```content-available``` is an iOS specific argument to mark the payload as 'content-available'. The feature is needed when sending notifications to Newsstand applications and submitting silent iOS notifications (iOS7)



### Message Object

The applications on the devices will receive the JSON map and are responsible for performing a lookup to read values 
of the given keys.

#### iOS special keys

If the JSON map contains one of the following reserved keywords, Apple specific hooks will be invoked on the device:

* ```alert``` (triggers a dialog, displaying the value - no iOS API needs to be invoked by the app developer)
* ```sound``` (plays a given sound  - no iOS API needs to be invoked by the app developer)
* ```badge``` (sets the value of the badge icon - no iOS API needs to be invoked by the app developer)
* ```content-available``` (iOS7 feature for submitting silent iOS notifications)
* ```action-category``` (iOS8 feature for interactive notifications)

#### Android special keys

None! The JSON map is submitted as it is, directly to the device. There are no Android specific keywords.

#### Cordova Android special keys

To make the user experience the same on iOS and Android, for cordova users, we use the iOS alert 'key' on Android as well to generate a notification for you. And we've introduced a 'title' that can optionally be used for the title of this notification, if none is specified the application name will be used like on iOS.

#### Windows special keys

For Windows we also support sending toast, tile, badge and raw notifications. For MPNS and WNS to keep the message uniform the first text for the message template is the value from alert and for a numeric badge we use the main badge field. Of course you could add criteria to only select Windows devices. If you don't specify the Windows section of the message a toast notification is send with the alert as the content. More information about the [windows message format](windows-document-format/)

### SimplePush Object

For SimplePush an extra ```simple-push``` object is provided. This key is only used for SimplePush variants. The version is submitted to all connected client, that are subscribed on their matching channels.

### Query component

Currently the Server will support the following query criteria:

* ```variants```: A list of one or more _mobile variant ID's_ to identify a particular PushApplication variant (e.g. HR Android, HR iPad).
* ```alias```: A list of one or more _identifiers_ (such as ```email``` or ```username```) to send messages to *ALL* devices of the user(s). The ```alias``` needs to be stored, when the device is registering itself with the server.
* ```categories```: Helps to _tag_ the current client with multiple categories. Gives a semantic meaning to a registered ```Installation```.
* ```deviceType```: A list of raw device types that should receive the message (e.g. Coupon only for iPad and AndroidTablets). The ```deviceType``` needs to be stored when the device is registering itself with the server.

_**NOTE:**_ All these query criterias are optionnal. If no criterias are passed it will act as a  _broadcast_ send, where _all_ clients are notified. 
