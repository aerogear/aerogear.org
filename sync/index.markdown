---
layout: landing-page
title: AeroGear Data-Sync
section: modules
breadcrumbs-url: /modules/
sub-section-title: AeroGear Sync
---

  <h1><i class="fa fa-refresh"></i> AeroGear<strong>Sync</strong></h1>
  <p class="alt">Real-time, client-server data synchronization with ease and efficiency. <span class="label label-warning">In Development</span></p>

  <p>
    <a href="/getstarted/downloads/" class="btn btn-primary-inverse btn-lg"><i class="fa fa-hand-o-right"></i> Get started</a>
    <a href="https://github.com/aerogear/?query=sync" class="btn btn-primary btn-sm"><i class="fa fa-github-alt"></i> GitHub Repos</a>
    <a href="/docs/planning/" class="btn btn-primary btn-sm"><i class="fa fa-road"></i> RoadMap</a>
  </p>


Full real-time data sync where updates are initiated from both the client and server over a bi-directional channel. This feature provides both, a specific server side sync engine, as well as a client side sync engines for Android, iOS and JavaScript. The implementation is based on Google's [Differential Synchonrization](http://research.google.com/pubs/pub35605.html) by Neil Fraser.


<h2 id="roadmap"><i class="fa fa-road"></i> RoadMap</h2>

The AeroGear Data-Sync effort started out of a POC and we are now moving towards a first alpha release. 

[List of sync-1.0.0.alpha.1 JIRA tickets](https://issues.jboss.org/issues/?filter=12323088)


<h2 id="spec"><i class="fa fa-book"></i> Specification</h2>

The specification for AeroGear Data-Sync including client/server API, message format and more can be found here:  
[Data-Sync Specification](../docs/specs/aerogear-data-sync)


<h2 id="development"><i class="fa fa-flask"></i> Development</h2>

Below are the various GitHub repositories that are part of the Data-Sync feature in AeroGear.


<h3><i class="fa fa-server"></i> Data-Sync Server</h3>

Our Netty-based [Java Server](https://github.com/aerogear/aerogear-sync-server) exposes WebSocket and XMPP/GCM endpoint for our different clients.


<h3><i class="fa fa-android"></i> Android</h3>

An [XMPP-client library](https://github.com/aerogear/aerogear-android-sync) to receive sync updates over GCM.



<h3><i class="fa fa-apple"></i> iOS</h3>

For iOS we have two different libraries that are developed:

* [Differential Synchronization Client Engine](https://github.com/aerogear/aerogear-ios-sync)
* [WebSocket-based Diff-Sync client](https://github.com/aerogear/aerogear-ios-sync-client)

The initial releases of the libraries are available on [CocoaPods](http://cocoapods.org/?q=AeroGearSync) as well.

Besides the libraries we do already have a little [demo application](https://github.com/aerogear/aerogear-ios-sync-demo), which can be used against the above Java server.



<h3><i class="fa fa-html5"></i> JavaScript</h3>

The JavaScript client comes with a WebSocket-based library as well. There is also a Node.js based demo, which can be used against the above Java server.

Currently our JS library and demo is located [here](https://github.com/aerogear/aerogear-sync-server/tree/master/js-client).



<h2 id="get-involved"><i class="fa fa-users"></i> Get Involved</h2>

If you are interested, feel free to fork the repositories and get your hands dirty. Also, feel free to reach out to us if you have any [questions](/community)!
