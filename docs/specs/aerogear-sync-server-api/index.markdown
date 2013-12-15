---
layout: basic
title: AeroGear Data Sync
---

# Status: Experimental

# Couch DB Protocol 


Create a database:

    curl -X PUT http://127.0.0.1:5984/agsync
    {"ok":true}

Get a uuid:

    curl -X GET http://127.0.0.1:5984/_uuids
    {"uuids":["f11075199bcea80849204660d7000d53"]}

Create a car object(document) using the above uuid:

    curl -X PUT http://127.0.0.1:5984/agsync/f11075199bcea80849204660d7000d53 -d '{"car": {"make":"Toyota", "color":"red"}}'
    {"ok":true,"id":"f11075199bcea80849204660d7000d53","rev":"1-dffbd1dbd1b9ecbffc1b02a34cbaea0b"}

Notice that the server returned a new document revision.

Now clientA updates the car object, notice that we are specifying the document revision:

    curl -X PUT http://127.0.0.1:5984/agsync/f11075199bcea80849204660d7000d53 -d '{"_rev":"1-dffbd1dbd1b9ecbffc1b02a34cbaea0b", "car": {"make":"Toyota","color":"blue"}}'
    {"ok":true,"id":"f11075199bcea80849204660d7000d53","rev":"2-588a9da2e252e9a3d2fc0634610a0c25"}

Also, notice how the server returned a new document revision.

Now, clientB still has the old revision and tries to update the car object:

    curl -v -X PUT http://127.0.0.1:5984/agsync/f11075199bcea80849204660d7000d53 -d '{"_rev":"1-dffbd1dbd1b9ecbffc1b02a34cbaea0b", "car": {"make":"Toyota","color":"yellow"}}'
    < HTTP/1.1 409 Conflict
    {"error":"conflict","reason":"Document update conflict."}
    This conflict would the have to be handled by the client. Could we start out with something similar and as simple as this and evolve it?  

# Summersp's Unified Push Sync notifications

My idea is to send out a message using unified push.  

The message should have a key which identifies what type of data is being synchronized (it doesn't matter what the key is as long as it is the same for all clients of the application).

    UnifiedMessage unifiedMessage = new UnifiedMessage.Builder()
    .pushApplicationId("66ebc03c-55d7-428d-8dc5-95e800c03f1f")
    .masterSecret("f9bd9ff9-0d62-4882-949e-6351815817d8")
    .aliases(Arrays.asList(user.getEmail()))
    .attribute("org.devnexus.sync.UserCalendar", "true")
    .build();

In this case, the key is "org.devnexus.sync.UserCalendar".  The client's message handlers will check for this key and run a `loadRemoteChanges` on the synchronizer which corresponds to "org.devnexus.sync.UserCalendar".
