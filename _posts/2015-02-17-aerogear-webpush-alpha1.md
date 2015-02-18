---
layout: post
title: AeroGear WebPush
---

[AeroGear WebPush](https://github.com/aerogear/aerogear-webpush-server#aerogear-webpush-server-) alpha1 is a proof of concept implementation of the 
[WebPush Protocol](http://tools.ietf.org/html/draft-thomson-webpush-http2-02) specification with the purpose of gaining a better understanding of the specification. 

As you might have guessed from the name this is about push notifications and is related to the [Push API](https://w3c.github.io/push-api/index.html). 
In brief, it allows a device to maintain a single HTTP/2 connect which can service as many client applications as needed. For example, when used in combination with the Push API 
a [service worker](http://www.html5rocks.com/en/tutorials/service-worker/introduction/) will handle the registration to the WebPush Server and manage the subscriptions for the 
applications. An application would in this case be tab in a web browser. 

Apart from using less resources, in the form of one connection per browser instead of one per application, it also enables the service worker to receive notifications even if the target application of those notifications is not currently active. The service worker can take various actions when this situation occurs, like post a message to an open window to inform the user of the notification. For more details please refer to the [Push API](https://w3c.github.io/push-api/index.html). 

The AeroGear WebPush Server is an implementation of the WebPush specification. There are still some things left to be fully compliant with the specification, but the specification is also not final so we expect more things to change in the following months. 

Thought not part of the WebPush specification itself there is a companion specification named [webpush-aggregate](http://tools.ietf.org/html/draft-thomson-webpush-aggregate-00). This specification allows an application to request that a web push server deliver the same message to a potentially large set of devices. This is supported by AeroGear WebPush Server and also supported in the WebPush Console (see below) with the [aggregate command](https://github.com/aerogear/aerogear-webpush-server/tree/master/console#webpush-aggregate-extension). 

## WebPush Console
While developing the server we struggled to find a WebPush API implementation to test the server with. To help test the funcationality of the server we created a [console based application](https://github.com/aerogear/aerogear-webpush-server/tree/master/console#using-the-webpush-console) that enable to interact with the server and inspect the HTTP/2 headers sent and received from the server. This allowed us to not only try out our own server but also test the [node-webpush-server](https://github.com/kitcambridge/node-webpush-server). 

## What's next?
We will be following the specification and trying to keep the server and the console up to date.

