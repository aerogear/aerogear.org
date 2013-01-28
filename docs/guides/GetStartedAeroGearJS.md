---
layout: basic
title: Get started with AeroGear.js
---


## Get Started With AeroGear.js


This article is going to show how to get started creating a HTML5 + Rest application using the AeroGear.js Javascript library.  This guide builds upon what you have learned in the [Get Started With HTML5 Mobile Web Development with JBoss](../GetStartedHTML5MobileWeb/) guide.

Topics Covered:

*What is a Pipeline?
*What is a Pipe?
*What is a DataManager?
*What is a Store?

## Prerequisites

*Java 6.0(Java SDK 1.6)+
*Maven 3+
*JBoss Application Server 7.1+
*JBoss Tools 3.3(optional)

An HTML5 compatible browser is required such as Chrome, Safari 5+, Firefox 5+, or IE 9+, and note that some behaviors will vary slightly (ex. validations) based on browser support, especially IE 9. For more details on AeroGear’s target browser support see AeroGear Browser Support Targets.

Mobile web support is limited to Android and iOS devices for now, however it should run on HP, and Black Berry devices as well. Windows Phone, and others will work as jQuery Mobile announces support.

### Get The Example Code

To get started, if you are using git, you should clone a copy of the example

    $ git clone git://dflsjowijowjf.git && cd directory

If you are not using git, you can download the example from here [link]()

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

If you followed the [Get Started With HTML5 Mobile Web Development with JBoss](../GetStartedHTML5MobileWeb/) guide,  you shouldn't see a difference in the User Interface.  The real difference is under the hood.

Lets dive in!

### Pipeline

Pipeline is a JavaScript library that provides a persistence API that is protocol agnostic and does not depend on any certain data model. Through the use of adapters, both provided and custom, user supplied, this library provides common methods like read, save and delete that will just work.

To expand on this concept, lets look "under the hood" and see how this works.

    var memberPipe  = AeroGear.Pipeline([{
        name: "members",
        settings: {
            baseURL: "rest/"
        }
    }
 ]).pipes.members;



### Data Manager

A collection of data connections (stores) and their corresponding data models. This object provides a standard way to interact with client side data no matter the data format or storage mechanism used.


    var dm = AeroGear.DataManager("membersStore"),
    MemberStore = dm.stores["membersStore"];


### Putting it together

Now that we have a little background on Pipeline and Data Manager, lets see how they work together in our application.

To get the list of members from the server, all we need to do is use the read() method on our pipe.

        memberPipe.read({
            success: function( data ) {
                $('#members').empty().append(buildMemberRows());
            },
            stores: MemberStore
        });

Since our pipe is using the default REST adapter and we have overridden the baseURL property, the read method will make a request to http://localhost:8080/js-kitchensink/rest/members

We specify a success callback( an error callback can also be added ), and also specify the store from the Data Manager we want to use for this pipe( this will be populated with the data from the servers response ).

To access our data from the store, all we need to do is call the read() method on the store

    return _.template( $( "#member-tmpl" ).html(), {"members": MemberStore.read()});

We are using the default "Memory" adapter for our store, which is just an array.

To save data to the server all we need to do is call the pipes save() method

    memberPipe.save( memberData, {
        success: function( data ) { ... },
        error: function( error ) { ... }
    })


