---
layout: basic
title: AeroGear Data Sync
---
# Status: Experimental

# Goals

- TBD

# References

- [CouchDB data model](http://wiki.apache.org/couchdb/EntityRelationship)

# Implementation

- [AeroGear Sync Server](https://github.com/aerogear/aerogear-sync-server)

# Scenarios

- TBD

# API specification

This document defines a common API for each mobile platform to make sure that everyone will be speaking about the same domain/vocabulary. 

## Levels

As soon as we have a rough data-model defined, we can start dabbling around different API levels to be served:

- level 0: explodes when there's a conflict
- level 1: semi-automatic conflict resolution via something like google's diff-match-patch
- level 2: business rules determine who wins a conflicting update (supervisor wins over normal user)

All those proposed API operations should be serializable, meaning I can potentially keep doing changes offline then just replying them to the server when online.

## Data model
* [Data Format](aerogear-sync-data-format)

## Consistency

These are the most basic parts of sync I can think of that our system should be able to do/manage.  Our internal representation of the client documents and collections should make implementing this automatically and without user intervention as simple as possible

* Detect Change

    When a user changes her local data, the system should note the change and generate a sync message to send to the server.  This can be done automatically or manually but SHOULD be done automatically.

* Send update

     When a sync message is ready to be sent, and the system allows for it to be sent (network available, not in blackout window from exponential backoff, etc) then sync message should be sent. This being done automatically should be the default, but the developer can override this behavior.

* Receive Update

    When a client updates it data and successfully syncs to the remote server, the remote server will notify all of the relevant clients. The client must automatically and without user intervention receive this update and either act on it or store it for later processing.

* Apply Update

    Once a client application has an update message from the server, it can apply the message correctly to the data on it.  This should be done automatically as part of receiving the update, but it may be done manually or may be delayed and automatically executed later.

* Detect Conflict

    When applying an update fails, the system must detect this.  The system will provide state to the application and/or the user to handle the conflict.  The user MUST NOT have to check for conflicts on her own.

* Resolve Conflict

    There must be a mechanism for resolving a conflict.  The CAN be done automatically using default resolvers provided by AeroGear, by using a resolver provided by the developer/user, or by the app user selecting the correct merge.  This will possibly generate a new sync message.

### JS

volunteers needed ;)

### Java

volunteers needed ;)

### Objective-C

volunteers needed ;)

## Transport

Since we know about the future-looking ideas on v2.0, it would be really nice for us to specify a very simple/dumb JSON-based protocol for those change messages. Something that could accomodate both the full document updates and the OT/EC incremental bits too. 

- TBD 

# AeroGear.next

- Realtime data sync
- Update policies
- Advanced levels of the API
    - level 3: real-time updates via diff-match-patch
    - level 4: real-time updates via OT/EC

# Appendix Use Cases:

Here are a few contrived use cases that we may want to keep in mind.

1.  Legacy Bug Trackers From Hell

    a.  It is a webapp written in COBOL, no one will ever EVER update or 
change the code

      b.  It has TONS of legacy but important data

      c.  It has TONS of users

      d.  It only has a few transactions per day, all creating and updating 
bug reports

      e. Multiple users can edit the same report


2.  Slacker Gallery

      a.  Each User has a multiple galleries, each gallery has multiple photos

      b.  A Gallery has only one user, but the user may be on multiple devices

      c.  Galleries may be renamed, created, and deleted

      d.  Photos may only be created or deleted.  Photos also have meta data 
which may be updated, but its creation and deletion is tied to the Photo 
object.


3.  Dropbox clone

      a.  A folder of files may be shared among users

      b.  There is a size limit to files and how much storage may be used 
per folder

      c.  Files are not updated.  If there is a new file, there is an atomic 
delete and create operation


4.  Email client

       a.  This is an AG-controller which accesses a mail account.

       b.  There are mobile offline and sync enabled clients which connect 
to this controller.


5.  Google Docs clone

       a. Operational Transform out the wazzoo

       b.  What would the server need?

       c.  What would the client need?


6.  Building Inspector app

Building inspector system - we have mobile apps that store relevant info and are bound to be accessed on places where we won't have any kind of connection, or very poor signal.

You can have several inspectors screening the same building simultaneously.

Let's say we have Agnes and Joe are doing the fire extinguisher inspection in a new hospital building. Technically each fire extinguisher has its own identifier and can be an independent document. In this case we would have no conflict happening.

Now they start finding expired fire extinguishers and start to add them to the report. This report could potentially have two divergent lists of fire extinguishers to be replenished/revalidated, as the building's compliance status.

7. Census App

Census system - we have mobile apps focused on offline data collection. We have the previous year's info that needs to be updated on the server. The interviewee needs to take a call, then asks the interviewer to come back later. This results in two sets of changes for the same document, stacked together, which should work flawlessly.

## Reference (Open Source) Products:

- Wave-in-a-box

- CouchDB

- Google Drive RealtimeAPI

- [diff-merge-patch algorithm](http://code.google.com/p/google-diff-match-patch/)

- [Summers' Realtime Sync Demo](http://www.youtube.com/watch?v=WEkZGbVk4Lc)

- [Summers' Devnexus Sync Demo](https://plus.google.com/103442292643366117394/posts/HGVHwtPArPW)

- Google Android Sync Architecture



