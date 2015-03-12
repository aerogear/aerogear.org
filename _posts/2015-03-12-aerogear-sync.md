---
layout: post
title: AeroGear Sync alpha.1 release is out
---

This is the first alpha release of [AeroGear Sync](https://aerogear.org/sync/) which is an implementation of Google's  [Differential Synchonrization](http://research.google.com/pubs/pub35605.html) by Neil Fraser which provides full real-time data synchronization,  where updates are initiated from both the client and server side over a bi-directional channel.  This release provides both, server side sync engines, as well as a java client side sync engine.

#### Servers

Our server is written in [Java](https://github.com/aerogear/aerogear-sync-server) and provides three different synchronization algorithms:

* DiffMatchPatch
* JsonMergePatch
* JsonPatch

On our Github repository we have uploaded a [distribution](https://github.com/aerogear/aerogear-sync-server/releases/tag/1.0.0-alpha.1) that contains executable JAR files for these different server flavors.

The _JSON Patch_ version of the server is also available as a WAR file and can be also deployed on [WildFly](https://github.com/aerogear/aerogear-sync-server/tree/master/server/server-wildfly).

#### Client libraries

Based on this release there are different client implementations, powered by AeroGear.

[Android](https://github.com/aerogear/aerogear-android-sync)  
[JavaScript](https://github.com/aerogear/aerogear-js)  
[iOS](https://github.com/aerogear/aerogear-ios-sync-client)


### Demo application
As part of this release we are providing a simple demo application that is based around Luke Skywalker and his hobbies.  
[Android demo](https://github.com/aerogear/aerogear-android-cookbook)   
[JavaScript demo](https://github.com/aerogear/aerogear-js-cookbook)   
[iOS demo](https://github.com/aerogear/aerogear-ios-cookbook)

To run the above demo applications you'll need one of the sync servers running, please refer to the links below for instructions about how to 
start the servers.  
[Java Server](https://github.com/aerogear/aerogear-sync-server/releases/tag/1.0.0-alpha.1)

#### See it in Action

We also have a little screencast, showing the demo

<center>
	<iframe src="https://player.vimeo.com/video/121332828" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
</center>

## Documentation
For more details about the current release, please consult [our documentation](http://aerogear.org/sync).

### Resources
* [Differential Synchronization presentation](https://www.youtube.com/watch?v=S2Hp_1jqpY8)
* [Differential Synchronization paper](http://research.google.com/pubs/pub35605.html)
* [Differential Synchronization step by step keynote presentation](https://www.icloud.com/iw/#keynote/BAKHgqmqd5ETPe9ebKyBhSINoBo1QHaNPYeF/diffsync)

# What's next? 
* Client library for Windows. 
* More alpha releases as we continue developing the server and clients. 
* [Node.js based Sync Server](https://github.com/aerogear/aerogear-nodejs-sync-server)
