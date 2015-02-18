---
layout: post
title: AeroGear Sync alpha.1 release is out
---

This is the first alpha release of [AeroGear Sync](https://aerogear.org/sync/) which is an implementation of Google's 
[Differential Synchonrization](http://research.google.com/pubs/pub35605.html) by Neil Fraser which provides full real-time data synchronization, 
where updates are initiated from both the client and server side over a bi-directional channel. 
This release provides both, server side sync engines, as well as a client side sync engines for Android, iOS and JavaScript. 

#### Servers
[Java](https://github.com/aerogear/aerogear-sync-server)  
[Node.js](https://github.com/aerogear/aerogear-nodejs-sync-server)

#### Client libraries
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
[Java Server](https://github.com/aerogear/aerogear-sync-server/server/server-netty)    
[Node.js Server](https://github.com/aerogear/aerogear-nodejs-sync-server)


## Documentation
For more details about the current release, please consult [our documentation](http://aerogear.org/sync).

### Resources
* [Differential Synchronization presentation](https://www.youtube.com/watch?v=S2Hp_1jqpY8)
* [Differential Synchronization paper](http://research.google.com/pubs/pub35605.html)
* [Differential Synchronization step by step keynote presentation](https://www.icloud.com/iw/#keynote/BAKHgqmqd5ETPe9ebKyBhSINoBo1QHaNPYeF/diffsync)

# What's next? 
* Client library for Windows. 
* More alpha releases as we continue developing the server and clients. 
