---
layout: base-text-page
title: Get started with AeroGear.js
nav-active-getstarted: active
section-title: Guides
section-description: Tutorials to help get you off and running.
breadcrumbs-url: /getstarted/guides/
sub-section-title: Get started
section-class: guides
---


## Get Started With AeroGear.js


This article is going to show how to get started creating an HTML5 + Rest application using the AeroGear.js Javascript library.  This guide builds upon what you have learned in the [Get Started With HTML5 Mobile Web Development with JBoss](./GetStartedHTML5MobileWeb/) guide.

Topics Covered:

* What is a Pipeline?
* What is a Pipe?
* What is a DataManager?
* What is a Store?

## Prerequisites

* Java 6.0(Java SDK 1.6)+
* Maven 3+
* JBoss Application Server 7.1+
* JBoss Tools 3.3(optional)

An HTML5 compatible browser is required such as Chrome, Safari 5+, Firefox 5+, or IE 9+, and note that some behaviors will vary slightly (ex. validations) based on browser support, especially IE 9. For more details on AeroGear’s target browser support see [AeroGear Browser Support Targets](./AeroGearBrowserTargets/).

Mobile web support is limited to Android and iOS devices for now, however it should run on HP, and BlackBerry devices as well. Windows Phone, and others will work as jQuery Mobile announces support.

### Get The Example Code

To get started, if you are using git, you should clone a copy of the example

    $ git clone git@github.com:aerogear/kitchensink-aerogear-js.git && cd kitchensink-aerogear-js

If you are not using git, you can download the example from [here](https://github.com/aerogear/kitchensink-aerogear-js/archive/master.zip)

### Deploying

To deploy the application, first you will need to start up the JBoss Container.  To do this, run:

On linux/OSX

    $JBOSS_HOME/bin/standalone.sh -b 0.0.0.0

On Windows

    $JBOSS_HOME\bin\standalone.bat -b 0.0.0.0

_Note: Adding -b 0.0.0.0 to the above commands will allow external clients (phones, tablets, desktops, etc…) connect through your local network._

Once the JBoss Container is started, you can then run this command to build and deploy the application:

    $ mvn clean package jboss-as:deploy

Assuming the defaults, the application will now be running at [http://localhost:8080/jboss-as-kitchensink-aerogear-js/](http://localhost:8080/jboss-as-kitchensink-aerogear-js/)

If you followed the [Get Started With HTML5 Mobile Web Development with JBoss](./GetStartedHTML5MobileWeb/) guide,  you shouldn't see a difference in the User Interface.  The real difference is under the hood.

Lets dive in!

### Pipeline & Pipes

A Pipeline is a JavaScript library that provides a persistence API that is protocol agnostic and does not depend on any certain data model. Through the use of adapters, both provided and custom, user supplied, this library provides common methods like read, save and delete that will just work.

A Pipe is one server connection.  The default adapter is using the REST protocol.

To expand on this concept, lets look "under the hood" and see how this works.

    var memberPipe  = AeroGear.Pipeline([{
        name: "members",
        settings: {
            baseURL: "rest/"
        }
    }
 ]).pipes.members;


Whats happening here?  We are calling the Pipeline constructor with an array of objects as it's arguments.  In this case, it is just one object.

The object which will become a pipe.  We see that it has a name property and a settings object where we are overriding the baseURL property.  By default Pipes use the name property as the endpoint and baseURL for the REST service.  In this case, we are overriding the baseURL, so our REST call would look something like this:

    http://localhost/application_name/rest/members


### Data Manager & Stores

A Data Manager is a collection of data connections (stores) and their corresponding data models. This object provides a standard way to interact with client side data no matter the data format or storage mechanism used.


    var dm = AeroGear.DataManager( "membersStore" ),
        MemberStore = dm.stores["membersStore"];

Whats happening here?  Similar to the Pipeline and Pipe constructor,  we are creating a DataManager with a default Store( memory ) and then assigning that store to a variable for later use.

### Putting it together

Now that we have a little background on Pipeline and Data Manager, lets see how they work together in our application.

To get the list of members from the server, all we need to do is use the read() method on our pipe.

        memberPipe.read({
            success: function( data ) {
                ...
                $( "#members" ).html( buildMemberRows() );
            }
        });

Since our pipe is using the default REST adapter and we have overridden the baseURL property, the read method will make a request to http://localhost:8080/js-kitchensink/rest/members

We specify a success callback( an error callback should also be added ) and in the callback we add our data from the response to the MemberStore.

    MemberStore.save( data );

To access our data from the store, all we need to do is call the read() method on the store

    return _.template( $( "#member-tmpl" ).html(), {"members": MemberStore.read()});

We are using the default "Memory" adapter for our store, which is just an array.

## Wrapping Up

This tutorial is only a small part of what AeroGear.js can do.  Stay tuned for more Getting started guides.


